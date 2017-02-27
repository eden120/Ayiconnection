//
//  UserTypeViewController.m
//  AyiConnection
//
//  Created by JCB on 2/20/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "UserTypeViewController.h"
#import "CareProviderShortViewController.h"

@interface UserTypeViewController ()

@end

@implementation UserTypeViewController
@synthesize vSeekCare;
@synthesize vLookJob;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    vSeekCare.clipsToBounds = YES;
    vSeekCare.layer.cornerRadius = 10;
    
    vLookJob.clipsToBounds = YES;
    vLookJob.layer.cornerRadius = 10;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)onTapUserTypeBtn:(UIButton*)sender {
    
    UIStoryboard *loginStory = [UIStoryboard storyboardWithName:@"LoginSignup" bundle:nil];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    UINavigationController *parentLoginNavi = (UINavigationController*)[loginStory instantiateViewControllerWithIdentifier:@"FamilyLoginNavi"];
    
    UINavigationController *providerLoginNavi = (UINavigationController*)[loginStory instantiateViewControllerWithIdentifier:@"ProviderLoginNavi"];
    
    switch (sender.tag) {
        case 1:
            NSLog(@"User Type : %@", @"Seek Care");
            self.userType = Family;
            appDelegate.window.rootViewController = parentLoginNavi;
            break;
        case 2:
            NSLog(@"User Type : %@", @"Look Job");
            self.userType = CareProvider;
            appDelegate.window.rootViewController = providerLoginNavi;
            break;
        default:
            break;
    }
    
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
