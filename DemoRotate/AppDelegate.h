//
//  AppDelegate.h
//  DemoRotate
//
//  Created by Tung Nguyen on 5/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScreenPresentingProtocol <NSObject>
@optional
-(BOOL)willDismiss;
-(BOOL)willPresent;
-(BOOL)viewAppearing;
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

