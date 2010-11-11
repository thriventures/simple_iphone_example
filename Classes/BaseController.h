//
//  BaseController.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/11/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

@class StorageRoomExampleAppDelegate;

@interface BaseController : UIViewController {

}


- (StorageRoomExampleAppDelegate *)applicationDelegate;
- (void)showAlertWithMessage:(NSString *)aMessage;

@end
