//
//  PlayerView.h
//  ClientPlayer
//
//  Created by Tung Nguyen on 9/12/17.
//  Copyright © 2017 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerView : UIView

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) void(^fullScreen)(void);
@property (nonatomic, strong) void(^minimizeScreen)(void);
@property (nonatomic, assign) BOOL isPresenting;

-(void)loadVideo;

@end
