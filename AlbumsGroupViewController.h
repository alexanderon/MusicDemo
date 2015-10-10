//
//  AlbumsGroupViewController.h
//  Music
//
//  Created by RAHUL on 10/9/15.
//  Copyright © 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AlbumViewController.h"

@interface AlbumsGroupViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

#pragma mark - OUTLETS - ALBUMS GROUP   

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end
