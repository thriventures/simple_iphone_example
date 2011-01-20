//
//  RestaurantAnnotation.m
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import "RestaurantAnnotation.h"

#import "Restaurant.h"

@implementation RestaurantAnnotation

@synthesize restaurant;

#pragma mark -
#pragma mark NSObject

- (id)initWithRestaurant:(Restaurant *)aRestaurant {
  if(self = [super init]) {
    self.restaurant = aRestaurant;
  }
  
  return self;
}

- (void)dealloc {
	self.restaurant = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark MKAnnotation Protocol

- (NSString *)title {
  return restaurant.name;
}

- (NSString *)subtitle {
  return nil;
}

- (CLLocationCoordinate2D)coordinate {
  return [restaurant coordinate];
}


@end
