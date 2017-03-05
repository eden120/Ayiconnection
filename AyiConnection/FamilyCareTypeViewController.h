//
//  FamilyCareTypeViewController.h
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyCareTypeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *topTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (nonatomic) CareType careType;

@end

@interface CareTypeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblCaretype;
@property (weak, nonatomic) IBOutlet UISwitch *swCaretype;

@end
