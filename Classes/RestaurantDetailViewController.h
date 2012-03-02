//
//  RestaurantDetailViewController.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/8/10.
//  Copyright 2012 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import "BaseController.h"

@class Restaurant;

@interface RestaurantDetailViewController : BaseController <UITableViewDelegate, UITableViewDataSource> {

}

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) Restaurant *restaurant;

@end
