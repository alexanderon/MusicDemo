//
//  AlbumsGroupViewController.m
//  Music
//
//  Created by RAHUL on 10/9/15.
//  Copyright © 2015 RAHUL. All rights reserved.
//

#import "AlbumsGroupViewController.h"
#import "SongsListViewController.h"

@interface AlbumsGroupViewController ()

@end

@implementation AlbumsGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    NSArray* albums=[albumQuery collections];
    return [albums count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* CellIdentifier =@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier     forIndexPath:indexPath];
    
    // Configure the cell...
    MPMediaQuery *albumsQuery = [MPMediaQuery albumsQuery];
    NSArray *albums = [albumsQuery collections];
    
    MPMediaItem *rowItem = [[albums objectAtIndex:indexPath.row] representativeItem];
    cell.textLabel.text=[rowItem valueForProperty:MPMediaItemPropertyAlbumTitle];
    cell.detailTextLabel.text=[rowItem valueForProperty:MPMediaItemPropertyAlbumArtist ];
    
    /* MPMediaItemArtwork* artWork=[artWork imageWithSize:CGSizeMake(44, 44)];
     if(artWork){
     cell.imageView.image =artWork;
     }else{
     cell.imageView.image=[UIImage imageNamed:@"No-artwork-albums.png"];
     }*/
    
    return cell;
}




#pragma mark - Table view dalegate

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   /* [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    SongsListViewController *audioPlayer =[self.storyboard instantiateViewControllerWithIdentifier:@"SongsListViewController"];
    [self presentViewController:audioPlayer animated:YES completion:nil];*/
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
      
    AlbumViewController *detailViewController = [segue destinationViewController];
    
    MPMediaQuery *albumsQuery = [MPMediaQuery albumsQuery];
    NSArray *albums = [albumsQuery collections];
    
    int selectedIndex = [[self.tableView indexPathForSelectedRow] row];
    MPMediaItem *selectedItem = [[albums objectAtIndex:selectedIndex] representativeItem];
    NSString *albumTitle = [selectedItem valueForProperty:MPMediaItemPropertyAlbumTitle];
    
    [detailViewController setAlbumTitle:albumTitle];

    
    
}


@end
