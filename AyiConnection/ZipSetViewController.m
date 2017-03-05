//
//  ZipSetViewController.m
//  AyiConnection
//
//  Created by JCB on 2/20/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "ZipSetViewController.h"
#import "UserTypeViewController.h"

#define kBOTTOM_SPACE_IPHONE5       30
#define kBOTTOM_SPACE_IPHONE6       110

@interface ZipSetViewController () <UITextFieldDelegate>

@end

@implementation ZipSetViewController {
    CGFloat bottomSpace;
}
@synthesize txtZipCode;
@synthesize btnNext;
@synthesize btnNextBottomSpace;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    txtZipCode.delegate = self;
    
    btnNext.layer.borderWidth = 1.5;
    btnNext.layer.borderColor = MAIN_COLOR.CGColor;
    btnNext.clipsToBounds = YES;
    btnNext.layer.cornerRadius = 5;
    
    if (IS_IPHONE_5_OR_LESS) {
        btnNextBottomSpace.constant = kBOTTOM_SPACE_IPHONE5;
    }
    else {
        btnNextBottomSpace.constant = kBOTTOM_SPACE_IPHONE6;
    }
    
    bottomSpace = btnNextBottomSpace.constant;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self showNotificationMessage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Keyboard Hide/Show
- (void)keyboardWillShow:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.25 animations:^
     {
         CGRect frame = self.view.frame;
         frame.origin.y = -keyboardSize.height + btnNextBottomSpace.constant;
         self.view.frame = frame;
         
     }completion:^(BOOL finished)
     {
         
     }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.25 animations:^
     {
         CGRect frame = self.view.frame;
         frame.origin.y = 0;
         self.view.frame = frame;
         
     }completion:^(BOOL finished)
     {
         
     }];
    
}

#pragma mark - Action

- (IBAction)onTapNext:(id)sender {
    if ([txtZipCode.text isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:NSLocalizedString(@"_ZIP_IS_EMPTY_", nil)] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_OK_", nil)] style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:ok];
        
        alert.view.tintColor = ALERT_COLOR;
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    delegate.zipCode = txtZipCode.text;
    
    UserTypeViewController *userTypeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserTypeViewController"];
    
    [self.navigationController pushViewController:userTypeVC animated:YES];
}

- (IBAction)onTapBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showNotificationMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_ALLOW_NOTIFICATION_", nil)] message:[NSString stringWithFormat:NSLocalizedString(@"_ALLOW_NOTIFICATION_MESSAGE_", nil)] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *allow = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_ALLOW_", nil)] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *notAllow = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_DONOT_ALLOW_", nil)] style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:allow];
    [alert addAction:notAllow];
  
    alert.view.tintColor = ALERT_COLOR;
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - TextFeild Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [txtZipCode resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
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
