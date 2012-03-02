//
//  Announcement.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2012 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//


@interface Announcement : NSObject {

}

@property (nonatomic) NSString * text;
@property (nonatomic) NSString * url;
@property (nonatomic) NSString * imageURL;

@property (nonatomic) NSDate * updatedAt;
@property (nonatomic) NSDate * createdAt;


- (void)setWithJSONDictionary:(NSDictionary *)aDictionary;


@end
