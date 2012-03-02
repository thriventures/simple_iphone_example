//
//  BaseController.m
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/11/10.
//  Copyright 2012 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import "BaseController.h"

#import "StorageRoomExampleAppDelegate.h"

@implementation BaseController

- (StorageRoomExampleAppDelegate *)applicationDelegate {
  return (StorageRoomExampleAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)showAlertWithMessage:(NSString *)aMessage {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:aMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
  [alert show];	
}

@end
