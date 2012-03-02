//
//  RestaurantFetcher.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2012 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//


@interface RestaurantFetcher : NSObject {

}

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

- (void)downloadRestaurants;
- (void)removeAllRestaurantsFromManagedObjectContext;

@end

