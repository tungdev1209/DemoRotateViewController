//
//  UIView+Extension.m
//  UIExtensionProject
//
//  Created by Tung Nguyen on 1/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "UIView+Extension.h"
#import "UIActivityIndicatorView+Extension.h"
#import "Foundation+Extension.h"
#import <objc/runtime.h>

const void *kIndicator = &kIndicator;

@interface UIView()

@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation UIView (e)

+(UIView *)initWithXib:(NSString *)xibName {
    return [[[UINib nibWithNibName:xibName bundle:nil] instantiateWithOwner:self options:nil] firstObject];
}

-(instancetype)viewFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
}

#pragma mark - Properties
#pragma mark indicator
-(void)setIndicator:(UIActivityIndicatorView *)indicator {
    objc_setAssociatedObject(self, kIndicator, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIActivityIndicatorView *)indicator {
    return objc_getAssociatedObject(self, kIndicator);
}

#pragma mark - Functions
#pragma mark public
-(void)addCorner:(CGFloat)radius borderWidth:(CGFloat)borderWidth {
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.cornerRadius = radius;
}

- (void)showLoadingIndicator {
    [self showLoadingIndicatorWithText:@""];
}

-(void)showLoadingIndicatorWithText:(NSString *)text {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showLoadingIndicatorWithText:text];
        });
        return;
    }
    self.indicator = [UIActivityIndicatorView indicatorCustomizeIn:self];
    [self.indicator startLoadingWithText:text];
}

- (void)hideLoadingIndicator {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideLoadingIndicator];
        });
        return;
    }
    [self.indicator stopLoading];
}

-(void)showAlertMessage:(NSString *)_message andView:(UIViewController *)view{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:_message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [view dismissViewControllerAnimated:TRUE completion:nil];
    }]];
    [view presentViewController:alert animated:TRUE completion:nil];
}

- (void)borderWithColor:(UIColor *)color width:(CGFloat)strokeWidth radius:(CGFloat)radious {
    [self.layer setCornerRadius:radious];
    
    // border
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:strokeWidth];
}

