//
//  StorageRoomExampleAppDelegate.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/8/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StorageRoomExampleAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {

  NSManagedObjectModel *managedObjectModel;
  NSManagedObjectContext *managedObjectContext;
  NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

- (NSString *)applicationDocumentsDirectory;

@end
