//
//  SongsViewController.h
//  Music
//
//  Created by RAHUL on 9/22/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface SongsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
