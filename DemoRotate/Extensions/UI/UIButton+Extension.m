//
//  UIButton+Extension.m
//  UIExtensionProject
//
//  Created by Tung Nguyen on 1/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

const void *kPressed = &kPressed;

@interface UIButton()

@property (nonatomic, strong) void(^didPressedBlock)(UIButton *button);

@end

@implementation UIButton (e)

#pragma mark - Properties
#pragma mark didPressedBlock
-(void)setDidPressedBlock:(void (^)(UIButton *))didPressedBlock {
    objc_setAssociatedObject(self, kPressed, didPressedBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void (^)(UIButton *))didPressedBlock {
    return objc_getAssociatedObject(self, kPressed);
}

#pragma mark - Functions
#pragma mark public
-(void)addPressed:(void(^)(UIButton *))didPressed {
    self.didPressedBlock = didPressed;
    [self addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark private
-(void)btnPressed:(UIButton *)button {
    self.didPressedBlock(button);
}

@end
