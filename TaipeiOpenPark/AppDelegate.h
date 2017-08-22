//
//  AppDelegate.h
//  TaipeiOpenPark
//
//  Created by Wenhao Ho on 8/21/17.
//  Copyright © 2017 w. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic) UIWindow *window;

+ (UIImage *)scaleImage:(UIImage *)image size:(CGSize)newSize;

@end

