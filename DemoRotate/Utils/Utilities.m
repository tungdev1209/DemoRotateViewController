//
//  Utilities.m
//  DemoRotate
//
//  Created by Tung Nguyen on 6/3/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+(UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootVC {
    if (rootVC == nil) {
        return nil;
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        return [self topViewControllerWithRootViewController:[(UITabBarController *)rootVC selectedViewController]];
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        return [self topViewControllerWithRootViewController:[(UINavigationController *)rootVC visibleViewController]];
    }
    else if (rootVC.presentedViewController != nil) {
        return [self topViewControllerWithRootViewController:rootVC.presentedViewController];
    }
    return rootVC;
}

+(CGFloat)widthPortrait {
    return MainWidth > MainHeight ? MainHeight : MainWidth;
}

+(CGFloat)heightPortrait {
    return MainWidth > MainHeight ? MainWidth : MainHeight;
}

@end
