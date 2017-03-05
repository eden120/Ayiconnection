//
//  FamilyChildNumViewController.h
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyChildNumViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblChildNum;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@end

@interface FamilyChildCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblChildIndex;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@property (weak, nonatomic) IBOutlet UITextField *txtChildName;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segSex;

@end

@interface ChildObj : NSObject

@property (nonatomic) NSString *childName;
@property (nonatomic) NSString *childAge;
@property (nonatomic) BOOL isBoy;

@end
