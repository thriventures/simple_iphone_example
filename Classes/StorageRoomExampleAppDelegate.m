//
//  StorageRoomExampleAppDelegate.m
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/8/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import "StorageRoomExampleAppDelegate.h"


@implementation StorageRoomExampleAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize managedObjectModel, managedObjectContext, persistentStoreCoordinator;

#pragma mark -
#pragma mark NSObject

- (void)dealloc {
  [tabBarController release];
  [window release];
  
  [managedObjectContext release];
  [managedObjectModel release];
  [persistentStoreCoordinator release];
  
  [super dealloc];
}

#pragma mark -
#pragma mark Helper Methods

- (NSString *)applicationDocumentsDirectory {
  return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark -
#pragma mark Core Data Stack

- (NSManagedObjectContext *)managedObjectContext {
  if (!managedObjectContext) {    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
      managedObjectContext = [[NSManagedObjectContext alloc] init];
      managedObjectContext.persistentStoreCoordinator = coordinator;
    }
  }
  
  return managedObjectContext;
}


- (NSManagedObjectModel *)managedObjectModel {
  if (!managedObjectModel) {
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
  }
  
  return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  if (!persistentStoreCoordinator) {
    NSURL *storeUrl = [NSURL fileURLWithPath:[[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"Base.sqlite"]];
    
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];  
    
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {    
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      
      abort();
    } 
  }
  
  return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark UIApplication Delegate Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
  managedObjectModel = nil;
  managedObjectContext = nil;
  persistentStoreCoordinator = nil;
  
  [window addSubview:tabBarController.view];
  [window makeKeyAndVisible];

  return YES;
}


@end



