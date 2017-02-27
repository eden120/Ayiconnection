//
//  JobShortViewController.h
//  AyiConnection
//
//  Created by JCB on 2/21/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobShortViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnSignup;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *vBottom;

@end

@interface JobShortDefaultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *txtTitle;

@end
