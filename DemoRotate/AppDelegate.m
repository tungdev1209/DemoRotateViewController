//
//  AppDelegate.m
//  DemoRotate
//
//  Created by Tung Nguyen on 5/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
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

#pragma mark - App support orientations
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    UIViewController *rootVC = [self topViewControllerWithRootViewController:window.rootViewController];
    if ([rootVC conformsToProtocol:@protocol(ScreenPresentingProtocol)]) {
        id<ScreenPresentingProtocol> vcAppliedProtocol = (id<ScreenPresentingProtocol>)rootVC;
        if ([vcAppliedProtocol willDismiss]) {
            return UIInterfaceOrientationMaskPortrait;
        }
        else if ([vcAppliedProtocol willPresent]) {
            return UIInterfaceOrientationMaskLandscape;
        }
    }
    return UIInterfaceOrientationMaskPortrait;
}

-(UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootVC {
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

@end
