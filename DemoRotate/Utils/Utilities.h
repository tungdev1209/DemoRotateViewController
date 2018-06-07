//
//  Utilities.h
//  DemoRotate
//
//  Created by Tung Nguyen on 6/3/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define weakify(var) __weak typeof(var) weak_##var = var;
#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = weak_##var; \
_Pragma("clang diagnostic pop")

#define MainWidth [UIScreen mainScreen].bounds.size.width
#define MainHeight [UIScreen mainScreen].bounds.size.height
#define MainOrientation [UIDevice currentDevice].orientation

#define isPortrait UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation])
#define isLandscape UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])

@interface Utilities : NSObject

+(UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootVC;
+(CGFloat)widthPortrait;
+(CGFloat)heightPortrait;

@end
