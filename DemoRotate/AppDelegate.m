//
//  AppDelegate.m
//  DemoRotate
//
//  Created by Tung Nguyen on 5/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "AppDelegate.h"
#import "Utilities.h"

@interface ObjectSample: NSObject

@property (nonatomic, strong) void(^block)(int);

@end

@implementation ObjectSample @end

@interface AppDelegate ()

@property (nonatomic, strong) ObjectSample *object;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    self.object = [[ObjectSample alloc] init];
//    [self.object setBlock:^(int num) {
//        NSLog(@"num = %d", num);
//    }];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.object.block(2);
//    });
    
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
    UIViewController *rootVC = [Utilities topViewControllerWithRootViewController:window.rootViewController];
    NSLog(@"supportedInterfaceOrientationsForWindow: %@", rootVC);
    if ([rootVC conformsToProtocol:@protocol(ScreenPresentingProtocol)]) {
        id<ScreenPresentingProtocol> vc = (id<ScreenPresentingProtocol>)rootVC;
        if ([vc willDismiss]) {
            return UIInterfaceOrientationMaskPortrait;
        }
        else if ([vc willPresent]) {
            return UIInterfaceOrientationMaskLandscape;
        }
    }
    return UIInterfaceOrientationMaskAll;
}

@end
