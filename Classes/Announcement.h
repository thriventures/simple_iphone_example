//
//  Announcement.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2012 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//


@interface Announcement : NSObject {

}

@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * imageURL;

@property (nonatomic, strong) NSDate * updatedAt;
@property (nonatomic, strong) NSDate * createdAt;


- (void)setWithJSONDictionary:(NSDictionary *)aDictionary;


@end
