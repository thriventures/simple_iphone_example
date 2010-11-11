//
//  AboutViewController.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/8/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). All rights reserved.
//

#import "BaseController.h"

@interface ReadmeViewController : BaseController {
  UIWebView *webView;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@end
