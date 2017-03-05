//
//  AboutProviderViewController.h
//  AyiConnection
//
//  Created by JCB on 2/25/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutProviderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UITextField *txtPrefferedName;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segSex;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@end
