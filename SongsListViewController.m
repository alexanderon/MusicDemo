//
//  SongsListViewController.m
//  Music
//
//  Created by RAHUL on 9/24/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//


#import "SongsListViewController.h"
#import "CustomPopUpController.h"

@interface SongsListViewController ()
{
    CustomPopUpController *vc;
    MPMusicPlayerController *musicPlayer;
}
@property(strong,nonatomic) CustomPopUpController *popUp;
@end

@implementation SongsListViewController
@synthesize popUp;

#pragma mark - view loading
- (void)viewDidLoad {
    [super viewDidLoad];
    musicPlayer =[MediaPlayer sharedManager].musicPlayer;
    [self registerMediaPlayerNotifications];

    popUp =[[CustomPopUpController alloc]init];
    vc = [[CustomPopUpController alloc]init];
    
  //  self.DetailView.frame =CGRectMake(0, 490, 320, 460);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)btnTrans
{
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         [self.ContentView needsUpdateConstraints];
                         [self.heightContentView setConstant:self.tableView.frame.size.height];
                         
                         self.DetailView.frame = CGRectMake(0,0 , self.view.frame.size.width,self.tableView.frame.size.height);
                         
                         self.btnBack.frame=CGRectMake(0, 10, 60, 60);
                         
                         /*{
                          MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
                          NSArray *songs = [songsQuery items];
                          
                          MPMediaItem *selectedItem = [[songs objectAtIndex:(int)[self.tableView indexPathForSelectedRow]] representativeItem];
                          [musicPlayer setQueueWithItemCollection:[MPMediaItemCollection collectionWithItems:songs]];
                          [musicPlayer setNowPlayingItem:selectedItem];
                          [musicPlayer play];
                          
                          [self.btnPlay setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];
                          
                          }*/
                         
                         
                     }
                     completion:^(BOOL finished){
                     }];
    
    [self.ContentView addSubview:self.DetailView];
}


#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* CellIdentifier=@"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    MPMediaQuery *songsQuery =	[MPMediaQuery songsQuery];
    NSArray *songs =[songsQuery items];
    MPMediaItem *rowItem=[songs objectAtIndex:indexPath.row];
    cell.textLabel.text=[rowItem valueForProperty:MPMediaItemPropertyTitle];
    cell.detailTextLabel.text=[rowItem valueForProperty:MPMediaItemPropertyArtist];
    return cell;

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MPMediaQuery* songsQuery =[MPMediaQuery songsQuery];
    NSArray* songs=[songsQuery items];
    return [songs count];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [vc.view removeFromSuperview];
    vc.rowIndex=(int)indexPath.row;
    vc.view.frame = CGRectMake(0,0, self.ContentView.frame.size.width, self.ContentView.frame.size.height);
    {
        MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
        NSArray *songs = [songsQuery items];
        
        MPMediaItem *selectedItem = [[songs objectAtIndex:indexPath.row] representativeItem];
        
        MPMediaItemArtwork *artwork = [selectedItem valueForProperty: MPMediaItemPropertyArtwork];
        UIImage *artworkImage = [artwork imageWithSize: CGSizeMake (60 ,60)];
        
        if (!artworkImage) {
            artworkImage = [UIImage imageNamed:@"No-artwork.png"];
        }
        
        [self.btnDisplay setImage:artworkImage forState:UIControlStateSelected];
    }
    
     [self.ContentView addSubview:vc.view];
    [vc.btnTrans addTarget:self action:@selector(btnTrans) forControlEvents:UIControlEventTouchUpInside];

}


- (IBAction)btnBackClick:(id)sender {
    [UIView animateWithDuration:1.5
                          delay:0.5
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.ContentView needsUpdateConstraints];
                         [self.heightContentView setConstant:60];
                         
                     }
                     completion:^(BOOL finished){
                         if (finished)
                             
                             [self.DetailView removeFromSuperview];
                     }];
    
}

-(IBAction)btnDetailShow:(id)sender{
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         [self.ContentView needsUpdateConstraints];
                         [self.heightContentView setConstant:self.tableView.frame.size.height];
                         
                         self.DetailView.frame = CGRectMake(0,0 , self.view.frame.size.width,self.tableView.frame.size.height);
                         
                         self.btnBack.frame=CGRectMake(0, 0, 60, 60);
                         
                    /*{
                             MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
                             NSArray *songs = [songsQuery items];
                             
                             MPMediaItem *selectedItem = [[songs objectAtIndex:(int)[self.tableView indexPathForSelectedRow]] representativeItem];
                             [musicPlayer setQueueWithItemCollection:[MPMediaItemCollection collectionWithItems:songs]];
                             [musicPlayer setNowPlayingItem:selectedItem];
                             [musicPlayer play];
                             
                             [self.btnPlay setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];
                     
                    }*/
                         
                         
                     }
                     completion:^(BOOL finished){
                     }];
    
    [self.ContentView addSubview:self.DetailView];
}


#pragma mark -button actions 

- (IBAction)btnPlayClick:(id)sender {
    if ([musicPlayer playbackState] == MPMusicPlaybackStatePlaying) {
        [musicPlayer pause];
        [self.btnPlay setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];
    } else {
        
        [musicPlayer play];
        [self.btnPlay setImage:[UIImage imageNamed:@"Play-icon.png"] forState:UIControlStateNormal];
    }

}

- (IBAction)btnPrevClick:(id)sender {
}

- (IBAction)btnNextClick:(id)sender {
}

#pragma mark -music player 
- (void) registerMediaPlayerNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    
    [notificationCenter addObserver: self
                           selector: @selector (handle_PlaybackStateChanged:)
                               name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
                             object: musicPlayer];
    
    
    
    [musicPlayer beginGeneratingPlaybackNotifications];
}

- (void) handle_PlaybackStateChanged: (id) notification
{
    MPMusicPlaybackState playbackState = [musicPlayer playbackState];
    
    //  NSLog(@"%d",[musicPlayer playbackState]);
    
    if (playbackState == MPMusicPlaybackStatePaused || playbackState==MPMusicPlaybackStateStopped) {
        [self.btnPlay setImage:[UIImage imageNamed:@"Pause-icon.png"] forState:UIControlStateNormal];
    } else if (playbackState == MPMusicPlaybackStatePlaying) {
        [self.btnPlay setImage:[UIImage imageNamed:@"Play-icon.png"] forState:UIControlStateNormal];
    }
}

@end
