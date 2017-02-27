//
//  FamilyRateViewController.m
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "FamilyRateViewController.h"
#import "FamilyTraitsViewController.h"

#define kROW_HEIGHT_IPHONE5     50
#define kROW_HEIGHT_IPHONE6     60

@interface FamilyRateViewController ()

@end

@implementation FamilyRateViewController
@synthesize btnNext;
@synthesize consRowHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    btnNext.layer.borderColor = MAIN_COLOR.CGColor;
    btnNext.layer.borderWidth = 1.5;
    btnNext.clipsToBounds = YES;
    btnNext.layer.cornerRadius = 8;
    
    if (IS_IPHONE_5_OR_LESS) {
        consRowHeight.constant = kROW_HEIGHT_IPHONE5;
    }
    else {
        consRowHeight.constant = kROW_HEIGHT_IPHONE6;
    }
}

#pragma mark - Action

- (IBAction)onChangeSegment:(UISegmentedControl *)sender {
    
}

- (IBAction)onTapNextBtn:(id)sender {
    FamilyTraitsViewController *familyTraitVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FamilyTraitsViewController"];
    
    [self.navigationController pushViewController:familyTraitVC animated:YES];
}

- (IBAction)onTapBackbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
