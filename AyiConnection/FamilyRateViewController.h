//
//  FamilyRateViewController.h
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyRateViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UITextField *txtRate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segTime;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segRateNego;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segPayFre;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segPayWith;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end
