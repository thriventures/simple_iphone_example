//
//  RestaurantsViewController.m
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/8/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import "RestaurantsViewController.h"

#import "RestaurantDetailViewController.h"

#import "StorageRoomExampleAppDelegate.h"

#import "Restaurant.h"
#import "RestaurantFetcher.h"

#import "Announcement.h"
#import "AnnouncementFetcher.h"

#import "UIImageView+WebCache.h"


@implementation RestaurantsViewController

@synthesize detailViewController, fetchedResultsController;
@synthesize tableView, mapView, hudView, segmentedControl, announcementView, announcementButton, announcementLabel;
@synthesize restaurantFetcher, announcementFetcher;


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
  
  self.announcementFetcher = [[[AnnouncementFetcher alloc] init] autorelease];
  announcementFetcher.delegate = self;
  
  [announcementFetcher downloadAnnouncements];
    
  [self loadRestaurants];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow  animated:YES];
}

- (void)viewDidUnload {    
  self.detailViewController = nil;
  self.fetchedResultsController = nil;
  
  self.tableView = nil;
  self.mapView = nil;
  self.hudView = nil;
  self.segmentedControl = nil;
  self.announcementView = nil;
  self.announcementButton = nil;
  self.announcementLabel = nil;
  
  self.restaurantFetcher = nil;
  self.announcementFetcher = nil;
  
  [super viewDidUnload];
}

#pragma mark -
#pragma mark Helpers

- (void)loadRestaurants {  
  NSManagedObjectContext *context = [self applicationDelegate].managedObjectContext;
  NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
  fetchRequest.entity = [NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:context];
  
  NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES] autorelease];
  fetchRequest.sortDescriptors = [[[NSArray alloc] initWithObjects:sortDescriptor, nil] autorelease];
  
  [NSFetchedResultsController deleteCacheWithName:@"restaurants"];
  self.fetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"restaurants"] autorelease];  
  fetchedResultsController.delegate = self;
  
  NSError *error = nil;
  
  if (![fetchedResultsController performFetch:&error]) {
    [self showAlertWithMessage:@"Could not load Restaurants"];
  }
  
  NSArray *restaurants = fetchedResultsController.fetchedObjects;
  
  [self.mapView addAnnotations:restaurants];
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

- (IBAction)hideAnnouncement {
  self.announcementView.hidden = YES;
}

- (IBAction)openAnnouncement {
  Announcement *announcement = (Announcement *)[self.announcementFetcher.announcements objectAtIndex:0];
  
  if (announcement.url) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:announcement.url]]; 
  }
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
	else if([annotation isKindOfClass:[Restaurant class]])	{    
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
  Restaurant *restaurant = (Restaurant *)view.annotation; 
  
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
}

- (void)restaurantFetcher:(RestaurantFetcher *)aRestaurantFetcher didFailWithError:(NSError *)anError {
  [self.hudView hide:YES];
  [self showAlertWithMessage:@"Could not download Restaurants"];
}

#pragma mark -
#pragma mark AnnouncementFetcher Delegate Methods

- (void)announcementFetcherDidStartDownload:(AnnouncementFetcher *)anAnnouncementFetcher {
  NSLog(@"Loading announcement");
}

- (void)announcementFetcherDidFinishDownload:(AnnouncementFetcher *)anAnnouncementFetcher withAnnouncements:(NSArray *)anArray {
  Announcement *announcement = [anArray objectAtIndex:0];
  
  self.announcementView.hidden = NO;
  self.announcementLabel.text = announcement.text;
}

- (void)announcementFetcher:(AnnouncementFetcher *)anAnnouncementFetcher didFailWithError:(NSError *)anError {
  NSLog(@"Error while loading announcements");
}

#pragma mark -
#pragma mark NSFetchedResultsController Delegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {  
  [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
  switch(type) {
    case NSFetchedResultsChangeInsert:
      [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
      
    case NSFetchedResultsChangeDelete:
      [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
  }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {  
  Restaurant *restaurant = (Restaurant *)anObject;
  
  switch(type) {
      
    case NSFetchedResultsChangeInsert:
      [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      
      [self.mapView addAnnotation:restaurant];
      
      break;
      
    case NSFetchedResultsChangeDelete:
      [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      
      [self.mapView removeAnnotation:restaurant];
      
      break;
  }  
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {  
  [self.tableView endUpdates];
}




@end
