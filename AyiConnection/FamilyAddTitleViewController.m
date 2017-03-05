//
//  FamilyAddTitleViewController.m
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "FamilyAddTitleViewController.h"
#import "FamilyPreviewViewController.h"

@interface FamilyAddTitleViewController () <UITextFieldDelegate, UITextViewDelegate>

@end

@implementation FamilyAddTitleViewController
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

- (IBAction)onTapPreviewBtn:(id)sender {
    FamilyPreviewViewController *familyPreviewVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FamilyPreviewViewController"];
    
    [self.navigationController pushViewController:familyPreviewVC animated:YES];
}

- (IBAction)onTapPostBtn:(id)sender {
}

- (IBAction)onTapBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TexTFeild Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    
    return YES;
}

#pragma mark - TextView Delegate
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_txtTitle resignFirstResponder];
    [_txtComment resignFirstResponder];
    
    [self.view endEditing:YES];
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
