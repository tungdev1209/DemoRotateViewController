//
//  UIActivityIndicatorView+Extension.m
//  UIExtensionProject
//
//  Created by Tung Nguyen on 1/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "UIActivityIndicatorView+Extension.h"
#import "UIView+Extension.h"
#import "Foundation+Extension.h"
#import <objc/runtime.h>

#define IndicatorMainViewTag 1001
#define IndicatorLabelViewTag 1002
#define IndicatorOffset 15.0f * (-1)

const void *kWidthConstraint = &kWidthConstraint;
const void *kIndiCenterYConstraint = &kIndiCenterYConstraint;

@interface UIActivityIndicatorView ()

@property (nonatomic, strong) NSLayoutConstraint *mainWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *indicatorCenterYConstraint;

@end

@implementation UIActivityIndicatorView (e)

#pragma mark - Properties
#pragma mark mainWidthConstraint
-(void)setMainWidthConstraint:(NSLayoutConstraint *)mainWidthConstraint {
    objc_setAssociatedObject(self, kWidthConstraint, mainWidthConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSLayoutConstraint *)mainWidthConstraint {
    return objc_getAssociatedObject(self, kWidthConstraint);
}

#pragma mark indicatorCenterYConstraint
-(void)setIndicatorCenterYConstraint:(NSLayoutConstraint *)indicatorCenterYConstraint {
    objc_setAssociatedObject(self, kIndiCenterYConstraint, indicatorCenterYConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSLayoutConstraint *)indicatorCenterYConstraint {
    return objc_getAssociatedObject(self, kIndiCenterYConstraint);
}

#pragma mark - Functions
#pragma mark private
-(BOOL)isCustomIndicator {
    return self.superview != nil && self.superview.tag == IndicatorMainViewTag;
}

#pragma mark public
+(UIActivityIndicatorView *)indicatorCustomizeIn:(UIView *)view {
    UIView *mainView = [[UIView alloc] init];
    mainView.tag = IndicatorMainViewTag;
    mainView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5f];
    mainView.hidden = YES;
    [mainView addCorner:8.0f borderWidth:0.0f];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    UILabel *label = [[UILabel alloc] init];
    label.tag = IndicatorLabelViewTag;
    label.text = @"Loading...";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:18.0f];
    
    [view addSubview:mainView];
    [mainView addSubview:indicator];
    [mainView addSubview:label];
    
    indicator.mainWidthConstraint = [NSLayoutConstraint activateWidth:100 forView:mainView];
    [NSLayoutConstraint activateHeight:100 forView:mainView];
    [NSLayoutConstraint activateCenter:mainView];
    
    [NSLayoutConstraint activateWidth:50 forView:indicator];
    [NSLayoutConstraint activateHeight:50 forView:indicator];
    [NSLayoutConstraint activateCenterX:indicator];
    indicator.indicatorCenterYConstraint = [NSLayoutConstraint activateCenterY:indicator];
    indicator.indicatorCenterYConstraint.constant = IndicatorOffset;
    
    [NSLayoutConstraint activateRight:10 forView:label];
    [NSLayoutConstraint activateLeft:10 forView:label];
    [NSLayoutConstraint activateHeight:40 forView:label];
    [NSLayoutConstraint activateTop:60 forView:label];
    
    [view setNeedsLayout];
    
    [indicator startAnimating];
    return indicator;
}

-(void)startLoadingWithText:(NSString *)text {
    if (![self isCustomIndicator]) {
        return;
    }
    
    NSString *labelText = text;
    if (labelText.length == 0) {
        labelText = @"";
        self.indicatorCenterYConstraint.constant = 0.0f;
    }
    else {
        self.indicatorCenterYConstraint.constant = IndicatorOffset;
    }
    
    UILabel *label;
    for (UIView *v in self.superview.subviews) {
        if (v.tag == IndicatorLabelViewTag) {
            label = (UILabel *)v;
            break;
        }
    }
    
    if (!!label) {
        label.text = labelText;
        CGFloat newWidth = label.intrinsicContentSize.width + 20.0f;
        newWidth = MIN(MAX(newWidth, 100.0), 250.0);
        self.mainWidthConstraint.constant = newWidth;
    }
    
    [self.superview setNeedsUpdateConstraints];
    [self.superview layoutIfNeeded];
    
    self.superview.hidden = NO;
}

-(void)stopLoading {
    if (![self isCustomIndicator]) {
        return;
    }
    self.superview.hidden = YES;
    [self.superview removeFromSuperview];
}

@end
