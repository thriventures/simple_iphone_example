//
//  AnnouncementFetcher.m
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/11/10.
//  Copyright 2010 __MyCompanyName__. See LICENSE for details.
//

#import "AnnouncementFetcher.h"

#import "Announcement.h"
#import "NSObject+YAJL.h"

@implementation AnnouncementFetcher

@synthesize delegate, announcements;

#pragma mark -
#pragma mark NSObject

- (id)init {
  if ((self = [super init])) {
    connection = nil;
    responseData = nil;
    delegate = nil;    
  }
  
  return self;
}

- (void)dealloc {
  delegate = nil;
  
  [connection cancel];
  [connection release];
  
  [responseData release];
  
  self.announcements = nil;
    
	[super dealloc];
}

#pragma mark -
#pragma mark Helpers


- (void)downloadAnnouncements {
  if (responseData) {
    [responseData release];
  }
  if (connection) {
    [connection cancel];
    [connection release];
  }
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:StorageRoomURL(@"/collections/4d96091dba0561733300001b/entries?per_page=1&sort=@created_at&order=desc")]];
  NSMutableDictionary *headers = [NSMutableDictionary dictionary];
  [headers setObject:@"StorageRoomExample iPhone" forKey:@"User-Agent"];	
  [headers setObject:@"application/json" forKey:@"Accept"];
  [headers setObject:@"application/json" forKey:@"Content-Type"];
  
  [request setAllHTTPHeaderFields:headers];
  
  responseData = [[NSMutableData alloc] init];
  connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  
  if ([delegate respondsToSelector:@selector(announcementFetcherDidStartDownload:)]) {
    [delegate performSelector:@selector(announcementFetcherDidStartDownload:) withObject:self];
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
  NSLog(@"Error while downloading announcements: %@", error);
  
  if ([delegate respondsToSelector:@selector(announcementFetcher:didFailWithError:)]) {
    [delegate performSelector:@selector(announcementFetcher:didFailWithError:) withObject:self withObject:error];
  }  
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
  NSLog(@"Downloading announcements successful");
  
  NSString *content = [[NSString alloc]  initWithBytes:[responseData bytes] length:[responseData length] encoding:NSUTF8StringEncoding];
  
  @try {
    NSDictionary *json = [content yajl_JSON];
    NSDictionary *resources = (NSDictionary *)[json objectForKey:@"array"];
    NSArray *arrayOfAnnouncementDictionaries = (NSArray *)[resources objectForKey:@"resources"];
    self.announcements = [NSMutableArray array];
    
    for(NSDictionary *d in arrayOfAnnouncementDictionaries) {    
      Announcement *announcement = [[Announcement alloc] init];
      [announcement setWithJSONDictionary:d];
      [announcements addObject:announcement];
      [announcement release];
    }
        
    if ([delegate respondsToSelector:@selector(announcementFetcherDidFinishDownload:withAnnouncements:)]) {
      [delegate performSelector:@selector(announcementFetcherDidFinishDownload:withAnnouncements:) withObject:self withObject:announcements];
    }
  }
  @catch (NSException *e) {
    NSLog(@"Error while parsing JSON and setting announcements");
    
    if ([delegate respondsToSelector:@selector(announcementFetcher:didFailWithError:)]) {
      NSError *error = [NSError errorWithDomain:@"StorageRoomExample" code:2 userInfo:nil];
      [delegate performSelector:@selector(announcementFetcher:didFailWithError:) withObject:self withObject:error];
    } 
  }
  @finally {
    [content release];
  }
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
  if (challenge.previousFailureCount == 0) {
    NSLog(@"Received authentication challenge");
    
    NSURLCredential *newCredential =[NSURLCredential credentialWithUser:StorageRoomAPIKey password:@"X" persistence:NSURLCredentialPersistenceForSession];
    
    [challenge.sender useCredential:newCredential forAuthenticationChallenge:challenge];    
  }
  else {
    if ([delegate respondsToSelector:@selector(announcementFetcher:didFailWithError:)]) {
      NSError *error = [NSError errorWithDomain:@"StorageRoomExample" code:3 userInfo:nil];
      [delegate performSelector:@selector(announcementFetcher:didFailWithError:) withObject:self withObject:error];
    } 
  }
}


@end
