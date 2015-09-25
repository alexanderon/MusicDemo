//
//  CustomPopUpController.m
//  Music
//
//  Created by RAHUL on 9/24/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "CustomPopUpController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface CustomPopUpController ()
{
MPMusicPlayerController *musicPlayer;
}
//@property(nonatomic,strong)MPMusicPlayerController *musicPlayer;
@end


@implementation CustomPopUpController
//@synthesize musicPlayer;
- (void)viewDidLoad {
    [super viewDidLoad];
    musicPlayer =[MediaPlayer sharedManager].musicPlayer;
    // Do any additional setup after loading the view from its nib.
    [self registerMediaPlayerNotifications];
}


- (void) registerMediaPlayerNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_NowPlayingItemChanged:)
                               name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                             object: musicPlayer];
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_PlaybackStateChanged:)
                               name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
                             object: musicPlayer];
    
 /*   [notificationCenter addObserver: self
                           selector: @selector (handle_VolumeChanged:)
                               name: MPMusicPlayerControllerVolumeDidChangeNotification
                             object: musicPlayer];*/
    
    [musicPlayer beginGeneratingPlaybackNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                                  object: musicPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                                  object: musicPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: MPMusicPlayerControllerVolumeDidChangeNotification
                                                  object: musicPlayer];
    
    [musicPlayer endGeneratingPlaybackNotifications];
}

- (void) handle_NowPlayingItemChanged: (id) notification
{
    
    if ([musicPlayer playbackState] != MPMusicPlaybackStateStopped) {
        MPMediaItem *currentItem = [musicPlayer nowPlayingItem];
        
        MPMediaItemArtwork *artwork = [currentItem valueForProperty: MPMediaItemPropertyArtwork];
        UIImage *artworkImage = [artwork imageWithSize: CGSizeMake (320, 320)];
        
        if (!artworkImage) {
            artworkImage = [UIImage imageNamed:@"No-artwork.png"];
        }
        
        [self.imageView setImage:artworkImage];
        
        NSString *titleString = [currentItem valueForProperty:MPMediaItemPropertyTitle];
        if (titleString) {
            self.lblTitle.text = titleString;
        } else {
            self.lblTitle.text = @"Unknown title";
        }
        
        NSString *artistString = [currentItem valueForProperty:MPMediaItemPropertyArtist];
        if (artistString) {
            self.lblSubtitle.text = artistString;
        } else {
            self.lblSubtitle.text = @"Unknown artist";
        }
        
        NSString *albumString = [currentItem valueForProperty:MPMediaItemPropertyAlbumTitle];
        if (albumString) {
       //     albumLabel.text = albumString;
        } else {
       //     albumLabel.text = @"Unknown album";
        }
        
    }
}

- (void) handle_PlaybackStateChanged: (id) notification
{
    MPMusicPlaybackState playbackState = [musicPlayer playbackState];
    
    if (playbackState == MPMusicPlaybackStatePaused) {
        [self.btnPlay setImage:[UIImage imageNamed:@"Play-icon.png"] forState:UIControlStateNormal];
        
        
    } else if (playbackState == MPMusicPlaybackStatePlaying) {
        [self.btnPlay setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];
        
    } else if (playbackState == MPMusicPlaybackStateStopped) {
        
        [self.btnPlay setImage:[UIImage imageNamed:@"Play-icon.png"] forState:UIControlStateNormal];
        [musicPlayer stop];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

- (IBAction)btnPlayClick:(id)sender {
    
    if ([musicPlayer playbackState] == MPMusicPlaybackStatePlaying) {
        [musicPlayer pause];
        
    } else {
        
        [musicPlayer play];
    }

}
@end
