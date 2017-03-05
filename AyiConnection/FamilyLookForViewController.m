//
//  FamilyLookForViewController.m
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "FamilyLookForViewController.h"
#import "FamilyCareTypeViewController.h"

@interface FamilyLookForViewController ()

@end

@implementation FamilyLookForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _vChildCare.layer.borderColor = CARE_TYPE_BORDER_COLOR.CGColor;
    _vChildCare.layer.borderWidth = 1;
    _vSeniorCare.layer.borderColor = CARE_TYPE_BORDER_COLOR.CGColor;
    _vSeniorCare.layer.borderWidth = 1;
    _vHomeCare.layer.borderColor = CARE_TYPE_BORDER_COLOR.CGColor;
    _vHomeCare.layer.borderWidth = 1;
    _vTotur.layer.borderColor = CARE_TYPE_BORDER_COLOR.CGColor;
    _vTotur.layer.borderWidth = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)onTapCareTypeBtn:(UIButton*)sender {
    
    FamilyCareTypeViewController *familyCareTypeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FamilyCareTypeViewController"];
    
    switch (sender.tag) {
        case 1:
        {
            familyCareTypeVC.careType = ChildCare;
            break;
        }
        case 2:
        {
            familyCareTypeVC.careType = SeniorCare;
            break;
        }
        case 3:
        {
            familyCareTypeVC.careType = HomeCare;
            break;
        }
        case 4:
        {
            familyCareTypeVC.careType = Tutor;
            break;
        }
        default:
            break;
    }
    
    [self.navigationController pushViewController:familyCareTypeVC animated:YES];
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
