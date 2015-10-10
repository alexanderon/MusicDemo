//
//  CustomPopUpController.m
//  Music
//
//  Created by RAHUL on 9/24/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "CustomPopUpController.h"

@interface CustomPopUpController ()


@end


@implementation CustomPopUpController
@synthesize rowIndex;
@synthesize musicPlayer;
@synthesize completeArray;
@synthesize isIpodLibraryItem;
@synthesize timer;


#pragma mark - VIEW LOADING EVENTS-
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerMediaPlayerNotifications];
    
    
    MPVolumeView *myVolumeView =
    [[MPVolumeView alloc] initWithFrame: self.mpVolumeViewParentView.bounds];
    self.mpVolumeViewParentView.backgroundColor = [UIColor clearColor];
    [self.mpVolumeViewParentView addSubview: myVolumeView];
    
    isIpodLibraryItem=NO;
    self.detailView.hidden=YES;


    
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
    
    
  //  [self updateDisplay];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - MUSIC-PLAYER NOTIFICATION -

-(void)registerMediaPlayerNotifications{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self
                           selector:@selector(playerItemDidReachEnd:)
                               name:AVPlayerItemDidPlayToEndTimeNotification
                             object:[musicPlayer currentItem]];
    
    
}

- (void)playerItemDidReachEnd:(NSNotification *)notification{
    [self.sliderProgress setValue:0.0 animated:YES];
    [self btnNextClick:nil];
    [self  sliderValueChange:nil];
}

#pragma mark - IBACTIONS - CUSTOMVIEW

- (IBAction)btnPlayClick:(id)sender {
    
    UIButton *button =(UIButton *)sender;
    
    //updating the now playing information
    NSMutableDictionary *nowPlayingInfo = [[MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo mutableCopy];
    
    
    if(musicPlayer.rate == 1.0){
        [button setImage:[UIImage imageNamed:@"Play-icon.png"] forState:UIControlStateNormal];
        [self.btnPlay setImage:[UIImage imageNamed:@"Play-icon.png"] forState:UIControlStateNormal];
        [self.btnPlay2 setImage:[UIImage imageNamed:@"Play-icon.png"] forState:UIControlStateNormal];
        [musicPlayer pause];
        
        [nowPlayingInfo setObject:[NSNumber numberWithDouble:0.0]
                           forKey:MPNowPlayingInfoPropertyPlaybackRate];
        
        [nowPlayingInfo setObject:[NSNumber numberWithDouble:[self currentPlayBackTime]]
                           forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        
        
        
    }else{
        
        [button setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];
        [self.btnPlay setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];
        [self.btnPlay2 setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];
        [musicPlayer play];
        
        NSLog(@"%f",[self currentPlayBackTime]);
        
        [nowPlayingInfo setObject:[NSNumber numberWithDouble:1.0]
                           forKey:MPNowPlayingInfoPropertyPlaybackRate];
        
        
        
        [nowPlayingInfo setObject:[NSNumber numberWithDouble:[self currentPlayBackTime]]
                           forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        
        
        
    }
    
    
    
[MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nowPlayingInfo;
    
}

#pragma mark - CURRUNT PLAYBACK TIME

-(NSTimeInterval)currentPlayBackTime{
    CMTime time =self.musicPlayer.currentTime;
    
    //  NSLog(@"%lld",time.value/time.timescale);
    
    if (CMTIME_IS_VALID(time)) {
     //   NSLog(@"%d:%d",(int)CMTimeGetSeconds(time)/60,(int)CMTimeGetSeconds(time)%60);
        return time.value/time.timescale;
    }
    return 0;
}

#pragma mark - IBACTIONS  - DETAILVIEW

- (IBAction)btnBackClick:(id)sender{
    
    [UIView animateWithDuration:1.5 animations:^{
        self.detailView.hidden=YES;
    }];
    
    
}

- (IBAction)btnPrevClick:(id)sender {
    [timer invalidate];
    
    
    if([self.currentIndex integerValue] >0){
        self.btnPrev.enabled=YES;
        self.currentIndex=[NSNumber numberWithInt:[self.currentIndex intValue]-1];
        NSURL *url;
        if ([[self.completeArray objectAtIndex:[self.currentIndex intValue]] isKindOfClass:[MDAudioFile class]])
        {
            url = [(MDAudioFile *)[self.completeArray objectAtIndex:[self.currentIndex intValue]] filePath];
        }
        else
        {
            url = [(MPMediaItem*)[self.completeArray objectAtIndex:[self.currentIndex intValue]] valueForProperty:MPMediaItemPropertyAssetURL];
        }
        AVPlayerItem *playerItem =[[AVPlayerItem alloc]initWithURL:url];
        
        
        if(!musicPlayer){
            musicPlayer =[[AVPlayer alloc]initWithPlayerItem:playerItem];
        }else{
            [musicPlayer replaceCurrentItemWithPlayerItem:playerItem];
        }
        
        [musicPlayer play];
        [self performSelector:@selector(updateDisplay) withObject:nil afterDelay:0];
        timer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updates) userInfo:nil repeats:YES];
        self.btnNext.enabled=YES;
        
        
    }else{
        self.btnPrev.enabled=NO;
        
    }
    
       [self.sliderProgress setValue:0 animated:YES];
    
}

- (IBAction)btnNextClick:(id)sender {
   
    [timer invalidate];
    
    if([self.currentIndex intValue] < self.completeArray.count-1){
        self.btnNext.enabled=YES;
        self.currentIndex=[NSNumber numberWithInt:[self.currentIndex intValue]+1];
        NSURL *url;
        if ([[self.completeArray objectAtIndex:[self.currentIndex intValue]] isKindOfClass:[MDAudioFile class]])
        {
            url = [(MDAudioFile *)[self.completeArray objectAtIndex:[self.currentIndex intValue]] filePath];
        }
        else
        {
            url = [(MPMediaItem*)[self.completeArray objectAtIndex:[self.currentIndex intValue]] valueForProperty:MPMediaItemPropertyAssetURL];
        }
        AVPlayerItem *playerItem =[[AVPlayerItem alloc]initWithURL:url];
        NSLog(@"%@",playerItem);
        NSLog(@"%@",playerItem.tracks);
        NSLog(@"%f",CMTimeGetSeconds([playerItem duration]));
        
        
        if(!musicPlayer  && playerItem){
            musicPlayer =[[AVPlayer alloc]initWithPlayerItem:playerItem];
        }else{
            [musicPlayer replaceCurrentItemWithPlayerItem:playerItem];
        }
        
        [musicPlayer play];
        [self performSelector:@selector(updateDisplay) withObject:nil afterDelay:0];
        timer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updates) userInfo:nil repeats:YES];
        self.btnPrev.enabled=YES;
        
    }else{
        self.btnNext.enabled=NO;
        
    }
    
       [self.sliderProgress setValue:0 animated:YES];
    
    
}

