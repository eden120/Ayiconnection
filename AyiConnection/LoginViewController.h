//
//  LoginViewController.h
//  AyiConnection
//
//  Created by JCB on 2/21/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *signupTopSpace;

@end
