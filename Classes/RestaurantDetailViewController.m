//
//  RestaurantDetailViewController.m
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/8/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). All rights reserved.
//

#import "RestaurantDetailViewController.h"

#import "Restaurant.h"

#import "UIImageView+WebCache.h"

////////////////////////////////////

#define kSegmentTitle 0

#define kRestaurantTitle 0

////////////////////////////////////

#define kSegmentBasic 1

#define kRestaurantText 0
#define kRestaurantStars 1
#define kRestaurantPriceRange 2
#define kRestaurantOpeningTimes 3
#define kRestaurantLatitude 4
#define kRestaurantLongitude 5

////////////////////////////////////

#define kSegmentDetail 2

#define kRestaurantVegetarianMenu 0
#define kRestaurantLastVisit 1
#define kRestaurantCreatedAt 2
#define kRestaurantUpdatedAt 3

////////////////////////////////////

@implementation RestaurantDetailViewController

@synthesize tableView;
@synthesize restaurant;


#pragma mark -
#pragma mark NSObject

- (void)dealloc {
  [self viewDidUnload];
  
  [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self.tableView reloadData];
}

- (void)viewDidUnload {  
  self.tableView = nil;
  self.restaurant = nil;
  
  [super viewDidUnload];
}


#pragma mark -
#pragma mark UITableView Delegate & DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {  
  switch (section) {
    case kSegmentTitle:
      return 1;
    case kSegmentBasic:
      return 6;
    default:
      return 4;
  }
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {  
  UITableViewCell *cell = nil;
  
  
  if (indexPath.section == kSegmentTitle) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease]; 
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.textLabel.text = [self.restaurant name];
      
    [cell.imageView setImageWithURL:[NSURL URLWithString:[self.restaurant imageURL]] placeholderImage:nil];
  }
  else if (indexPath.section == kSegmentBasic) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil] autorelease]; 
    
    if (indexPath.row == kRestaurantText) {
      cell.textLabel.text = @"Text";
      cell.detailTextLabel.text = self.restaurant.text;
    }
    else if (indexPath.row == kRestaurantStars) {
      cell.textLabel.text = @"Stars";
      cell.detailTextLabel.text = [self.restaurant.stars stringValue];
    }
    else if (indexPath.row == kRestaurantPriceRange) {
      cell.textLabel.text = @"Price Range";
      cell.detailTextLabel.text = [self.restaurant.priceRange stringValue];
    }
    else if (indexPath.row == kRestaurantOpeningTimes) {
      cell.textLabel.text = @"Opening Times";
      cell.detailTextLabel.text = self.restaurant.openingTimes;
    }
    else if (indexPath.row == kRestaurantLatitude) {
      cell.textLabel.text = @"Latitude";
      cell.detailTextLabel.text = [self.restaurant.latitude stringValue];
    }
    else {
      cell.textLabel.text = @"Longitude";
      cell.detailTextLabel.text = [self.restaurant.longitude stringValue];
    }
  }
  else if (indexPath.section == kSegmentDetail) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil] autorelease]; 
    
    if (indexPath.row == kRestaurantVegetarianMenu) {
      cell.textLabel.text = @"Vegetarian";
      cell.detailTextLabel.text = [self.restaurant.vegetarianMenu boolValue] ? @"Yes" : @"No";
    }
    else if (indexPath.row == kRestaurantLastVisit) {
      cell.textLabel.text = @"Last Visit";
      cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.restaurant.lastVisit];
    }
    else if (indexPath.row == kRestaurantCreatedAt) {
      cell.textLabel.text = @"Created At";
      cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.restaurant.createdAt];
    }
    else {
      cell.textLabel.text = @"Updated At";
      cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.restaurant.updatedAt];
    }
  }
  
  cell.accessoryType = UITableViewCellAccessoryNone;
  
  
  return cell;
}



- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  return nil;
}

@end