- (void)shadowWithColor:(UIColor *)color width:(CGFloat)width {
    // drop shadow
    [self.layer setShadowColor:color.CGColor];
    [self.layer setShadowOpacity:0.5];
    [self.layer setShadowRadius:2.0];
    [self.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

-(void)removeAllSubviews {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

-(void)cornerRadius:(float)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

-(void)cornerRadiusDefault {
    [self cornerRadius:3.0];
}

-(void)borderWithColor:(UIColor *)color width:(float)width {
    self.layer.masksToBounds = YES;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

-(void)borderWithDefaultColorWidth {
    [self borderWithColor:[UIColor colorWithRed:182.0/255.0 green:182.0/255.0 blue:185.0/255.0 alpha:1.0f] width:1.0];
}

-(void)borderAndCornerDefault {
    [self cornerRadiusDefault];
    [self borderWithDefaultColorWidth];
}

-(void)adjustFrameWith:(float)top left:(float)left width:(float)width height:(float)height {
    CGRect rect = self.frame;
    CGPoint origin = rect.origin;
    origin.x += left;
    origin.y += top;
    CGSize size = rect.size;
    size.width += width;
    size.height += height;
    rect.origin = origin;
    rect.size = size;
    self.frame = rect;
}

-(void)setFrameWithTop:(NSNumber *)top left:(NSNumber *)left width:(NSNumber *)width height:(NSNumber *)height {
    CGRect rect = self.frame;
    
    if (top) {
        rect.origin.y = top.floatValue;
    }
    if (left) {
        rect.origin.x = left.floatValue;
    }
    if (width) {
        rect.size.width = width.floatValue;
    }
    if (height) {
        rect.size.height = height.floatValue;
    }
    
    self.frame = rect;
    
}

-(void)adjustConstraintsToSuperViewWithTop:(NSNumber *)top left:(NSNumber *)left right:(NSNumber *)right bottom:(NSNumber *)bottom width:(NSNumber *)width height:(NSNumber *)height isSetValue:(BOOL)isSetValue {
    if (self.superview == nil) {
        return;
    }
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if (top) {
            if ([constraint isTopOf:self]) {
                if (isSetValue) {
                    constraint.constant = top.floatValue;
                } else {
                    constraint.constant += top.floatValue;
                }
            }
        }
        if (left) {
            if ([constraint isLeftOf:self]) {
                if (isSetValue) {
                    constraint.constant = left.floatValue;
                } else {
                    constraint.constant += left.floatValue;
                }
            }
        }
        if (right) {
            if ([constraint isRightOf:self]) {
                if (isSetValue) {
                    constraint.constant = right.floatValue;
                } else {
                    constraint.constant += right.floatValue;
                }
            }
        }
        if (bottom) {
            if ([constraint isBottomOf:self]) {
                if (isSetValue) {
                    constraint.constant = bottom.floatValue;
                } else {
                    constraint.constant += bottom.floatValue;
                }
            }
        }
        if (width) {
            if ([constraint isWithOf:self]) {
                if (isSetValue) {
                    constraint.constant = width.floatValue;
                } else {
                    constraint.constant += width.floatValue;
                }
            }
        }
        if (height) {
            if ([constraint isHeightOf:self]) {
                if (isSetValue) {
                    constraint.constant = height.floatValue;
                } else {
                    constraint.constant += height.floatValue;
                }
            }
        }
    }
}

-(void)adjustLeftConstraintToSuperView:(NSNumber *)value isSetValue:(BOOL)isSetValue {
    [self adjustConstraintsToSuperViewWithTop:nil left:value right:nil bottom:nil width:nil height:nil isSetValue:isSetValue];
}

-(void)adjustRightConstraintToSuperView:(NSNumber *)value isSetValue:(BOOL)isSetValue {
    [self adjustConstraintsToSuperViewWithTop:nil left:nil right:value bottom:nil width:nil height:nil isSetValue:isSetValue];
}

-(void)adjustTopConstraintToSuperView:(NSNumber *)value isSetValue:(BOOL)isSetValue {
    [self adjustConstraintsToSuperViewWithTop:value left:nil right:nil bottom:nil width:nil height:nil isSetValue:isSetValue];
}

-(void)adjustBottomConstraintToSuperView:(NSNumber *)value isSetValue:(BOOL)isSetValue {
    [self adjustConstraintsToSuperViewWithTop:nil left:nil right:nil bottom:value width:nil height:nil isSetValue:isSetValue];
}

- (void)adjustWidthConstraintToSuperView:(NSNumber *)value isSetValue:(BOOL)isSetValue {
    [self adjustConstraintsToSuperViewWithTop:nil left:nil right:nil bottom:nil width:value height:nil isSetValue:isSetValue];
}

-(void)adjustHeightConstraintToSuperView:(NSNumber *)value isSetValue:(BOOL)isSetValue {
    [self adjustConstraintsToSuperViewWithTop:nil left:nil right:nil bottom:nil width:nil height:value isSetValue:isSetValue];
}

-(NSArray *)getTopConstraints {
    NSMutableArray *cs = [NSMutableArray array];
    for (NSLayoutConstraint *constraint in self.constraints) {
        if ([constraint isTopOf:self]) {
            [cs addObject:constraint];
        }
    }
    return cs;
}

-(NSArray *)getBottomConstraints {
    NSMutableArray *cs = [NSMutableArray array];
    for (NSLayoutConstraint *constraint in self.constraints) {
        if ([constraint isBottomOf:self]) {
            [cs addObject:constraint];
        }
    }
    return cs;
}

-(NSArray *)getLeadingConstraints {
    NSMutableArray *cs = [NSMutableArray array];
    for (NSLayoutConstraint *constraint in self.constraints) {
        if ([constraint isLeftOf:self]) {
            [cs addObject:constraint];
        }
    }
    return cs;
}

-(NSArray *)getTrailingConstraints {
    NSMutableArray *cs = [NSMutableArray array];
    for (NSLayoutConstraint *constraint in self.constraints) {
        if ([constraint isRightOf:self]) {
            [cs addObject:constraint];
        }
    }
    return cs;
}

@end
