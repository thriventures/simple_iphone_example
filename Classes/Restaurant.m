// 
//  Restaurant.m
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). All rights reserved.
//

#import "Restaurant.h"

#import "ISO8601DateFormatter.h"

@implementation Restaurant 

@dynamic updatedAt;
@dynamic openingTimes;
@dynamic longitude;
@dynamic latitude;
@dynamic priceRange;
@dynamic vegetarianMenu;
@dynamic lastVisit;
@dynamic stars;
@dynamic imageURL;
@dynamic text;
@dynamic createdAt;
@dynamic name;
@dynamic previewImageURL;

- (void)setWithJSONDictionary:(NSDictionary *)aDictionary {
  self.name = [aDictionary objectForKey:@"name"];
  self.text = [aDictionary objectForKey:@"text"];
  self.openingTimes = [aDictionary objectForKey:@"opening_times"];
  
  self.priceRange = [aDictionary objectForKey:@"price_range"];
  self.stars = [aDictionary objectForKey:@"stars"];
  self.vegetarianMenu = [aDictionary objectForKey:@"vegetarian_menu"];
  
  NSDictionary *location = [aDictionary objectForKey:@"location"];
  self.latitude = [location objectForKey:@"lat"];
  self.longitude = [location objectForKey:@"lng"];
  
  NSDictionary *image = [aDictionary objectForKey:@"image"];
  self.imageURL = [image objectForKey:@"url"];
  
  NSDictionary *previewImage = [aDictionary objectForKey:@"preview_image"];
  self.previewImageURL = [previewImage objectForKey:@"url"];
  
  ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
  
  self.lastVisit = [formatter dateFromString:[aDictionary objectForKey:@"last_visit"]];
  
  self.createdAt = [formatter dateFromString:[aDictionary objectForKey:@"@created_at"]];
  self.updatedAt = [formatter dateFromString:[aDictionary objectForKey:@"@updated_at"]];
  
  [formatter release];
}


- (CLLocationCoordinate2D)coordinate {
  CLLocationCoordinate2D center;
  center.latitude  = [self.latitude doubleValue];
  center.longitude = [self.longitude doubleValue];
  
  return center;
}

@end
