//
//  LocationSetViewController.h
//  AyiConnection
//
//  Created by JCB on 2/20/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationSetViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *btnEnableLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnNotYet;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consBottomSpace;

@end
