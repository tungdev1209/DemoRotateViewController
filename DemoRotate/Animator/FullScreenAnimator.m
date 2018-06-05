//
//  FullScreenAnimator.m
//  DemoRotate
//
//  Created by Tung Nguyen on 6/3/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "FullScreenAnimator.h"
#import "RotateViewController.h"
#import "ViewController.h"
#import "Utilities.h"

@implementation FullScreenAnimator

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrameForVC = [transitionContext finalFrameForViewController:toViewController];
    UIView *containerView = transitionContext.containerView;
    
    [containerView addSubview:toViewController.view];
    toViewController.view.frame = finalFrameForVC;
    
    CGFloat height = self.getVideoSize().height;
    
    CGAffineTransform rotate, scale, translate;
    if (self.orientation == UIDeviceOrientationLandscapeLeft) {
        rotate = CGAffineTransformMakeRotation(-90 * M_PI / 180);
        scale = CGAffineTransformMakeScale(height / MainHeight, MainHeight / MainWidth);
        translate = CGAffineTransformMakeTranslation(-(MainWidth - height) / 2.0, 0.0);
    }
    else {
        rotate = CGAffineTransformMakeRotation(90 * M_PI / 180);
        scale = CGAffineTransformMakeScale(height / MainHeight, MainHeight / MainWidth);
        translate = CGAffineTransformMakeTranslation((MainWidth - height) / 2.0, 0.0);
    }
    
    CGAffineTransform t = CGAffineTransformIdentity;
    t = CGAffineTransformConcat(t, rotate);
    t = CGAffineTransformConcat(t, scale);
    t = CGAffineTransformConcat(t, translate);
    
    toViewController.view.transform = t;
    
    self.beginAnimation();
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.alpha = 0.5;
        toViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromViewController.view.alpha = 1.0;
    }];
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 3;
}

@end
