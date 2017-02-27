//
//  FamilyPositionDetailViewController.h
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyPositionDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segTime;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segLive;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segEngLevel;
@property (weak, nonatomic) IBOutlet UISwitch *swPets;
@property (weak, nonatomic) IBOutlet UISwitch *swTransport;
@property (weak, nonatomic) IBOutlet UISwitch *swDriver;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consRowHeight;

@end
