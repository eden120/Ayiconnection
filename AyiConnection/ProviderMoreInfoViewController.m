//
//  ProviderMoreInfoViewController.m
//  AyiConnection
//
//  Created by JCB on 2/25/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "ProviderMoreInfoViewController.h"

@interface ProviderMoreInfoViewController ()

@end

@implementation ProviderMoreInfoViewController
@synthesize btnPost;
@synthesize btnPreview;

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
    btnPreview.layer.borderColor = MAIN_COLOR.CGColor;
    btnPreview.layer.borderWidth = 1.5;
    btnPreview.clipsToBounds = YES;
    btnPreview.layer.cornerRadius = 8;
    
    btnPost.clipsToBounds = YES;
    btnPost.layer.cornerRadius = 8;
}

#pragma mark - Action
- (IBAction)onTapBackBtn:(id)sender {
    
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
