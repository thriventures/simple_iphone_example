//
//  RestaurantsViewController.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/8/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). All rights reserved.
//

#import <MapKit/MapKit.h>

#import "BaseController.h"

typedef enum {
  kDisplayTypeList = 0,
  kDisplayTypeMap
} DisplayType;

@class StorageRoomExampleAppDelegate;
@class RestaurantDetailViewController;
@class Restaurant;
@class RestaurantFetcher;


@interface RestaurantsViewController : BaseController <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate> {
  RestaurantDetailViewController *detailViewController;
  NSFetchedResultsController *fetchedResultsController;
  
  UITableView *tableView;
  MKMapView *mapView;
  MBProgressHUD *hudView;
  UISegmentedControl *segmentedControl;
  RestaurantFetcher *restaurantFetcher;
}

@property (nonatomic, retain) IBOutlet RestaurantDetailViewController *detailViewController;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) MBProgressHUD *hudView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, retain) IBOutlet RestaurantFetcher *restaurantFetcher;


- (IBAction)segmentedControlChanged;
- (IBAction)loadButtonTapped;

- (void)reloadRestaurants;
- (void)openDetailViewForRestaurant:(Restaurant *)aRestaurant;


@end
