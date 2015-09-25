//
//  SongsListViewController.h
//  Music
//
//  Created by RAHUL on 9/24/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer.h"

@interface SongsListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *ContentView;


@end
