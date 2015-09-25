//
//  NowPlayingViewController.h
//  Music
//
//  Created by RAHUL on 9/22/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface NowPlayingViewController : UIViewController
{
    MPMusicPlayerController *musicPlayer;
    
    IBOutlet UIImageView *artworkImageView;
    
    
    IBOutlet UIButton * playPauseButton;
    IBOutlet UISlider * volumeSlider;
    
    
    IBOutlet UILabel * artistLabel;
    IBOutlet UILabel * titleLabel;
    IBOutlet UILabel * albumLabel;
}
@property(nonatomic,retain)MPMusicPlayerController *musicPlayer;
-(IBAction)playPause:(id)sender;
-(IBAction)nextSong:(id)sender;
- (IBAction)previousSong:(id)sender;
- (IBAction)volumeSliderChanged:(id)sender;

- (void) registerMediaPlayerNotifications;

@end
