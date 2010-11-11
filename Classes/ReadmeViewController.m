//
//  AboutViewController
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/8/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). All rights reserved.
//

#import "ReadmeViewController.h"

#define kAboutURL @"https://github.com/thriventures/storage_room_iphone_examples/blob/master/README.rdoc"

@implementation ReadmeViewController

@synthesize webView;

#pragma mark -
#pragma mark NSObject

- (void)dealloc {
  [self viewDidUnload];
  
  [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSURL *url = [NSURL URLWithString:kAboutURL];
  [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)viewDidUnload {
  self.webView = nil;
  
  [super viewDidUnload];
}

@end
