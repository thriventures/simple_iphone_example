//
//  AboutViewController
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/8/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import "ReadmeViewController.h"

#define kAboutURLRaw @"https://github.com/thriventures/storage_room_iphone_examples/raw/master/README.rdoc"
#define kAboutURLHTML @"https://github.com/thriventures/storage_room_iphone_examples"

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
  
  NSURL *url = [NSURL URLWithString:kAboutURLRaw];
  [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)viewDidUnload {
  self.webView = nil;
  
  [super viewDidUnload];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)safariButtonTapped {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAboutURLHTML]];  
}

@end
