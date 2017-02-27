//
//  FamilyPositionDetailViewController.m
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "FamilyPositionDetailViewController.h"
#import "FamilyResponsibilityViewController.h"

#define kROW_HEIGHT_IPHONE5    45
#define kROW_HEIGHT_IPHONE6    55


@interface FamilyPositionDetailViewController ()

@end

@implementation FamilyPositionDetailViewController
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

- (IBAction)onChangeSwitch:(UISwitch *)sender {
}

- (IBAction)onTapNextBtn:(id)sender {
    FamilyResponsibilityViewController *familyReponsibilityVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FamilyResponsibilityViewController"];
    
    [self.navigationController pushViewController:familyReponsibilityVC animated:YES];
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
