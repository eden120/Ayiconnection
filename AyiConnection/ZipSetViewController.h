//
//  ZipSetViewController.h
//  AyiConnection
//
//  Created by JCB on 2/20/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZipSetViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UITextField *txtZipCode;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnNextBottomSpace;

@end
