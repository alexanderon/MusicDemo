//
//  CustomPopUpController.h
//  Music
//
//  Created by RAHUL on 9/24/15.
//  Copyright (c) 2015 RAHUL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer.h"

@interface CustomPopUpController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UIButton *btnTrans;

@property (atomic) int rowIndex;
@property(weak,nonatomic)AVPlayer *musicPlayer;
@property   (strong,nonatomic)NSMutableArray *completeArray;


- (IBAction)btnPlayClick:(id)sender;



@end
