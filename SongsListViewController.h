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
@property (weak, nonatomic) IBOutlet UIButton *btnDisplay;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContentView;
@property (weak,nonatomic)  IBOutlet UIView *DetailView;
- (IBAction)btnBackClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
-(IBAction)btnDetailShow:(id)sender;

//method actions
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UIButton *btnPrev;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;


- (IBAction)btnPlayClick:(id)sender;
- (IBAction)btnPrevClick:(id)sender;
- (IBAction)btnNextClick:(id)sender;

@end
