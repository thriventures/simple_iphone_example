//
//  RestaurantDetailViewController.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/8/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import "BaseController.h"

@class Restaurant;

@interface RestaurantDetailViewController : BaseController <UITableViewDelegate, UITableViewDataSource> {
  UITableView *tableView;
  
  Restaurant *restaurant;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) Restaurant *restaurant;

@end
