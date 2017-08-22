//
//  AppDelegate.m
//  TaipeiOpenPark
//
//  Created by Wenhao Ho on 8/21/17.
//  Copyright © 2017 w. All rights reserved.
//

#import "AppDelegate.h"
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/SDImageCacheConfig.h>

@interface AppDelegate () <SDWebImageManagerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [SDWebImageManager sharedManager].delegate = self;
    [SDWebImageManager sharedManager].imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;
    [SDWebImageManager sharedManager].imageDownloader.shouldDecompressImages = NO;
    [SDWebImageManager sharedManager].imageCache.config.shouldDecompressImages = NO;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:self queue:nil usingBlock:^(NSNotification *note) {
        [[SDWebImageManager sharedManager].imageCache clearMemory];
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (UIImage *)scaleImage:(UIImage *)image size:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    @autoreleasepool {
        return newImage;
    }
}

#pragma mark - SDWebImageManagerDelegate

- (UIImage *)imageManager:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL {
#ifdef DEBUG
    NSLog(@"%@: %@", NSStringFromCGSize(image.size), imageURL);
#endif
    return [AppDelegate scaleImage:image size:CGSizeMake(1024.0, 768.0)];
}

@end
