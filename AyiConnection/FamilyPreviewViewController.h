//
//  FamilyPreviewViewController.h
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyPreviewViewController : UIViewController

@property (nonatomic) NSString *jobTitle;
@property (nonatomic) NSString *comment;
@property (nonatomic) NSString *rate;

@property (weak, nonatomic) IBOutlet UIButton *btnPost;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;
@property (weak, nonatomic) IBOutlet UILabel *lblRate;
@property (weak, nonatomic) IBOutlet UILabel *lblLanguage;
@property (weak, nonatomic) IBOutlet UILabel *lblLive;
@property (weak, nonatomic) IBOutlet UILabel *lblAvailableTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgInfant;
@property (weak, nonatomic) IBOutlet UILabel *lblInfant;
@property (weak, nonatomic) IBOutlet UIImageView *imgYoungBaby;
@property (weak, nonatomic) IBOutlet UILabel *lblYoungBaby;
@property (weak, nonatomic) IBOutlet UIImageView *imgToddler;
@property (weak, nonatomic) IBOutlet UILabel *lblToddler;
@property (weak, nonatomic) IBOutlet UIImageView *imgPreschooler;
@property (weak, nonatomic) IBOutlet UILabel *lblPreschooler;
@property (weak, nonatomic) IBOutlet UIImageView *imgGradschooler;
@property (weak, nonatomic) IBOutlet UILabel *lblGradschooler;
@property (weak, nonatomic) IBOutlet UIImageView *imgsimplehouse;
@property (weak, nonatomic) IBOutlet UILabel *lblSimplehouse;
@property (weak, nonatomic) IBOutlet UIImageView *imgLaundry;
@property (weak, nonatomic) IBOutlet UILabel *lblLaundry;

@property (weak, nonatomic) IBOutlet UIImageView *imgpremeal;
@property (weak, nonatomic) IBOutlet UILabel *lblPremeal;
@property (weak, nonatomic) IBOutlet UIImageView *imgCookmeal;
@property (weak, nonatomic) IBOutlet UILabel *lblCookmeal;
@property (weak, nonatomic) IBOutlet UIImageView *imgRunerrand;
@property (weak, nonatomic) IBOutlet UILabel *iblRunerrand;

@property (weak, nonatomic) IBOutlet UIButton *btnMon;
@property (weak, nonatomic) IBOutlet UIButton *btnTue;
@property (weak, nonatomic) IBOutlet UIButton *btnWed;
@property (weak, nonatomic) IBOutlet UIButton *btnThu;
@property (weak, nonatomic) IBOutlet UIButton *btnFri;
@property (weak, nonatomic) IBOutlet UIButton *btnSat;
@property (weak, nonatomic) IBOutlet UIButton *btnSun;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEnddate;
@property (weak, nonatomic) IBOutlet UIImageView *imgCash;
@property (weak, nonatomic) IBOutlet UILabel *lblCash;
@property (weak, nonatomic) IBOutlet UIImageView *imgCheck;
@property (weak, nonatomic) IBOutlet UILabel *lblCheck;
@property (weak, nonatomic) IBOutlet UIImageView *imgCard;
@property (weak, nonatomic) IBOutlet UILabel *lblCard;

@end
