//
//  LocationSetViewController.m
//  AyiConnection
//
//  Created by JCB on 2/20/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "LocationSetViewController.h"
#import "ZipSetViewController.h"
#import "UserTypeViewController.h"

@interface LocationSetViewController ()

@end

@implementation LocationSetViewController
@synthesize btnEnableLocation;
@synthesize btnNotYet;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    btnEnableLocation.clipsToBounds = YES;
    btnEnableLocation.layer.cornerRadius = 5;
    
    btnNotYet.layer.borderColor = MAIN_COLOR.CGColor;
    btnNotYet.layer.borderWidth = 1.5;
    btnNotYet.clipsToBounds = YES;
    btnNotYet.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)onTapBackbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onTapLocationSettingBtn:(UIButton *)sender {
    if (sender.tag == 1) {
        self.enableLocation = YES;
        
        ZipSetViewController *zipSetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ZipSetViewController"];
        
        [self.navigationController pushViewController:zipSetVC animated:YES];
    }
    else {
        self.enableLocation = NO;
     
        UserTypeViewController *userTypeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserTypeViewController"];
        
        [self.navigationController pushViewController:userTypeVC animated:YES];
    }
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
