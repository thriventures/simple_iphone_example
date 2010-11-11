//
//  RestaurantsViewController.m
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/8/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). All rights reserved.
//

#import "RestaurantsViewController.h"

#import "RestaurantDetailViewController.h"

#import "StorageRoomExampleAppDelegate.h"

#import "Restaurant.h"
#import "RestaurantFetcher.h"
#import "RestaurantAnnotation.h"

#import "UIImageView+WebCache.h"


@implementation RestaurantsViewController

@synthesize detailViewController, fetchedResultsController;
@synthesize tableView, mapView, hudView, segmentedControl;
@synthesize restaurantFetcher;


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
  
  self.hudView = [[[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow] autorelease];
  [[self applicationDelegate].window addSubview:self.hudView];
  
  self.restaurantFetcher = [[[RestaurantFetcher alloc] initWithManagedObjectContext:[self applicationDelegate].managedObjectContext] autorelease];
  restaurantFetcher.delegate = self;
  
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self reloadRestaurants];
}

- (void)viewDidUnload {    
  self.detailViewController = nil;
  self.fetchedResultsController = nil;
  
  self.tableView = nil;
  self.mapView = nil;
  self.hudView = nil;
  self.segmentedControl = nil;
  
  self.restaurantFetcher = nil;
  
  [super viewDidUnload];
}

#pragma mark -
#pragma mark Helpers

- (void)reloadRestaurants {  
  NSManagedObjectContext *context = [self applicationDelegate].managedObjectContext;
  NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
  fetchRequest.entity = [NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:context];
  
  NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES] autorelease];
  fetchRequest.sortDescriptors = [[[NSArray alloc] initWithObjects:sortDescriptor, nil] autorelease];
  
  [NSFetchedResultsController deleteCacheWithName:@"restaurants"];
  self.fetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"restaurants"] autorelease];  
  
  NSError *error = nil;
  
  if (![fetchedResultsController performFetch:&error]) {
    [self showAlertWithMessage:@"Could not load Restaurants"];
  }
  
  [self.tableView reloadData];
  
  [self.mapView removeAnnotations:self.mapView.annotations];
  
  NSArray *restaurants = fetchedResultsController.fetchedObjects;
  
  for(Restaurant *restaurant in restaurants) {
    RestaurantAnnotation *annotation = [[RestaurantAnnotation alloc] initWithRestaurant:restaurant];
    
    [self.mapView addAnnotation:annotation];
    
    [annotation release];
  }
}

- (void)openDetailViewForRestaurant:(Restaurant *)aRestaurant {
  self.detailViewController.restaurant = aRestaurant;
  
  [self.navigationController pushViewController:self.detailViewController animated:YES]; 
}



#pragma mark -
#pragma mark IBActions

- (IBAction)segmentedControlChanged {
  DisplayType displayType = (DisplayType)self.segmentedControl.selectedSegmentIndex;
  
  switch (displayType) {
    case kDisplayTypeList:
      self.mapView.hidden = YES;
      self.tableView.hidden = NO;
      break;
    default:
      self.mapView.hidden = NO;
      self.tableView.hidden = YES;
  }
}

- (IBAction)loadButtonTapped {
  NSLog(@"Loading Restaurants from API");
    
  // Download the restaurants. Of course this could also be triggered automatically.
  [self.restaurantFetcher downloadRestaurants];
}

#pragma mark -
#pragma mark UITableView Delegate & DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
  id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
  
  return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *plainCellIdentifier = @"plainCellIdentifier";
  
  UITableViewCell *cell = (UITableViewCell *)[aTableView dequeueReusableCellWithIdentifier:plainCellIdentifier];
  
  if (!cell) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:plainCellIdentifier] autorelease]; 
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
  }
  
  Restaurant *restaurant = (Restaurant *)[self.fetchedResultsController objectAtIndexPath:indexPath];
  
  cell.textLabel.text = restaurant.name;
  [cell.imageView setImageWithURL:[NSURL URLWithString:[restaurant previewImageURL]] placeholderImage:nil];
  
  return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { 
  id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
  
  return [sectionInfo name];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
  return [self.fetchedResultsController sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
  return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { 
  Restaurant *restaurant = (Restaurant *)[fetchedResultsController objectAtIndexPath:indexPath];
  
  [self openDetailViewForRestaurant:restaurant];
}

- (void)tableView:(UITableView *)aTableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
  [self tableView:aTableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark -
#pragma mark MKMapView Delegate Methods

- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id <MKAnnotation>)annotation {	  
  static NSString *annotationViewIdentifier = @"annotationViewIdentifier";
  
	if (annotation == self.mapView.userLocation) {
		return nil;
	}
	else if([annotation isKindOfClass:[RestaurantAnnotation class]])	{    
		MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[aMapView dequeueReusableAnnotationViewWithIdentifier:annotationViewIdentifier];
		
		if(!annotationView) {
			annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewIdentifier] autorelease];
      annotationView.canShowCallout = YES;
      
      UIButton *detailsButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
      annotationView.rightCalloutAccessoryView = detailsButton;      
		}
		
		return annotationView;
	}
  
	return nil;
}

- (void)mapView:(MKMapView *)aMapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
  RestaurantAnnotation *annotation = (RestaurantAnnotation *)view.annotation; 
  Restaurant *restaurant = annotation.restaurant;
  
  [self openDetailViewForRestaurant:restaurant];
}

#pragma mark -
#pragma mark RestaurantFetcher Delegate Methods

- (void)restaurantFetcherDidStartDownload:(RestaurantFetcher *)aRestaurantFetcher {
  self.hudView.labelText = @"Downloading Restaurants";
  [self.hudView show:YES];
}

- (void)restaurantFetcherDidFinishDownload:(RestaurantFetcher *)aRestaurantFetcher {
  [self.hudView hide:YES];  
  [self reloadRestaurants];
}

- (void)restaurantFetcher:(RestaurantFetcher *)aRestaurantFetcher didFailWithError:(NSError *)anError {
  [self.hudView hide:YES];
  [self showAlertWithMessage:@"Could not download Restaurants"];
}



@end
