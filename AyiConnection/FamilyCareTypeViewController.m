//
//  FamilyCareTypeViewController.m
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "FamilyCareTypeViewController.h"
#import "FamilyPositionDetailViewController.h"

@interface FamilyCareTypeViewController ()

@end

@implementation FamilyCareTypeViewController
@synthesize btnNext;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self setupUI];
}

- (void)setupUI {
    btnNext.layer.borderColor = MAIN_COLOR.CGColor;
    btnNext.layer.borderWidth = 1.5;
    btnNext.clipsToBounds = YES;
    btnNext.layer.cornerRadius = 8;
}

#pragma mark - Action
- (IBAction)onChangedSwitch:(UISwitch *)sender {
}

- (IBAction)onTapNextBtn:(id)sender {
    FamilyPositionDetailViewController *familyPositionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FamilyPositionDetailViewController"];
    
    [self.navigationController pushViewController:familyPositionVC animated:YES];
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
