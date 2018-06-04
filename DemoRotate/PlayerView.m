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

@interface PlayerView ()

@property (nonatomic, strong) UIButton *btnFullScreen;

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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}
- (AVPlayer*)player {
    return [(AVPlayerLayer *)[self layer] player];
}
- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}

@end
