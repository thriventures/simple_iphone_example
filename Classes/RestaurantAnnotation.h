//
//  RestaurantAnnotation.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import <MapKit/MapKit.h>

@class Restaurant;

@interface RestaurantAnnotation : NSObject <MKAnnotation> {  
  Restaurant *restaurant;
}

@property (nonatomic, retain) Restaurant *restaurant;

- (id)initWithRestaurant:(Restaurant *)aRestaurant;

@end