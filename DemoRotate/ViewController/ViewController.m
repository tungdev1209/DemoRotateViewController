//
//  ViewController.m
//  DemoRotate
//
//  Created by Tung Nguyen on 5/29/18.
//  Copyright © 2018 Tung Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "RotateViewController.h"
#import <AVKit/AVKit.h>
#import "PlayerView.h"
#import "UI+Extension.h"
#import "Foundation+Extension.h"
#import "Utilities.h"
#import "FullScreenAnimator.h"
#import "MinimizeAnimator.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *playerContainerView;
@property (nonatomic, strong) FullScreenAnimator *fullscreenAnimator;
@property (nonatomic, strong) MinimizeAnimator *minimizeAnimator;
@property (nonatomic, strong) RotateViewController *rotateVC;

@property (nonatomic, assign) BOOL presenting;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.playerContainerView = [[UIView alloc] init];
    [self.view addSubview:self.playerContainerView];
    [NSLayoutConstraint activateTop:0 forView:self.playerContainerView];
    [NSLayoutConstraint activateRight:0 forView:self.playerContainerView];
    [NSLayoutConstraint activateLeft:0 forView:self.playerContainerView];
    
    CGFloat height = MainWidth * MainWidth / MainHeight;
    [NSLayoutConstraint activateConstraints:@[[NSLayoutConstraint constraintWithItem:self.playerContainerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:height]]];
    
    self.playerView = [[PlayerView alloc] init];
    [self.playerView setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.playerView loadVideo];
    
    weakify(self);
    [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceOrientationDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        strongify(self);
        if (isLandscape) {
            [self presentFullScreenVCWithOrientation:MainOrientation completion:nil];
        }
    }];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    if (size.width > size.height) {
        NSLog(@"viewWillTransitionToSize");
    }
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)setPlayerView:(PlayerView *)playerView {
    _playerView = playerView;
    [_playerView setIsPresenting:YES];
    [self.view addSubview:_playerView];
    
    [self.playerContainerView addSubview:_playerView];
    [NSLayoutConstraint activateFullScreen:_playerView];
    
    weakify(self);
    [self.playerView setFullScreen:^{
        strongify(self);
        [self presentFullScreenVCWithOrientation:UIDeviceOrientationLandscapeLeft completion:nil];
    }];
}

#pragma mark - FullScreen function
-(void)presentFullScreenVCWithOrientation:(UIDeviceOrientation)orientation completion:(void(^)(void))completion {
    RotateViewController *vc = [[RotateViewController alloc] init];
    vc.parentVC = self;
    vc.transitioningDelegate = self;
    self.rotateVC = vc;
    self.fullscreenAnimator.orientation = orientation;
    [self presentViewController:vc animated:YES completion:completion];
}

#pragma mark UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.fullscreenAnimator;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.minimizeAnimator;
}

-(FullScreenAnimator *)fullscreenAnimator {
    if (!_fullscreenAnimator) {
        _fullscreenAnimator = [[FullScreenAnimator alloc] init];
        weakify(self);
        _fullscreenAnimator.getVideoSize = ^CGSize{
            strongify(self);
            return self.playerContainerView.frame.size;
        };
        
        _fullscreenAnimator.beginAnimation = ^{
            strongify(self);
            [self.rotateVC setPlayerView:self.playerView];
        };
    }
    return _fullscreenAnimator;
}

-(MinimizeAnimator *)minimizeAnimator {
    if (!_minimizeAnimator) {
        _minimizeAnimator = [[MinimizeAnimator alloc] init];
        weakify(self);
        _minimizeAnimator.getVideoSize = ^CGSize{
            strongify(self);
            return self.playerContainerView.frame.size;
        };
    }
    return _minimizeAnimator;
}

- (IBAction)presentPressed:(id)sender {
    RotateViewController *vc = [[RotateViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
