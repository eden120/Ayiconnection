//
//  FamilyTraitsViewController.h
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyTraitsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consTableHeight;
@property (weak, nonatomic) IBOutlet UISwitch *swAliquam;
@property (weak, nonatomic) IBOutlet UISwitch *swDonec;
@property (weak, nonatomic) IBOutlet UISwitch *swNam;
@property (weak, nonatomic) IBOutlet UISwitch *swVivamus;
@property (weak, nonatomic) IBOutlet UISwitch *swMaecenas;
@property (weak, nonatomic) IBOutlet UISwitch *swSuspend;
@property (weak, nonatomic) IBOutlet UISwitch *swNullam;
@property (weak, nonatomic) IBOutlet UISwitch *swDuis;
@property (weak, nonatomic) IBOutlet UIView *vTable;

@end

@interface TraitCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *lblNo;
@property (nonatomic, weak) IBOutlet UILabel *lblDes;

@end
