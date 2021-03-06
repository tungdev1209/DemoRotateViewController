//
//  UIActivityIndicatorView+Extension.h
//  UIExtensionProject
//
//  Created by Tung Nguyen on 1/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActivityIndicatorView (e)

+(UIActivityIndicatorView *)indicatorCustomizeIn:(UIView *)view;
-(void)startLoadingWithText:(NSString *)text;
-(void)stopLoading;

@end
