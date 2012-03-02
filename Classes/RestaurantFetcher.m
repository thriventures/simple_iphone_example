//
//  RestaurantFetcher.m
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2012 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import "RestaurantFetcher.h"

#import "Restaurant.h"
#import "NSObject+YAJL.h"


@implementation RestaurantFetcher

@synthesize managedObjectContext;
@synthesize delegate;

#pragma mark -
#pragma mark NSObject

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext {
  if (self = [super init]) {
    connection = nil;
    responseData = nil;
    delegate = nil;
    
    self.managedObjectContext = aManagedObjectContext;
  }
  
  return self;
}

- (void)dealloc {
  delegate = nil;
  
  [connection cancel];
  
  
  
}

#pragma mark -
#pragma mark Helpers

- (void)downloadRestaurants {
  if (connection) {
    [connection cancel];
  }
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:StorageRoomURL(@"/collections/4d960916ba05617333000005/entries?per_page=100")]];
  NSMutableDictionary *headers = [NSMutableDictionary dictionary];
  [headers setObject:@"StorageRoomExample iPhone" forKey:@"User-Agent"];	
  [headers setObject:@"application/json" forKey:@"Accept"];
  [headers setObject:@"application/json" forKey:@"Content-Type"];
  
  [request setAllHTTPHeaderFields:headers];
  
  responseData = [[NSMutableData alloc] init];
  connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  
  if ([delegate respondsToSelector:@selector(restaurantFetcherDidStartDownload:)]) {
    [delegate performSelector:@selector(restaurantFetcherDidStartDownload:) withObject:self];
  }
}

- (void)removeAllRestaurantsFromManagedObjectContext {
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	fetchRequest.entity = [NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:managedObjectContext];
	
	NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
	
  NSLog(@"Removing %d existing restaurants", [results count]);
  
	for (Restaurant *restaurant in results) {
		[managedObjectContext deleteObject:restaurant];
	}
}

#pragma mark -
#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)response {
  [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data {
  [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error {
  NSLog(@"Error while downloading restaurants: %@", error);
  
  if ([delegate respondsToSelector:@selector(restaurantFetcher:didFailWithError:)]) {
    [delegate performSelector:@selector(restaurantFetcher:didFailWithError:) withObject:self withObject:error];
  }  
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
  NSLog(@"Downloading restaurants successful");
  
  NSString *content = [[NSString alloc]  initWithBytes:[responseData bytes] length:[responseData length] encoding:NSUTF8StringEncoding];
  
  @try {
    NSDictionary *json = [content yajl_JSON];
    NSDictionary *resources = (NSDictionary *)[json objectForKey:@"array"];
    NSArray *arrayOfRestaurantDictionaries = (NSArray *)[resources objectForKey:@"resources"];
    
    [self removeAllRestaurantsFromManagedObjectContext];
    
    for(NSDictionary *d in arrayOfRestaurantDictionaries) {    
      Restaurant *restaurant = (Restaurant *)[NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:managedObjectContext];
      [restaurant setWithJSONDictionary:d];
    }
    
    NSError *error;
    if (![managedObjectContext save:&error]) {
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
        
    if ([delegate respondsToSelector:@selector(restaurantFetcherDidFinishDownload:)]) {
      [delegate performSelector:@selector(restaurantFetcherDidFinishDownload:) withObject:self];
    }
  }
  @catch (NSException *e) {
    NSLog(@"Error while parsing JSON and setting restaurants");
    
    if ([delegate respondsToSelector:@selector(restaurantFetcher:didFailWithError:)]) {
      NSError *error = [NSError errorWithDomain:@"StorageRoomExample" code:2 userInfo:nil];
      [delegate performSelector:@selector(restaurantFetcher:didFailWithError:) withObject:self withObject:error];
    } 
  }
  @finally {
    content = nil;
  }
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
  if (challenge.previousFailureCount == 0) {
    NSLog(@"Received authentication challenge");
    
    NSURLCredential *newCredential =[NSURLCredential credentialWithUser:StorageRoomAPIKey password:@"X" persistence:NSURLCredentialPersistenceForSession];
    
    [challenge.sender useCredential:newCredential forAuthenticationChallenge:challenge];    
  }
  else {
    if ([delegate respondsToSelector:@selector(restaurantFetcher:didFailWithError:)]) {
      NSError *error = [NSError errorWithDomain:@"StorageRoomExample" code:3 userInfo:nil];
      [delegate performSelector:@selector(restaurantFetcher:didFailWithError:) withObject:self withObject:error];
    } 
  }
}


@end
