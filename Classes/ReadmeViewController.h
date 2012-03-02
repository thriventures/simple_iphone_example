//
//  AboutViewController.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/8/10.
//  Copyright 2012 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import "BaseController.h"

@interface ReadmeViewController : BaseController {

}

@property (nonatomic) IBOutlet UIWebView *webView;

- (IBAction)safariButtonTapped;

@end
