//
//  Announcement.m
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import "Announcement.h"

#import "ISO8601DateFormatter.h"

@implementation Announcement

@synthesize text, url, imageURL, createdAt, updatedAt;

- (void)setWithJSONDictionary:(NSDictionary *)aDictionary {
  self.text = NilOrValue([aDictionary objectForKey:@"text"]);
  self.url = NilOrValue([aDictionary objectForKey:@"link"]);
    
  NSDictionary *image = [aDictionary objectForKey:@"image"];
  
  if (NilOrValue(image)) {
    self.imageURL = [image objectForKey:@"url"];
  }
    
  ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
  
  self.createdAt = NilOrValue([formatter dateFromString:[aDictionary objectForKey:@"@created_at"]]);
  self.updatedAt = NilOrValue([formatter dateFromString:[aDictionary objectForKey:@"@updated_at"]]);
  
  [formatter release];
}

@end
