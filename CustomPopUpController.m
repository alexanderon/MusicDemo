//
//  CustomPopUpController.m
//  Music
//
//  Created by RAHUL on 9/24/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "CustomPopUpController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MDAudioFile.h"

@interface CustomPopUpController ()


@end


@implementation CustomPopUpController
@synthesize rowIndex;
@synthesize musicPlayer;
@synthesize completeArray;


#pragma mark - view loading-
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    
    if ([[self.completeArray objectAtIndex:self.rowIndex] isKindOfClass:[MDAudioFile class]])
    {
        {
            NSString *titleString = [[self.completeArray objectAtIndex:self.rowIndex] title];
            if (titleString) {
                self.lblTitle.text = titleString;
            } else {
                self.lblTitle.text = @"Unknown title";
            }
            
            NSString *artistString = nil;
            if (artistString) {
                self.lblSubtitle.text = artistString;
            } else {
                self.lblSubtitle.text = @"Unknown artist";
            }
        }
        
    }
    else
    {
        MPMediaItem *selectedItem = [[completeArray objectAtIndex:rowIndex] representativeItem];
        MPMediaItemArtwork *artwork = [selectedItem valueForProperty: MPMediaItemPropertyArtwork];
        UIImage *artworkImage = [artwork imageWithSize: CGSizeMake (60 ,60)];
        
        if (!artworkImage) {
            artworkImage = [UIImage imageNamed:@"No-artwork.png"];
        }
        
        [self.imageView setImage:artworkImage];
        
        {
            NSString *titleString = [selectedItem valueForProperty:MPMediaItemPropertyTitle];
            if (titleString) {
                self.lblTitle.text = titleString;
            } else {
                self.lblTitle.text = @"Unknown title";
            }
            
            NSString *artistString = [selectedItem valueForProperty:MPMediaItemPropertyArtist];
            if (artistString) {
                self.lblSubtitle.text = artistString;
            } else {
                self.lblSubtitle.text = @"Unknown artist";
            }
        }
        
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - IBACTIONS - CUSTOMVIEW

- (IBAction)btnPlayClick:(id)sender {
    
    UIButton *button =(UIButton *)sender;
    
    //updating the now playing information
    NSMutableDictionary *nowPlayingInfo = [[MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo mutableCopy];
    
    
    if(musicPlayer.rate == 1.0){
        [button setImage:[UIImage imageNamed:@"Play-icon.png"] forState:UIControlStateNormal];
        [self.btnPlay setImage:[UIImage imageNamed:@"Play-icon.png"] forState:UIControlStateNormal];
        [musicPlayer pause];
        
        [nowPlayingInfo setObject:[NSNumber numberWithDouble:0.0]
                           forKey:MPNowPlayingInfoPropertyPlaybackRate];
        
        [nowPlayingInfo setObject:[NSNumber numberWithDouble:[self currentPlayBackTime]]
                           forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        
        
        
    }else{
        
        [button setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];
        [self.btnPlay setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];
        [musicPlayer play];
        
        NSLog(@"%f",[self currentPlayBackTime]);
        
        [nowPlayingInfo setObject:[NSNumber numberWithDouble:1.0]
                           forKey:MPNowPlayingInfoPropertyPlaybackRate];
        
        
        
        [nowPlayingInfo setObject:[NSNumber numberWithDouble:[self currentPlayBackTime]]
                           forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        
        
        
    }
    
    
    
    //    [nowPlayingInfo setObject:[NSNumber numberWithDouble:self.musicPlayer.rate]
    //                       forKey:MPNowPlayingInfoPropertyPlaybackRate];
    //    [nowPlayingInfo setObject:[NSNumber numberWithDouble:[self currentPlayBackTime]]
    //                       forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nowPlayingInfo;
    
}

#pragma mark - CURRUNT PLAYBACK TIME

-(NSTimeInterval)currentPlayBackTime{
    CMTime time =self.musicPlayer.currentTime;
    
    //  NSLog(@"%lld",time.value/time.timescale);
    
    if (CMTIME_IS_VALID(time)) {
        NSLog(@"%d:%d",(int)CMTimeGetSeconds(time)/60,(int)CMTimeGetSeconds(time)%60);
        return time.value/time.timescale;
    }
    return 0;
}


@end
