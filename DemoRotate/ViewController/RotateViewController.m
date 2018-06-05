//
//  RotateViewController.m
//  DemoRotate
//
//  Created by Tung Nguyen on 5/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "RotateViewController.h"
#import "Foundation+Extension.h"
#import "UI+Extension.h"
#import "Utilities.h"

@interface RotateViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) BOOL isDismissing;
@property (nonatomic, assign) BOOL dismissing;

@end

@implementation RotateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"Dismiss" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(100, 100, 200, 60)];
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(BOOL)shouldAutorotate {
    if (MainOrientation == UIDeviceOrientationPortraitUpsideDown) {
        return NO;
    }
    if (UIDeviceOrientationIsLandscape(MainOrientation)) {
        return YES;
    }
    [self dismiss];
    return NO;
}

-(void)btnPressed:(UIButton *)btn {
    [self dismiss];
}

-(void)dismiss {
    self.isDismissing = YES;
    [self dismissViewControllerAnimated:YES completion:^{
        [self.parentVC setPlayerView:self.playerView];
        self.isDismissing = NO;
    }];
}

-(void)setPlayerView:(PlayerView *)playerView {
    _playerView = playerView;
    [_playerView setIsPresenting:NO];
    [self.view addSubview:_playerView];
    [NSLayoutConstraint activateFullScreen:_playerView];
    
    weakify(self);
    [_playerView setMinimizeScreen:^{
        strongify(self);
        [self btnPressed:nil];
    }];
}

-(void)beginPresentingAnimation {
    _playerView.layer.frame = CGRectMake(0, 0, _playerView.frame.size.width, _playerView.frame.size.height);
}

-(BOOL)willDismiss {
    return self.isDismissing;
}

-(BOOL)willPresent {
    return !self.isDismissing;
}

@end
