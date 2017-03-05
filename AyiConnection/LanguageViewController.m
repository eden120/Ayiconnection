//
//  LanguageViewController.m
//  AyiConnection
//
//  Created by JCB on 2/20/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "LanguageViewController.h"
#import "FeaturesViewController.h"
#import "Constant.h"

@interface LanguageViewController ()

@end

@implementation LanguageViewController
@synthesize btnEn;
@synthesize btnCn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    btnEn.layer.borderColor = MAIN_COLOR.CGColor;
    btnEn.layer.borderWidth = 1.5;
    btnEn.clipsToBounds = YES;
    btnEn.layer.cornerRadius = 5;
    
    btnCn.layer.borderColor = MAIN_COLOR.CGColor;
    btnCn.layer.borderWidth = 1.5;
    btnCn.clipsToBounds = YES;
    btnCn.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)onTapLanguageBtn:(UIButton *)sender {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    switch (sender.tag) {
        case 1:
            NSLog(@"Selected Language %@", @"En");
            delegate.language = En;
            break;
        case 2:
            NSLog(@"Selected Language %@", @"Cn");
            delegate.language = Cn;
            break;
        default:
            break;
    }
    
    FeaturesViewController *featureVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FeaturesViewController"];
    
    [self.navigationController pushViewController:featureVC animated:YES];
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

