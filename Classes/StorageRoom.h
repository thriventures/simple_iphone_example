//
//  StorageRoom.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/11/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

extern NSString * const StorageRoomAccountId;
extern NSString * const StorageRoomAPIKey;
extern NSString * const StorageRoomHost;

NSString *StorageRoomURL(NSString *path);

id NilOrValue(id aValue);