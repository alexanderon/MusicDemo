//
//  MediaPlayer.m
//  Music
//
//  Created by RAHUL on 9/24/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "MediaPlayer.h"

@implementation MediaPlayer
@synthesize musicPlayer;

#pragma mark  -singleton methods
+ (MediaPlayer*)sharedManager{
    static MediaPlayer *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (id)init {
    if (self = [super init]) {
     //   someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
        musicPlayer =[MPMusicPlayerController applicationMusicPlayer];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
