//
//  AnnouncementFetcher.h
//  StorageRoomExample
//
//  Created by Sascha Konietzke on 11/11/10.
//  Copyright 2012 Thriventures UG (haftungsbeschränkt). See LICENSE for details.
//



@interface AnnouncementFetcher : NSObject {

}

@property (nonatomic, strong) NSMutableArray *announcements;

@property (nonatomic, weak) id delegate;

- (void)downloadAnnouncements;


@end
