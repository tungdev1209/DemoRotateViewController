//
//  NSLayoutConstraint+Extension.m
//  UIExtensionProject
//
//  Created by Tung Nguyen on 1/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "NSLayoutConstraint+Extension.h"

@implementation NSLayoutConstraint (e)

+(NSArray *)activateFullScreen:(UIView *)view {
    if (view.superview == nil) {
        return nil;
    }
    view.translatesAutoresizingMaskIntoConstraints = NO;

    NSMutableArray *cs = [NSMutableArray array];
    [cs addObject:[NSLayoutConstraint activateLeft:0 forView:view]];
    [cs addObject:[NSLayoutConstraint activateTop:0 forView:view]];
    [cs addObject:[NSLayoutConstraint activateRight:0 forView:view]];
    [cs addObject:[NSLayoutConstraint activateBottom:0 forView:view]];
    [NSLayoutConstraint activateConstraints:cs];
    return cs;
}

+(NSLayoutConstraint *)activateHeightEqualView:(UIView *)mainView forView:(UIView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    [NSLayoutConstraint activateConstraints:@[c]];
    return c;
}

+(NSLayoutConstraint *)activateWidthEqualView:(UIView *)mainView forView:(UIView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [NSLayoutConstraint activateConstraints:@[c]];
    return c;
}

+(NSLayoutConstraint *)activateHeight:(CGFloat)height forView:(UIView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height];
    [NSLayoutConstraint activateConstraints:@[c]];
    return c;
}

+(NSLayoutConstraint *)activateWidth:(CGFloat)width forView:(UIView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width];
    [NSLayoutConstraint activateConstraints:@[c]];
    return c;
}

+(NSLayoutConstraint *)activateRight:(CGFloat)right forView:(UIView *)view {
    if (view.superview == nil) {
        return nil;
    }
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeRight multiplier:1 constant:(right * (-1))];
    [NSLayoutConstraint activateConstraints:@[c]];
    return c;
}

+(NSLayoutConstraint *)activateLeft:(CGFloat)left forView:(UIView *)view {
    if (view.superview == nil) {
        return nil;
    }
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:left];
    [NSLayoutConstraint activateConstraints:@[c]];
    return c;
}

+(NSLayoutConstraint *)activateTop:(CGFloat)top forView:(UIView *)view {
    if (view.superview == nil) {
        return nil;
    }
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:top];
    [NSLayoutConstraint activateConstraints:@[c]];
    return c;
}

+(NSLayoutConstraint *)activateBottom:(CGFloat)bottom forView:(UIView *)view {
    if (view.superview == nil) {
        return nil;
    }
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:(bottom * (-1))];
    [NSLayoutConstraint activateConstraints:@[c]];
    return c;
}

+(NSLayoutConstraint *)activateCenterX:(UIView *)view {
    if (view.superview == nil) {
        return nil;
    }
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [NSLayoutConstraint activateConstraints:@[c]];
    return c;
}

+(NSLayoutConstraint *)activateCenterY:(UIView *)view {
    if (view.superview == nil) {
        return nil;
    }
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [NSLayoutConstraint activateConstraints:@[c]];
    return c;
}

+(NSArray<NSLayoutConstraint *> *)activateCenter:(UIView *)view {
    if (view.superview == nil) {
        return nil;
    }
    NSLayoutConstraint *cX = [NSLayoutConstraint activateCenterX:view];
    NSLayoutConstraint *cY = [NSLayoutConstraint activateCenterY:view];
    return @[cX, cY];
}

-(BOOL)isTopOf:(UIView *)view {
    return (self.firstItem == view && self.firstAttribute == NSLayoutAttributeTop) || (self.secondItem == view && self.secondAttribute == NSLayoutAttributeTop);
}

-(BOOL)isBottomOf:(UIView *)view {
    return (self.firstItem == view && self.firstAttribute == NSLayoutAttributeBottom) || (self.secondItem == view && self.secondAttribute == NSLayoutAttributeBottom);
}

-(BOOL)isLeftOf:(UIView *)view {
    return (self.firstItem == view && self.firstAttribute == NSLayoutAttributeLeft) || (self.secondItem == view && self.secondAttribute == NSLayoutAttributeLeft);
}

-(BOOL)isRightOf:(UIView *)view {
    return (self.firstItem == view && self.firstAttribute == NSLayoutAttributeRight) || (self.secondItem == view && self.secondAttribute == NSLayoutAttributeRight);
}

-(BOOL)isWithOf:(UIView *)view {
    return (self.firstItem == view && self.firstAttribute == NSLayoutAttributeWidth) || (self.secondItem == view && self.secondAttribute == NSLayoutAttributeWidth);
}

-(BOOL)isHeightOf:(UIView *)view {
    return (self.firstItem == view && self.firstAttribute == NSLayoutAttributeHeight) || (self.secondItem == view && self.secondAttribute == NSLayoutAttributeHeight);
}

@end
