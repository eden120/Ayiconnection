//
//  CareProviderShortViewController.h
//  AyiConnection
//
//  Created by JCB on 2/21/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CareProviderShortViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnSignup;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *vBottom;

@end

@interface CareProviderShortDefaultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *txtName;

@end
