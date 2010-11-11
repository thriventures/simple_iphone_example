//
//  StorageRoom.m
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/11/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import "StorageRoom.h"



NSString * const StorageRoomAccountId = @"4cdb9a5d425071ba8d00002f";
NSString * const StorageRoomAPIKey = @"w7EiqaPfh3liZXrJu8Qp";
NSString * const StorageRoomHost = @"api.lvh.me:2999"; // TODO: update

NSString *StorageRoomURL(NSString *path) {
  return [NSString stringWithFormat:@"http://%@/accounts/%@%@", StorageRoomHost, StorageRoomAccountId, path];
}

id NilOrValue(id aValue) {
  if ((NSNull *)aValue == [NSNull null]) {
    return nil;
  }
  else {
    return aValue;
  }
}