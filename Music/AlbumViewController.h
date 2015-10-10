//
//  AlbumViewController.h
//  Music
//
//  Created by RAHUL on 9/22/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AlbumViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    NSString *albumTitle;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSString *albumTitle;
@end
