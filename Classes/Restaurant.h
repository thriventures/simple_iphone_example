//
//  Restaurant.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/10/10.
//  Copyright 2012 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//

#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@interface Restaurant :  NSManagedObject <MKAnnotation> {
  
}

@property (nonatomic) NSDate * updatedAt;
@property (nonatomic) NSString * address;
@property (nonatomic) NSNumber * longitude;
@property (nonatomic) NSNumber * latitude;
@property (nonatomic) NSNumber * priceRange;
@property (nonatomic) NSNumber * vegetarianMenu;
@property (nonatomic) NSDate * lastVisit;
@property (nonatomic) NSNumber * stars;
@property (nonatomic) NSString * imageURL;
@property (nonatomic) NSString * text;
@property (nonatomic) NSDate * createdAt;
@property (nonatomic) NSString * name;
@property (nonatomic) NSString * previewImageURL;

- (void)setWithJSONDictionary:(NSDictionary *)aDictionary;
- (CLLocationCoordinate2D)coordinate;

@end



