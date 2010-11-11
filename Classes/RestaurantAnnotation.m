//
//  RestaurantAnnotation.m
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). All rights reserved.
//

#import "RestaurantAnnotation.h"

#import "Restaurant.h"

@implementation RestaurantAnnotation

@synthesize restaurant;

- (id)init {
	if(self = [super init]) {
		restaurant = nil;
	}
	
	return self;
}

- (id)initWithRestaurant:(Restaurant *)aRestaurant {
  if(self = [self init]) {
    self.restaurant = aRestaurant;
  }
  
  return self;
}

- (void)dealloc {
	self.restaurant = nil;
	
	[super dealloc];
}

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
