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

@property (nonatomic, strong) NSDate * updatedAt;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSNumber * longitude;
@property (nonatomic, strong) NSNumber * latitude;
@property (nonatomic, strong) NSNumber * priceRange;
@property (nonatomic, strong) NSNumber * vegetarianMenu;
@property (nonatomic, strong) NSDate * lastVisit;
@property (nonatomic, strong) NSNumber * stars;
@property (nonatomic, strong) NSString * imageURL;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * previewImageURL;

- (void)setWithJSONDictionary:(NSDictionary *)aDictionary;
- (CLLocationCoordinate2D)coordinate;

@end



