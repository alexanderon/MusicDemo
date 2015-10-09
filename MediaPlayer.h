//
//  MediaPlayer.h
//  Music
//
//  Created by RAHUL on 9/24/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface MediaPlayer : NSObject

@property(nonatomic,retain)   AVPlayer *musicPlayer;

+ (MediaPlayer*)sharedManager;

@end
