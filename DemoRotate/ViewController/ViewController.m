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

static const NSString *ItemStatusContext;

@interface ViewController ()

@property (nonatomic) AVPlayer *player;
@property (nonatomic) AVPlayerItem *playerItem;
@property (nonatomic, strong) UIView *playerContainerView;
@property (nonatomic, strong) FullScreenAnimator *fullscreenAnimator;
@property (nonatomic, strong) MinimizeAnimator *minimizeAnimator;
@property (nonatomic, strong) RotateViewController *rotateVC;

@property (nonatomic, assign) BOOL presenting;
@property (nonatomic, assign) BOOL viewDidAppear;

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
    
    [self loadVideo];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.viewDidAppear = NO;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.viewDidAppear = YES;
}

-(BOOL)shouldAutorotate {
    if (!self.viewDidAppear || self.presenting) {
        return NO;
    }
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        NSLog(@">>> lanscape");
        self.presenting = YES;
        [self presentFullScreenVCWithOrientation:[UIDevice currentDevice].orientation completion:^{
            self.presenting = NO;
        }];
    }
    return NO;
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

-(void)loadVideo {
    if (self.playerItem) {
        [self.playerItem removeObserver:self forKeyPath:@"status" context:&ItemStatusContext];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
        self.playerItem = nil;
    }
    
    NSURL *url = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
    NSString *tracksKey = @"tracks";
    
    [asset loadValuesAsynchronouslyForKeys:@[tracksKey] completionHandler:
     ^{
         // The completion block goes here.
         dispatch_async(dispatch_get_main_queue(), ^{
             NSError *error;
             AVKeyValueStatus status = [asset statusOfValueForKey:tracksKey error:&error];
             
             if (status == AVKeyValueStatusLoaded) {
                 self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
                 // ensure that this is done before the playerItem is associated with the player
                 [self.playerItem addObserver:self forKeyPath:@"status"
                                      options:NSKeyValueObservingOptionInitial context:&ItemStatusContext];
                 [[NSNotificationCenter defaultCenter] addObserver:self
                                                          selector:@selector(playerItemDidReachEnd:)
                                                              name:AVPlayerItemDidPlayToEndTimeNotification
                                                            object:self.playerItem];
                 self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
                 [self.playerView setPlayer:self.player];
             }
             else {
                 // You should deal with the error appropriately.
                 NSLog(@"The asset's tracks were not loaded:\n%@", [error localizedDescription]);
             }
         });
     }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    
    if (context == &ItemStatusContext && [keyPath isEqualToString:@"status"]) {
        if (self.playerItem.status == AVPlayerStatusReadyToPlay) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.player play];
            });
        }
        return;
    }
    [super observeValueForKeyPath:keyPath ofObject:object
                           change:change context:context];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    [self.player seekToTime:kCMTimeZero];
}

- (IBAction)presentPressed:(id)sender {
    RotateViewController *vc = [[RotateViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)dealloc {
    [self.playerItem removeObserver:self forKeyPath:@"status" context:&ItemStatusContext];
}


@end
