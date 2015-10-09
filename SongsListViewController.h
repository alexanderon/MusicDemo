//
//  SongsListViewController.h
//  Music
//
//  Created by RAHUL on 9/24/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MediaPlayer.h"
#import "CustomPopUpController.h"


@interface SongsListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


#pragma mark - IBOUTLETS - SONGSLISTVIEW

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *ContentView;
@property (weak,nonatomic)  IBOutlet UIView *DetailView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContentView;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;


#pragma mark - PROPERTIES - SONGSLISTVIEW

@property (nonatomic, strong) AVPlayer *musicPlayer;
@property (strong,nonatomic) NSMutableArray *fileArray;
@property (strong,nonatomic) NSMutableArray *completeArray;
@property (nonatomic, strong) NSString *selectedFilePath;
@property (atomic) NSNumber   *currentIndex;
@property (atomic) BOOL isIpodLibraryItem;
@property (strong,nonatomic) CustomPopUpController *vc;


#pragma mark - IBOUTLETS -DETAILVIEW

@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UIButton *btnPrev;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnRepeat;
@property (weak, nonatomic) IBOutlet UIButton *btnSuffle;
@property (weak, nonatomic) IBOutlet UISlider *sliderProgress;
@property (weak, nonatomic) IBOutlet UILabel *lblSongCurrentState;
@property (weak, nonatomic) IBOutlet UILabel *lblSongRemainigState;
@property (weak, nonatomic) IBOutlet UILabel *lblSongTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAlbumTitle;
@property (weak, nonatomic) IBOutlet UIView *mpVolumeViewParentView;
@property (weak, nonatomic) IBOutlet UIImageView *imgDetailVIew;

#pragma mark - IBACTION - DETAILVIEW

- (IBAction)btnPrevClick:(id)sender;
- (IBAction)btnNextClick:(id)sender;
- (IBAction)btnBackClick:(id)sender;
- (IBAction)btnRepeatClick:(id)sender;
- (IBAction)btnSuffleClick:(id)sender;
- (IBAction)sliderValueChange:(id)sender;
- (IBAction)sliderTouchedInside:(id)sender;
- (IBAction)sliderTouchedOutSide:(id)sender;
- (IBAction)btnNextHoldClick:(id)sender;




@end
