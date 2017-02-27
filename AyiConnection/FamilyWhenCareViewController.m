//
//  FamilyWhenCareViewController.m
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "FamilyWhenCareViewController.h"
#import "FamilyRateViewController.h"

#define kROW_HEIGHT_IPHONE5     45
#define kROW_HEIGHT_IPHONE6     60

@interface FamilyWhenCareViewController ()

@end

@implementation FamilyWhenCareViewController
@synthesize btnNext;
@synthesize consRowHeight;
@synthesize btnMon;
@synthesize btnTue;
@synthesize btnWed;
@synthesize btnThu;
@synthesize btnFri;
@synthesize btnSat;
@synthesize btnSun;

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
    
    [self setupWeekDayButton:btnMon];
    [self setupWeekDayButton:btnTue];
    [self setupWeekDayButton:btnWed];
    [self setupWeekDayButton:btnThu];
    [self setupWeekDayButton:btnFri];
    [self setupWeekDayButton:btnSat];
    [self setupWeekDayButton:btnSun];
}

- (void)setupWeekDayButton:(UIButton *)button {
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 5;
    button.layer.borderColor = MAIN_COLOR.CGColor;
    button.layer.borderWidth = 1;
}

#pragma mark - Action
- (IBAction)onTapWeekBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setBackgroundColor:MAIN_COLOR];
    }
    else {
        [sender setBackgroundColor:[UIColor whiteColor]];
    }
}

- (IBAction)onTapStartDate:(id)sender {
}

- (IBAction)onTapEnddate:(id)sender {
}

- (IBAction)onTapStartTime:(id)sender {
}

- (IBAction)onTapEndTime:(id)sender {
}

- (IBAction)onChangeSwitch:(UISwitch *)sender {
}

- (IBAction)onTapNextBtn:(id)sender {
    FamilyRateViewController *familyRateVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FamilyRateViewController"];
    
    [self.navigationController pushViewController:familyRateVC animated:YES];
}

- (IBAction)onTapBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
