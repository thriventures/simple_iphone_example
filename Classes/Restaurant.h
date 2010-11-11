//
//  Restaurant.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). All rights reserved.
//

#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@interface Restaurant :  NSManagedObject {
  
}

@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSString * openingTimes;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * priceRange;
@property (nonatomic, retain) NSNumber * vegetarianMenu;
@property (nonatomic, retain) NSDate * lastVisit;
@property (nonatomic, retain) NSNumber * stars;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * previewImageURL;

- (void)setWithJSONDictionary:(NSDictionary *)aDictionary;
- (CLLocationCoordinate2D)coordinate;

@end