- (IBAction)btnRepeatClick:(id)sender{
    
    UIButton *button =(UIButton *)sender;
    
    if(button.tag ==0){
        [button setTag:1];
        //     [musicPlayer setRepeatMode:MPMusicRepeatModeOne];
        [self.btnRepeat setImage:[UIImage imageNamed:@"repeat1.png"] forState:UIControlStateNormal];
    }else if (button.tag ==1){
        [button setTag:2];
        //     [musicPlayer setRepeatMode:MPMusicRepeatModeAll];
        [self.btnRepeat setImage:[UIImage imageNamed:@"repeat.png"] forState:UIControlStateNormal];
    }
    else{
        [button setTag:0];
        //    [musicPlayer setRepeatMode:MPMusicRepeatModeNone];
        [self.btnRepeat setImage:[UIImage imageNamed:@"rep"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)btnSuffleClick:(id)sender{
    UIButton *button =(UIButton *)sender;
    
    if (button.tag ==3) {
        [button setTag:4];
        //     [musicPlayer setShuffleMode:MPMusicShuffleModeSongs];
        [self.btnSuffle setBackgroundColor:[UIColor redColor]];
    }
    else{
        [button setTag:3];
        //        [musicPlayer setShuffleMode:MPMusicShuffleModeOff];
        [self.btnSuffle setBackgroundColor:[UIColor yellowColor]];
    }
    
    
    
    
}

- (IBAction)sliderValueChange:(id)sender {
    
    
    if(sender){
        
        [self.musicPlayer seekToTime:CMTimeMake((self.sliderProgress.value), 1)];
        int minutes;
        int sec;
        minutes=((int)self.sliderProgress.value)/60;
        sec=((int)self.sliderProgress.value)%60;
        NSLog(@"%d.%d",minutes,sec);
        self.lblSongCurrentState.text=[NSString stringWithFormat:@"%d.%02d",minutes,sec];
        
        minutes=(((int)((int)self.sliderProgress.maximumValue-(int)self.sliderProgress.value))/60);
        sec=(((int)((int)self.sliderProgress.maximumValue-(int)self.sliderProgress.value))%60);
        self.lblSongRemainigState.text=[NSString stringWithFormat:@"%d.%02d",minutes,sec];
        
    }else{
        
        
        
        float currentTime =CMTimeGetSeconds([self.musicPlayer currentTime]);
        float totolTime =CMTimeGetSeconds([self.musicPlayer.currentItem duration]);
        
        
        int minutes;
        int sec;
        minutes=((int)currentTime)/60;
        sec=((int)currentTime)%60;
        NSLog(@"%d.%d",minutes,sec);
        self.lblSongCurrentState.text=[NSString stringWithFormat:@"%d.%02d",minutes,sec];
        
        minutes=(((int)((int)totolTime-(int)currentTime))/60);
        sec=(((int)((int)totolTime-(int)currentTime))%60);
        self.lblSongRemainigState.text=[NSString stringWithFormat:@"%d.%02d",minutes,sec];
        
    }
    
    NSMutableDictionary *nowPlayingInfo = [[MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo mutableCopy];
    CMTime time =self.musicPlayer.currentTime;
    
    [nowPlayingInfo setObject:[NSNumber numberWithDouble:(time.value/time.timescale)]
                       forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nowPlayingInfo;
    
}

- (IBAction)sliderTouchedInside:(id)sender {
    
    NSMutableDictionary *nowPlayingInfo = [[MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo mutableCopy];
    CMTime time =self.musicPlayer.currentTime;
    
    [nowPlayingInfo setObject:[NSNumber numberWithDouble:(time.value/time.timescale)]
                       forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    
    
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nowPlayingInfo;
    
}

- (IBAction)sliderTouchedOutSide:(id)sender {
    
    NSMutableDictionary *nowPlayingInfo = [[MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo mutableCopy];
    CMTime time =self.musicPlayer.currentTime;
    
    [nowPlayingInfo setObject:[NSNumber numberWithDouble:(time.value/time.timescale)]
                       forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    
    
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nowPlayingInfo;
    
}


#pragma -mark - UPDATES -

-(void)updates{
    
    if (musicPlayer.rate == 1.0) {
        self.sliderProgress.value+=1;
        [self sliderValueChange:nil];
    }
}

-(void)updateDisplay{
    
   
    [self.sliderProgress setMinimumValue:0.00];

    
    if(musicPlayer.rate == 1.0){
        
        [self.btnPlay setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];
        [self.btnPlay2 setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];
        
    }
    else{
        
        [self.btnPlay setImage:[UIImage imageNamed:@"Play-icon.png"] forState:UIControlStateNormal];
        [self.btnPlay2 setImage:[UIImage imageNamed:@"Play-icon.png"] forState:UIControlStateNormal];
        
        
    }
    
    if ([[self.completeArray objectAtIndex:[self.currentIndex intValue]] isKindOfClass:[MDAudioFile class]]){
        {
            NSString *titleString = [[self.completeArray objectAtIndex:[self.currentIndex intValue]] title];
            if (titleString) {
                self.lblTitle.text = titleString;
                self.lblSongTitle.text =titleString;
            } else {
                self.lblTitle.text = @"Unknown title";
                self.lblSongTitle.text=@"Unknown title";
            }
            
            NSString *artistString = nil;
            if (artistString) {
                self.lblSubtitle.text = artistString;
                self.lblAlbumTitle.text =artistString;
            } else {
                self.lblSubtitle.text = @"Unknown artist";
                self.lblAlbumTitle.text=@"Unknown artist";
            }
            
            [self.imageView setImage:[UIImage imageNamed:@"No-artwork-albums.png"]];
            [self.imgDetailVIew setImage:[UIImage imageNamed:@"No-artwork-albums.png"]];
        }
    }
    else{
        {
            MPMediaItem *selectedItem = [[self.completeArray objectAtIndex:[self.currentIndex intValue]] representativeItem];
            MPMediaItemArtwork *artwork = [selectedItem valueForProperty: MPMediaItemPropertyArtwork];
            UIImage *artworkImage = [artwork imageWithSize: CGSizeMake (60 ,60)];
            
            if (!artworkImage) {
                artworkImage = [UIImage imageNamed:@"No-artwork-albums.png"];
            }
            
           [self.imageView setImage:artworkImage];
            
            artworkImage=[artwork imageWithSize:CGSizeMake(self.imgDetailVIew.frame.size.height, self.imgDetailVIew.frame.size.width)];
            [self.imgDetailVIew setImage:artworkImage];
            
            
            NSString *titleString = [selectedItem valueForProperty:MPMediaItemPropertyTitle];
            if (titleString) {
                self.lblTitle.text = titleString;
                self.lblSongTitle.text=titleString;
            } else {
                self.lblTitle.text = @"Unknown title";
                self.lblSongTitle.text =@"Unknown title";
            }
            
            NSString *artistString = [selectedItem valueForProperty:MPMediaItemPropertyArtist];
            if (artistString) {
                self.lblSubtitle.text = artistString;
                self.lblAlbumTitle.text=artistString;
            } else {
                self.lblSubtitle.text = @"Unknown artist";
                self.lblAlbumTitle.text=@"Unknown artist";
            }
        }
        
    }
    
    @try {
      
        if (isIpodLibraryItem) {
            MPMediaItem * item =(MPMediaItem *)[self.completeArray objectAtIndex:[self.currentIndex intValue]];
            NSLog(@"%@",[item valueForProperty:MPMediaItemPropertyPlaybackDuration] );
            
            [self.sliderProgress  setMaximumValue:[[item valueForProperty:MPMediaItemPropertyPlaybackDuration] floatValue]];
                 }else{
            [self.sliderProgress setMaximumValue:[(MDAudioFile *)[self.completeArray objectAtIndex:[self.currentIndex intValue] ]duration ] ];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
    }
    
    [self updateNowPlayingInfo];
    
    
}

-(void)updateNowPlayingInfo{
    
    NSError *error =nil;
    if (error ==nil) {
        
        if ([[self.completeArray objectAtIndex:[self.currentIndex intValue]] isKindOfClass:[MDAudioFile class]])
        {
            MDAudioFile *item=(MDAudioFile*)[self.completeArray objectAtIndex:[self.currentIndex intValue]] ;
            
            UIImage *artwork = [(MDAudioFile*)[self.completeArray objectAtIndex:[self.currentIndex intValue]]coverImage];
            if (!artwork) {
                NSLog(@"no image");
            }
            
            NSString * songTitle = [[self.completeArray objectAtIndex:[self.currentIndex intValue]] title];
            NSString * artistName =[[self.completeArray objectAtIndex:[self.currentIndex intValue]] artist];
            
            MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:artwork];
            
            MPNowPlayingInfoCenter *infoCenter = [MPNowPlayingInfoCenter defaultCenter];
            
            NSDictionary *infoDict =
            [NSDictionary dictionaryWithObjects:@[songTitle,artistName,@(item.duration),@1.0,albumArt]
                                        forKeys:@[MPMediaItemPropertyTitle,
                                                  MPMediaItemPropertyArtist,
                                                  MPMediaItemPropertyPlaybackDuration,
                                                  MPNowPlayingInfoPropertyPlaybackRate,
                                                  MPMediaItemPropertyArtwork
                                                  ]];
            [infoCenter setNowPlayingInfo:infoDict];
            
   
        }
        else
        {
            NSInteger currentTimeMinutes = CMTimeGetSeconds([self.musicPlayer currentTime]) / 60;
            NSInteger currentTimeSeconds = CMTimeGetSeconds([self.musicPlayer currentTime])
            - currentTimeMinutes * 60;
            
            MPMediaItem *item=(MPMediaItem*)[self.completeArray objectAtIndex:[self.currentIndex intValue]] ;
            
            NSString *songTitle =[item valueForProperty:MPMediaItemPropertyTitle];
            NSString *artistName =[item valueForProperty:MPMediaItemPropertyAlbumArtist];
            NSString *artWork =[item valueForProperty:MPMediaItemPropertyArtwork];
            NSNumber *numDurationSeconds=[item valueForProperty:MPMediaItemPropertyPlaybackDuration];
            NSNumber *numCurrentTimeSeconds = [NSNumber numberWithInt:currentTimeSeconds];
            
            
            
            
            
            MPNowPlayingInfoCenter *infoCenter = [MPNowPlayingInfoCenter defaultCenter];
            NSDictionary *infoDict = [NSDictionary
                                      dictionaryWithObjects:@[songTitle, artistName, artWork,
                                                              numDurationSeconds,numCurrentTimeSeconds,@1.0]
                                      forKeys:@[MPMediaItemPropertyTitle,
                                                MPMediaItemPropertyAlbumArtist,
                                                MPMediaItemPropertyArtwork,
                                                MPMediaItemPropertyPlaybackDuration,
                                                MPNowPlayingInfoPropertyElapsedPlaybackTime,
                                                MPNowPlayingInfoPropertyPlaybackRate
                                                ]];
            [infoCenter setNowPlayingInfo:infoDict];
        }
        
    }
    else {
        NSLog(@"error initializing Playing audio files:audio player: %@",
              [error description]);
    }
    
}

@end
