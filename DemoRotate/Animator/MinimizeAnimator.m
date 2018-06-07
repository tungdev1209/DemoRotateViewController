//
//  MinimizeAnimator.m
//  DemoRotate
//
//  Created by Tung Nguyen on 6/4/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "MinimizeAnimator.h"
#import "Utilities.h"

@implementation MinimizeAnimator

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrameForVC = [transitionContext finalFrameForViewController:toViewController];
    UIView *containerView = transitionContext.containerView;
    
    [containerView addSubview:toViewController.view];
    [containerView addSubview:fromViewController.view];
    
    toViewController.view.frame = finalFrameForVC;
    
//    NSLog(@"finalFrame = %@", NSStringFromCGRect(finalFrameForVC));
//    
//    CGFloat mWidth = MainWidth;
//    CGFloat mHeight = MainHeight;
//    
//    if (MainWidth > MainHeight) {
//        mWidth = MainHeight;
//        mHeight = MainWidth;
//    }
    
    CGFloat height = self.getVideoSize().height;
    CGAffineTransform rotate = CGAffineTransformMakeRotation(0 * M_PI / 180);
    CGAffineTransform scale = CGAffineTransformMakeScale(height / MainWidth, MainWidth / MainHeight);
    
    CGAffineTransform t = CGAffineTransformIdentity;
    t = CGAffineTransformConcat(t, scale);
    t = CGAffineTransformConcat(t, rotate);
    
    NSLog(@"height = %.2f, main.size = %@", height, NSStringFromCGSize([UIScreen mainScreen].bounds.size));
    
    toViewController.view.alpha = 0.1;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.alpha = 1.0;
        fromViewController.view.transform = t;
        fromViewController.view.frame = CGRectMake(0, 0, [Utilities widthPortrait], height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromViewController.view.alpha = 1.0;
    }];
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

@end
