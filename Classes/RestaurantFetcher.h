//
//  RestaurantFetcher.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). All rights reserved.
//



@interface RestaurantFetcher : NSObject {
  NSURLConnection *connection;
  NSMutableData *responseData;
  
  NSManagedObjectContext *managedObjectContext;
  
  id delegate;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

- (void)downloadRestaurants;
- (void)removeAllRestaurantsFromManagedObjectContext;

@end

