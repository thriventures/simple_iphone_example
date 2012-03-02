//
//  RestaurantsViewController.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/8/10.
//  Copyright 2012 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
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

@interface RestaurantsViewController : BaseController <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, NSFetchedResultsControllerDelegate> {

}

@property (nonatomic, strong) IBOutlet RestaurantDetailViewController *detailViewController;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet MBProgressHUD *hudView;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, strong) IBOutlet UIView *announcementView;
@property (nonatomic, strong) IBOutlet UIButton *announcementButton;
@property (nonatomic, strong) IBOutlet UILabel *announcementLabel;


@property (nonatomic, strong) RestaurantFetcher *restaurantFetcher;
@property (nonatomic, strong) AnnouncementFetcher *announcementFetcher;


- (IBAction)segmentedControlChanged;
- (IBAction)loadButtonTapped;
- (IBAction)hideAnnouncement;
- (IBAction)openAnnouncement;

- (void)loadRestaurants;
- (void)openDetailViewForRestaurant:(Restaurant *)aRestaurant;


@end
