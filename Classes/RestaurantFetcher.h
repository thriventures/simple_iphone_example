//
//  RestaurantFetcher.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2012 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//



@interface RestaurantFetcher : NSObject {
  NSURLConnection *connection;
  NSMutableData *responseData;

}

@property (nonatomic, weak) id delegate;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

- (void)downloadRestaurants;
- (void)removeAllRestaurantsFromManagedObjectContext;

@end

