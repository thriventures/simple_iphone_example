//
//  Announcement.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//


@interface Announcement : NSObject {
  NSString * text;
  NSString * url;
  NSString * imageURL;
  
  NSDate * updatedAt;
  NSDate * createdAt;
}

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * imageURL;

@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSDate * createdAt;


- (void)setWithJSONDictionary:(NSDictionary *)aDictionary;


@end
