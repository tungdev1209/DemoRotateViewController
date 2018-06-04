//
//  RotateViewController.h
//  DemoRotate
//
//  Created by Tung Nguyen on 5/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "PlayerView.h"
#import "ViewController.h"

@interface RotateViewController : UIViewController <ScreenPresentingProtocol>

@property (nonatomic, strong) PlayerView *playerView;
@property (nonatomic, weak) ViewController *parentVC;

-(void)beginPresentingAnimation;

@end
