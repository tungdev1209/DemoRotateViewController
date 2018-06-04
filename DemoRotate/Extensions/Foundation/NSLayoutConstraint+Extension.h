//
//  NSLayoutConstraint+Extension.h
//  UIExtensionProject
//
//  Created by Tung Nguyen on 1/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (e)

+(NSArray * /* Left, top, Right, bottom */)activateFullScreen:(UIView *)view;
+(NSLayoutConstraint *)activateHeightEqualView:(UIView *)mainView forView:(UIView *)view;
+(NSLayoutConstraint *)activateWidthEqualView:(UIView *)mainView forView:(UIView *)view;
+(NSLayoutConstraint *)activateHeight:(CGFloat)height forView:(UIView *)view;
+(NSLayoutConstraint *)activateWidth:(CGFloat)width forView:(UIView *)view;
+(NSLayoutConstraint *)activateRight:(CGFloat)right forView:(UIView *)view;
+(NSLayoutConstraint *)activateLeft:(CGFloat)left forView:(UIView *)view;
+(NSLayoutConstraint *)activateTop:(CGFloat)top forView:(UIView *)view;
+(NSLayoutConstraint *)activateBottom:(CGFloat)bottom forView:(UIView *)view;
+(NSLayoutConstraint *)activateCenterX:(UIView *)view;
+(NSLayoutConstraint *)activateCenterY:(UIView *)view;
+(NSArray<NSLayoutConstraint *> *)activateCenter:(UIView *)view;

-(BOOL)isTopOf:(UIView *)view;
-(BOOL)isBottomOf:(UIView *)view;
-(BOOL)isLeftOf:(UIView *)view;
-(BOOL)isRightOf:(UIView *)view;
-(BOOL)isWithOf:(UIView *)view;
-(BOOL)isHeightOf:(UIView *)view;

@end
