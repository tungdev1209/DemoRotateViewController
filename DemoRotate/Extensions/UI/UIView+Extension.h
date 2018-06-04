//
//  UIView+Extension.h
//  UIExtensionProject
//
//  Created by Tung Nguyen on 1/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIView (e)

+(UIView *)initWithXib:(NSString *)xibName;
-(instancetype)viewFromXib;

-(void)addCorner:(CGFloat)radius borderWidth:(CGFloat)borderWidth;
-(void)showLoadingIndicator;
-(void)showLoadingIndicatorWithText:(NSString *)text;
-(void)hideLoadingIndicator;
-(void)showAlertMessage:(NSString *)_message andView:(UIViewController *)view;

-(void)borderWithColor:(UIColor*)color width:(CGFloat)strokeWidth radius:(CGFloat)radious;
- (void)shadowWithColor:(UIColor*)color width:(CGFloat)width;

-(void)removeAllSubviews;

//Layer
-(void)cornerRadius:(float)radius;
-(void)cornerRadiusDefault;

-(void)borderWithColor:(UIColor *)color width:(float)width;
-(void)borderWithDefaultColorWidth;

-(void)borderAndCornerDefault;

// Frame
-(void)adjustFrameWith:(float)top left:(float)left width:(float)width height:(float)height;
-(void)setFrameWithTop:(NSNumber *)top left:(NSNumber *)left width:(NSNumber *)width height:(NSNumber *)height;

//Constraint
-(void)adjustConstraintsToSuperViewWithTop:(NSNumber *)top left:(NSNumber *)left right:(NSNumber *)right bottom:(NSNumber *)bottom width:(NSNumber *)width height:(NSNumber *)height isSetValue:(BOOL)isSetValue;
-(void)adjustLeftConstraintToSuperView:(NSNumber *)value isSetValue:(BOOL)isSetValue;
-(void)adjustRightConstraintToSuperView:(NSNumber *)value isSetValue:(BOOL)isSetValue;
-(void)adjustTopConstraintToSuperView:(NSNumber *)value isSetValue:(BOOL)isSetValue;
-(void)adjustBottomConstraintToSuperView:(NSNumber *)value isSetValue:(BOOL)isSetValue;
-(void)adjustWidthConstraintToSuperView:(NSNumber *)value isSetValue:(BOOL)isSetValue;
-(void)adjustHeightConstraintToSuperView:(NSNumber *)value isSetValue:(BOOL)isSetValue;

-(NSArray *)getTopConstraints;
-(NSArray *)getBottomConstraints;
-(NSArray *)getLeadingConstraints;
-(NSArray *)getTrailingConstraints;

@end
