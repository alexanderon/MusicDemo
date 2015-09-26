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
@synthesize rowIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
      musicPlayer =[MediaPlayer sharedManager].musicPlayer;
      [self registerMediaPlayerNotifications];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];

    
    
        MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
        NSArray *songs = [songsQuery items];
    
        MPMediaItem *selectedItem = [[songs objectAtIndex:rowIndex] representativeItem];
        [musicPlayer setQueueWithItemCollection:[MPMediaItemCollection collectionWithItems:songs]];
        [musicPlayer setNowPlayingItem:selectedItem];
        [musicPlayer play];
    
    [self.btnPlay setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];    
    
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


- (void) registerMediaPlayerNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_PlaybackStateChanged:)
                               name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
                             object: musicPlayer];
    
  
    
    [musicPlayer beginGeneratingPlaybackNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
    
    /*[[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                                  object: musicPlayer];
    
    
    [musicPlayer endGeneratingPlaybackNotifications];*/
}



- (void) handle_PlaybackStateChanged: (id) notification
{
    MPMusicPlaybackState playbackState = [musicPlayer playbackState];
    
  //  NSLog(@"%d",[musicPlayer playbackState]);
    
    if (playbackState == MPMusicPlaybackStatePaused || playbackState==MPMusicPlaybackStateStopped) {

    } else if (playbackState == MPMusicPlaybackStatePlaying) {
      
    }
}

- (IBAction)btnPlayClick:(id)sender {
   
    if ([musicPlayer playbackState] == MPMusicPlaybackStatePlaying) {
        [musicPlayer pause];
        [self.btnPlay setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];
    } else {
        
        [musicPlayer play];
        [self.btnPlay setImage:[UIImage imageNamed:@"Play-icon.png"] forState:UIControlStateNormal];
           }

}


@end
