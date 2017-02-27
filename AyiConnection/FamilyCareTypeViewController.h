//
//  FamilyCareTypeViewController.h
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyCareTypeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *swNanny;
@property (weak, nonatomic) IBOutlet UISwitch *swMaternity;
@property (weak, nonatomic) IBOutlet UILabel *swSitter;
@property (weak, nonatomic) IBOutlet UILabel *swAtHome;

@property (weak, nonatomic) IBOutlet UIButton *btnNext;


@end
