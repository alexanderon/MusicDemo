//
//  AlbumViewController.m
//  Music
//
//  Created by RAHUL on 9/22/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import "AlbumViewController.h"

@interface AlbumViewController ()
@end

@implementation AlbumViewController
@synthesize albumTitle;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=albumTitle;
}

- (UIImage *) getAlbumArtworkWithSize: (CGSize) albumSize
{
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue: albumTitle forProperty: MPMediaItemPropertyAlbumTitle];
    [albumQuery addFilterPredicate:albumPredicate];
    NSArray *albumTracks = [albumQuery items];
    
    for (int i = 0; i < [albumTracks count]; i++) {
        
        MPMediaItem *mediaItem = [albumTracks objectAtIndex:i];
        UIImage *artworkImage;
        
        MPMediaItemArtwork *artwork = [mediaItem valueForProperty: MPMediaItemPropertyArtwork];
        artworkImage = [artwork imageWithSize: CGSizeMake (1, 1)];
        
        if (artworkImage) {
            artworkImage = [artwork imageWithSize:albumSize];
            return artworkImage;
        }
        
    }
    
    return [UIImage imageNamed:@"No-artwork-album.png"];
}
#pragma mark -get the artists of album
- (NSString *) getAlbumArtist
{
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue: albumTitle forProperty: MPMediaItemPropertyAlbumTitle];
    [albumQuery addFilterPredicate:albumPredicate];
    NSArray *albumTracks = [albumQuery items];
    
    for (int i = 0 ; i < [albumTracks count]; i++) {
        
        NSString *albumArtist = [[[albumTracks objectAtIndex:0] representativeItem] valueForProperty:MPMediaItemPropertyAlbumArtist];
        
        if (albumArtist) {
            return albumArtist;
        }
    }
    
    return @"Unknown artist";
}

- (NSString *) getAlbumInfo
{
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue: albumTitle forProperty: MPMediaItemPropertyAlbumTitle];
    [albumQuery addFilterPredicate:albumPredicate];
    NSArray *albumTracks = [albumQuery items];
    
    
    NSString *trackCount;
    
    if ([albumTracks count] > 1) {
        trackCount = [NSString stringWithFormat:@"%i Songs", (int)[albumTracks count]];
    } else {
        trackCount = [NSString stringWithFormat:@"1 Song"];
    }
    
    long playbackDuration = 0;
    
    for (MPMediaItem *track in albumTracks)
    {
        playbackDuration += [[track  valueForProperty:MPMediaItemPropertyPlaybackDuration] longValue];
    }
    
    int albumMimutes = (int)(playbackDuration/60.0);
    NSString *albumDuration;
    
    if (albumMimutes > 1) {
        albumDuration = [NSString stringWithFormat:@"%i Mins.", albumMimutes];
    } else {
        albumDuration = [NSString stringWithFormat:@"1 Min."];
    }
    
    return [NSString stringWithFormat:@"%@, %@", trackCount, albumDuration];
    
}

- (BOOL) sameArtists
{
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue: albumTitle forProperty: MPMediaItemPropertyAlbumTitle];
    [albumQuery addFilterPredicate:albumPredicate];
    NSArray *albumTracks = [albumQuery items];
    
    for (int i = 0 ; i < [albumTracks count]; i++) {
        
        if ([[[[albumTracks objectAtIndex:0] representativeItem] valueForProperty:MPMediaItemPropertyArtist] isEqualToString:[[[albumTracks objectAtIndex:i] representativeItem] valueForProperty:MPMediaItemPropertyArtist]]) {
        } else {
            return NO;
        }
    }
    
    return YES;
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
    MPMediaQuery *albumQuery =[MPMediaQuery albumsQuery];
    
    MPMediaPropertyPredicate *albumPredicate=[MPMediaPropertyPredicate  predicateWithValue:albumTitle forProperty:MPMediaItemPropertyAlbumTitle];
    [albumQuery addFilterPredicate:albumPredicate];
    
    NSArray* albumTracks=[albumQuery items];
    return [albumTracks count]+1;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        return 120;
    } else {
        return 44;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == 0) {
        static NSString *CellIdentifier = @"InfoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        UIImageView *albumArtworkImageView = (UIImageView *)[cell viewWithTag:100];
        albumArtworkImageView.image = [self getAlbumArtworkWithSize:albumArtworkImageView.frame.size];
        
        UILabel *albumArtistLabel = (UILabel *)[cell viewWithTag:101];
        albumArtistLabel.text = [self getAlbumArtist];
        
        UILabel *albumInfoLabel = (UILabel *)[cell viewWithTag:102];
        albumInfoLabel.text = [self getAlbumInfo];
        
        return cell;
    } else {
        
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        
        MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
        MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue: albumTitle forProperty: MPMediaItemPropertyAlbumTitle];
        [albumQuery addFilterPredicate:albumPredicate];
        NSArray *albumTracks = [albumQuery items];
        
        NSUInteger trackNumber = [[[albumTracks objectAtIndex:(indexPath.row-1)]  valueForProperty:MPMediaItemPropertyAlbumTrackNumber] unsignedIntegerValue];
        
        if (trackNumber) {
            cell.textLabel.text = [NSString stringWithFormat:@"%i. %@", trackNumber, [[[albumTracks objectAtIndex:(indexPath.row-1)] representativeItem] valueForProperty:MPMediaItemPropertyTitle]];
        } else {
            cell.textLabel.text = [[[albumTracks objectAtIndex:(indexPath.row-1)] representativeItem] valueForProperty:MPMediaItemPropertyTitle];
        }
        
        
        if ([self sameArtists]) {
            
            cell.detailTextLabel.text = @"";
            
        } else {
            
            if ([[[albumTracks objectAtIndex:(indexPath.row-1)] representativeItem] valueForProperty:MPMediaItemPropertyArtist]) {
                cell.detailTextLabel.text = [[[albumTracks objectAtIndex:(indexPath.row-1)] representativeItem] valueForProperty:MPMediaItemPropertyArtist];
            } else {
                cell.detailTextLabel.text = @"";
            }
            
        }
        
        return cell;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MPMediaQuery *albumQuery = [MPMediaQuery albumsQuery];
    MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue: albumTitle forProperty: MPMediaItemPropertyAlbumTitle];
    [albumQuery addFilterPredicate:albumPredicate];
    NSArray *albumTracks = [albumQuery items];
    
    int selectedIndex = [[self.tableView indexPathForSelectedRow] row];
    
    MPMediaItem *selectedItem = [[albumTracks objectAtIndex:selectedIndex-1] representativeItem];
    
    MPMusicPlayerController *musicPlayer = [MPMusicPlayerController systemMusicPlayer];
    
    [musicPlayer setQueueWithItemCollection:[MPMediaItemCollection collectionWithItems:[albumQuery items]]];
    [musicPlayer setNowPlayingItem:selectedItem];
    
    [musicPlayer play];
}

@end
