// 
//  Restaurant.m
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import "Restaurant.h"

#import "ISO8601DateFormatter.h"

@implementation Restaurant 

@dynamic updatedAt;
@dynamic address;
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

#pragma mark -
#pragma mark Helpers

- (void)setWithJSONDictionary:(NSDictionary *)aDictionary {
  self.name = NilOrValue([aDictionary objectForKey:@"name"]);
  self.text = NilOrValue([aDictionary objectForKey:@"text"]);
  self.address = NilOrValue([aDictionary objectForKey:@"address"]);
  
  self.priceRange = NilOrValue([aDictionary objectForKey:@"price_range"]);
  self.stars = NilOrValue([aDictionary objectForKey:@"stars"]);
  self.vegetarianMenu = NilOrValue([aDictionary objectForKey:@"vegetarian_menu"]);
  
  NSDictionary *location = [aDictionary objectForKey:@"location"];
  self.latitude = NilOrValue([location objectForKey:@"lat"]);
  self.longitude = NilOrValue([location objectForKey:@"lng"]);
  
  NSDictionary *image = [aDictionary objectForKey:@"image"];
  if ((NSNull *)image != [NSNull null]) {
    self.imageURL = NilOrValue([image objectForKey:@"url"]);
  }
  
  NSDictionary *previewImage = [aDictionary objectForKey:@"preview_image"];
  if ((NSNull *)previewImage != [NSNull null]) {
    self.previewImageURL = NilOrValue([previewImage objectForKey:@"url"]);
  }
  
  ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
  
  self.lastVisit = [formatter dateFromString:[aDictionary objectForKey:@"last_visit"]];
  
  self.createdAt = [formatter dateFromString:[aDictionary objectForKey:@"@created_at"]];
  self.updatedAt = [formatter dateFromString:[aDictionary objectForKey:@"@updated_at"]];
  
  [formatter release];
}

#pragma mark -
#pragma mark MKAnnotation Protocol

- (NSString *)title {
  return self.name;
}

- (NSString *)subtitle {
  return nil;
}

- (CLLocationCoordinate2D)coordinate {
  CLLocationCoordinate2D center;
  center.latitude  = [self.latitude doubleValue];
  center.longitude = [self.longitude doubleValue];
  
  return center;
}

@end
