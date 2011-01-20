//
//  RestaurantsViewController.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/8/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
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
@class AnnouncementFetcher;

@interface RestaurantsViewController : BaseController <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate> {
  RestaurantDetailViewController *detailViewController;
  NSFetchedResultsController *fetchedResultsController;
  
  UITableView *tableView;
  MKMapView *mapView;
  MBProgressHUD *hudView;
  UISegmentedControl *segmentedControl;
  UIView *announcementView;
  UIButton *announcementButton;
  UILabel *announcementLabel;
  
  RestaurantFetcher *restaurantFetcher;
  AnnouncementFetcher *announcementFetcher;
}

@property (nonatomic, retain) IBOutlet RestaurantDetailViewController *detailViewController;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) MBProgressHUD *hudView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, retain) IBOutlet UIView *announcementView;
@property (nonatomic, retain) IBOutlet UIButton *announcementButton;
@property (nonatomic, retain) IBOutlet UILabel *announcementLabel;


@property (nonatomic, retain) RestaurantFetcher *restaurantFetcher;
@property (nonatomic, retain) AnnouncementFetcher *announcementFetcher;


- (IBAction)segmentedControlChanged;
- (IBAction)loadButtonTapped;
- (IBAction)hideAnnouncement;
- (IBAction)openAnnouncement;

- (void)reloadRestaurants;
- (void)openDetailViewForRestaurant:(Restaurant *)aRestaurant;


@end
