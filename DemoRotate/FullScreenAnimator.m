//
//  FullScreenAnimator.m
//  DemoRotate
//
//  Created by Tung Nguyen on 6/3/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "FullScreenAnimator.h"
#import "RotateViewController.h"

@implementation FullScreenAnimator

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrameForVC = [transitionContext finalFrameForViewController:toViewController];
    UIView *containerView = transitionContext.containerView;
    
    toViewController.view.frame = CGRectMake(0, 0, 375, 180);
    [containerView addSubview:toViewController.view];
//    toViewController.view.transform = CGAffineTransformMakeRotation(-90 * M_PI/180);
//    toViewController.view.frame = CGRectMake(0, 0, 100, 60);
//    [toViewController.view layoutIfNeeded];
    
//    toViewController.view.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(180.0 / 375.0, 375.0 / 667.0), CGAffineTransformMakeRotation(-90 * M_PI / 180));
    
    CGAffineTransform t = CGAffineTransformMakeRotation(-90 * M_PI / 180);
    t = CGAffineTransformConcat(t, CGAffineTransformMakeScale(180.0 / 375.0, 375.0 / 667.0));
    t = CGAffineTransformConcat(t, CGAffineTransformMakeTranslation(-(667.0-375.0)/2.0, 0.0));
    toViewController.view.transform = t;
    
//    [(RotateViewController *)toViewController beginPresentingAnimation];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.alpha = 0.5;
        toViewController.view.transform = CGAffineTransformIdentity;
        toViewController.view.frame = finalFrameForVC;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromViewController.view.alpha = 1.0;
    }];
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 10;
}

@end
