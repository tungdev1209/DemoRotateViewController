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

@interface RotateViewController ()

@property (nonatomic, assign) BOOL isDismissing;

@end

@implementation RotateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"Dismiss" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(100, 100, 200, 60)];
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        CGAffineTransform t = CGAffineTransformMakeRotation(-90 * M_PI / 180);
//        t = CGAffineTransformConcat(t, CGAffineTransformMakeScale(180.0 / 375.0, 375.0 / 667.0));
//        t = CGAffineTransformConcat(t, CGAffineTransformMakeTranslation(-(667.0 - 180.0)/2.0, 0.0));
//        self.playerView.transform = t;
//    });
}

-(void)btnPressed:(UIButton *)btn {
    self.isDismissing = YES;
    [self.parentVC setPlayerView:self.playerView];
    [self dismissViewControllerAnimated:YES completion:^{
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
