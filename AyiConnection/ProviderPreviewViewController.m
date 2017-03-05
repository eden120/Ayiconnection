//
//  ProviderPreviewViewController.m
//  AyiConnection
//
//  Created by JCB on 2/25/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "ProviderPreviewViewController.h"

@interface ProviderPreviewViewController ()

@end

@implementation ProviderPreviewViewController
@synthesize btnPost;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {
    
    btnPost.clipsToBounds = YES;
    btnPost.layer.cornerRadius = 8;
    
    _imgProfile.clipsToBounds = YES;
    _imgProfile.layer.cornerRadius = _imgProfile.frame.size.height / 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)onTapPostBtn:(id)sender {
    
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
