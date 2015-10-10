//
//  CustomPopUpController.h
//  Music
//
//  Created by RAHUL on 9/24/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer.h"
#import "MDAudioFile.h"
#import <AVFoundation/AVFoundation.h>

@interface CustomPopUpController : UIViewController{
   NSTimer *timer;
}


#pragma mark - PROPERTIES - GENERAL

@property(weak,nonatomic)AVPlayer *musicPlayer;
@property (strong,nonatomic) NSMutableArray *fileArray;
@property (strong,nonatomic)NSMutableArray *completeArray;
@property (strong,nonatomic) NSString *selectedFilePath;
@property (atomic) NSNumber *currentIndex;
@property (atomic) BOOL isIpodLibraryItem;
@property (atomic) int rowIndex;
@property (atomic) NSTimer *timer;

#pragma mark - METHODS - GENERAL
-(void)updateDisplay;


#pragma mark - OUTLETS - CUSTOMVIEW

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UIButton *btnTrans;
@property (weak, nonatomic) IBOutlet UIView *detailView;



#pragma mark - ACTIONS - CUSTOM VIEW 

- (IBAction)btnPlayClick:(id)sender;


#pragma mark - IBOUTLETS -DETAILVIEW

@property (weak, nonatomic) IBOutlet UIButton *btnPlay2;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
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
//- (IBAction)sliderTouchedOutSide:(id)sender;
//- (IBAction)btnNextHoldClick:(id)sender;






@end
