/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "SDWebImageDownloaderDelegate.h"
#import "SDWebImageCompat.h"

extern NSString *const SDWebImageDownloadStartNotification;
extern NSString *const SDWebImageDownloadStopNotification;

@interface SDWebImageDownloader : NSObject
{
    @private
    NSURL *url;
    id<SDWebImageDownloaderDelegate> __unsafe_unretained delegate;
    NSURLConnection *connection;
    NSMutableData *imageData;
	id userInfo;
}

@property (nonatomic) NSURL *url;
@property (nonatomic, unsafe_unretained) id<SDWebImageDownloaderDelegate> delegate;
@property (nonatomic) NSMutableData *imageData;
@property (nonatomic) id userInfo;

+ (id)downloaderWithURL:(NSURL *)url delegate:(id<SDWebImageDownloaderDelegate>)delegate userInfo:(id)userInfo;
+ (id)downloaderWithURL:(NSURL *)url delegate:(id<SDWebImageDownloaderDelegate>)delegate;
- (void)start;
- (void)cancel;

// This method is now no-op and is deprecated
+ (void)setMaxConcurrentDownloads:(NSUInteger)max __attribute__((deprecated));

@end
