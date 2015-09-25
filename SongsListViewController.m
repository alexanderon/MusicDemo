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
    MPMusicPlayerController *musicPlayer;
  //  CustomPopUpController *popUp;
}
@property(strong,nonatomic) CustomPopUpController *popUp;

@end

@implementation SongsListViewController
@synthesize popUp;
- (void)viewDidLoad {
    [super viewDidLoad];

    popUp =[[CustomPopUpController alloc]init];
    musicPlayer =[MediaPlayer sharedManager].musicPlayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
    
    CustomPopUpController *vc = [[CustomPopUpController alloc]init];
    vc.view.frame = CGRectMake(0, 0, self.ContentView.frame.size.width, self.ContentView.frame.size.height);
    
    UITableViewCell *Cell =[tableView cellForRowAtIndexPath:indexPath];
    
    vc.lblTitle.text=Cell.textLabel.text;
    vc.lblSubtitle.text=Cell.detailTextLabel.text;
    
   
    
    MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
    NSArray *songs = [songsQuery items];
    int selectedIndex = [[self.tableView indexPathForSelectedRow] row];
    
    MPMediaItem *selectedItem = [[songs objectAtIndex:selectedIndex] representativeItem];
    
    
    [musicPlayer setQueueWithItemCollection:[MPMediaItemCollection collectionWithItems:[songsQuery items]]];
    [musicPlayer setNowPlayingItem:selectedItem];
    [musicPlayer play];
    [vc.btnPlay addTarget:self action:@selector(btnPlayClick:)  forControlEvents:UIControlEventTouchUpInside];
     [self.ContentView addSubview:vc.view];

}




- (IBAction)btnPlayClick:(id)sender {
    
    if([musicPlayer playbackState]== MPMusicPlaybackStatePlaying){
        [musicPlayer pause];
    }else
    {        
        [musicPlayer play];

    }
    
}

@end
