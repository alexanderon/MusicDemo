//
//  SongsViewController.m
//  Music
//
//  Created by RAHUL on 9/22/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "SongsViewController.h"

@interface SongsViewController ()

@end

@implementation SongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MPMediaQuery* songsQuery =[MPMediaQuery songsQuery];
    NSArray* songs=[songsQuery items];
    
   
    return [songs count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
 NSArray *songs = [songsQuery items];
 int selectedIndex = (int)[[self.tableView indexPathForSelectedRow] row];
 
 MPMediaItem *selectedItem = [[songs objectAtIndex:selectedIndex] representativeItem];
 MPMusicPlayerController *musicPlayer = [MPMusicPlayerController systemMusicPlayer];
 
 [musicPlayer setQueueWithItemCollection:[MPMediaItemCollection collectionWithItems:[songsQuery items]]];
 [musicPlayer setNowPlayingItem:selectedItem];
 
 [musicPlayer play];
 }
 


@end
