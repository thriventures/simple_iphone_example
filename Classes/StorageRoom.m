//
//  StorageRoom.m
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/11/10.
//  Copyright 2012 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import "StorageRoom.h"



NSString * const StorageRoomAccountId = @"4d13574cba05613d25000004";
NSString * const StorageRoomAPIKey = @"DZHpRbsJ7VgFXhybKWmT";
NSString * const StorageRoomHost = @"api.storageroomapp.com"; 


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