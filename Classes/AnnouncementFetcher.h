//
//  AnnouncementFetcher.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/11/10.
//  Copyright 2010 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//



@interface AnnouncementFetcher : NSObject {
  NSURLConnection *connection;
  NSMutableData *responseData;
  NSMutableArray *announcements;
  
  id delegate;
}

@property (nonatomic, retain) NSMutableArray *announcements;

@property (nonatomic, assign) id delegate;

- (void)downloadAnnouncements;


@end
