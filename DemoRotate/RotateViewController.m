//
//  RotateViewController.m
//  DemoRotate
//
//  Created by Tung Nguyen on 5/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "RotateViewController.h"

@interface RotateViewController ()

@property (nonatomic, assign) BOOL isDismissing;

@end

@implementation RotateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"Dismiss" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(100, 100, 200, 60)];
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)btnPressed:(UIButton *)btn {
    self.isDismissing = YES;
    [self dismissViewControllerAnimated:YES completion:^{
        self.isDismissing = NO;
    }];
}

-(BOOL)willDismiss {
    return self.isDismissing;
}

-(BOOL)willPresent {
    return !self.isDismissing;
}

@end
