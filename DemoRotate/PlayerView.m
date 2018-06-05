//
//  PlayerView.m
//  ClientPlayer
//
//  Created by Tung Nguyen on 9/12/17.
//  Copyright © 2017 Tung Nguyen. All rights reserved.
//

#import "PlayerView.h"
#import "Foundation+Extension.h"
#import "UI+Extension.h"

static const NSString *ItemStatusContext;

@interface PlayerView ()

@property (nonatomic, strong) UIButton *btnFullScreen;
@property (nonatomic) AVPlayerItem *playerItem;

@end

@implementation PlayerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.btnFullScreen = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btnFullScreen.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [self.btnFullScreen setShowsTouchWhenHighlighted:YES];
        [self addSubview:self.btnFullScreen];
        
        [NSLayoutConstraint activateRight:5 forView:self.btnFullScreen];
        [NSLayoutConstraint activateBottom:5 forView:self.btnFullScreen];
        [NSLayoutConstraint activateWidth:30 forView:self.btnFullScreen];
        [NSLayoutConstraint activateHeight:30 forView:self.btnFullScreen];
    }
    return self;
}

-(void)setFullScreen:(void (^)(void))fullScreen {
    [self.btnFullScreen addPressed:^(UIButton *btn) {
        fullScreen();
    }];
}

-(void)setMinimizeScreen:(void (^)(void))minimizeScreen {
    [self.btnFullScreen addPressed:^(UIButton *btn) {
        minimizeScreen();
    }];
}

-(void)setIsPresenting:(BOOL)isPresenting {
    if (isPresenting) {
        [self.btnFullScreen setTitle:@"+" forState:UIControlStateNormal];
    }
    else {
        [self.btnFullScreen setTitle:@"-" forState:UIControlStateNormal];
    }
}

#pragma mark - Core Video Layer
+ (Class)layerClass {
    return [AVPlayerLayer class];
}
- (AVPlayer*)player {
    return [(AVPlayerLayer *)[self layer] player];
}
- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}

#pragma mark - Loading Video funcs
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
            NSLog(@">>> videoLoaded");
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

-(void)dealloc {
    [self.playerItem removeObserver:self forKeyPath:@"status" context:&ItemStatusContext];
}

@end
