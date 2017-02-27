//
//  AddPhotoViewController.m
//  AyiConnection
//
//  Created by JCB on 2/21/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "AddPhotoViewController.h"


#define kAddTopSpace_IPHONE5    10
#define kAddTopSpace_IPHONE6    70

@interface AddPhotoViewController ()

@end

@implementation AddPhotoViewController
@synthesize btnAddPhoto;
@synthesize addPhotoTopSpace;

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
    btnAddPhoto.layer.borderColor = MAIN_COLOR.CGColor;
    btnAddPhoto.layer.borderWidth = 1.5;
    btnAddPhoto.clipsToBounds = YES;
    btnAddPhoto.layer.cornerRadius = 8;
    
    if (IS_IPHONE_5_OR_LESS) {
        addPhotoTopSpace.constant = kAddTopSpace_IPHONE5;
    }
    else {
        addPhotoTopSpace.constant = kAddTopSpace_IPHONE6;
    }
}


#pragma mark - Action

- (IBAction)onTapAddPhotoBtn:(id)sender {
    
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
