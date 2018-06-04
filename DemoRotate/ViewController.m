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

static const NSString *ItemStatusContext;

@interface ViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic) AVPlayer *player;
@property (nonatomic) AVPlayerItem *playerItem;
@property (nonatomic, strong) FullScreenAnimator *fullscreenAnimator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.playerView = [[PlayerView alloc] init];
    [self.playerView setBackgroundColor:[UIColor lightGrayColor]];
    
    [self loadVideo];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)setPlayerView:(PlayerView *)playerView {
    _playerView = playerView;
    [_playerView setIsPresenting:YES];
    [self.view addSubview:_playerView];
    [NSLayoutConstraint activateTop:0 forView:_playerView];
    [NSLayoutConstraint activateRight:0 forView:_playerView];
    [NSLayoutConstraint activateLeft:0 forView:_playerView];
    
    CGFloat height = MainWidth * MainWidth / MainHeight;
    [NSLayoutConstraint activateConstraints:@[[NSLayoutConstraint constraintWithItem:_playerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:height]]];
    
    weakify(self);
    [self.playerView setFullScreen:^{
        strongify(self);
        [self presentFullScreenVC];
    }];
}

#pragma mark - FullScreen function
-(void)presentFullScreenVC {
    RotateViewController *vc = [[RotateViewController alloc] init];
    vc.parentVC = self;
    [vc setPlayerView:self.playerView];
    vc.transitioningDelegate = self;
//    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.fullscreenAnimator;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return nil;
}

-(FullScreenAnimator *)fullscreenAnimator {
    if (!_fullscreenAnimator) {
        _fullscreenAnimator = [[FullScreenAnimator alloc] init];
    }
    return _fullscreenAnimator;
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
