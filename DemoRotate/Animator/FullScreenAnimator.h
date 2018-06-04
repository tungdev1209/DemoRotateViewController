//
//  FullScreenAnimator.h
//  DemoRotate
//
//  Created by Tung Nguyen on 6/3/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FullScreenAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) CGSize(^getVideoSize)(void);
@property (nonatomic, strong) void(^beginAnimation)(void);
@property (nonatomic, assign) UIDeviceOrientation orientation;

@end
