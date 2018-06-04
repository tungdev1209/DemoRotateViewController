//
//  MinimizeAnimator.h
//  DemoRotate
//
//  Created by Tung Nguyen on 6/4/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MinimizeAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) CGSize(^getVideoSize)(void);

@end
