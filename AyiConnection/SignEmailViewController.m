//
//  SignEmailViewController.m
//  AyiConnection
//
//  Created by JCB on 2/21/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "SignEmailViewController.h"
#import "AddPhotoViewController.h"

@interface SignEmailViewController ()<UITextFieldDelegate>

@end

@implementation SignEmailViewController {
    UITextField *currentText;
}
@synthesize btnTerms;
@synthesize btnSignup;
@synthesize scrollView;
@synthesize txtFirstName;
@synthesize txtSecondName;
@synthesize txtPrefferedName;
@synthesize txtEmail;
@synthesize txtPassword;
@synthesize txtConPassword;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {
    [btnTerms setImage:[UIImage imageNamed:@"check_box.png"] forState:UIControlStateSelected];
    [btnTerms setImage:[UIImage imageNamed:@"uncheck_box.png"] forState:UIControlStateNormal];
    btnTerms.selected = NO;
    
    btnSignup.layer.borderWidth = 1.5;
    btnSignup.layer.borderColor = MAIN_COLOR.CGColor;
    btnSignup.clipsToBounds = YES;
    btnSignup.layer.cornerRadius = 8;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapped:)];
    [scrollView addGestureRecognizer:tapGes];

}

- (void)Tapped:(UITapGestureRecognizer*)gesture {
    [currentText resignFirstResponder];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Keyboard Hide/Show
- (void)keyboardWillShow:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, currentText.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, currentText.frame.origin.y-keyboardSize.height);
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
}

#pragma mark - TextFeild Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:txtFirstName]) {
        [txtSecondName becomeFirstResponder];
    }
    else if ([textField isEqual:txtSecondName]) {
        [txtPrefferedName becomeFirstResponder];
    }
    else if ([textField isEqual:txtPrefferedName]) {
        [txtEmail becomeFirstResponder];
    }
    else if ([textField isEqual:txtEmail]) {
        [txtPassword becomeFirstResponder];
    }
    else if ([textField isEqual:txtPassword]) {
        [txtConPassword becomeFirstResponder];
    }
    else if ([textField isEqual:txtConPassword]) {
        [txtConPassword resignFirstResponder];
        [self.view endEditing:YES];
        
        currentText = nil;
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentText = textField;
}

#pragma mark - Action

- (IBAction)onTapTermsBtn:(UIButton *)sender {
    
    [currentText resignFirstResponder];
    [self.view endEditing:YES];
    
    sender.selected = !sender.selected;
}

- (IBAction)onTapSignupBtn:(id)sender {
    
    [currentText resignFirstResponder];
    [self.view endEditing:YES];
    
    [self goProfileSetupPage];
    
    return;
    
    if (![self isValid]) {
        return;
    }
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    BasicBody *requestBody = [[BasicBody alloc] init];
    
    requestBody.grant_type = @"password";
    requestBody.client_id = CLIENT_ID;
    requestBody.client_secret = CLIENT_SECRET;
    requestBody.access_token = delegate.accessToken;
    requestBody.username = txtPrefferedName.text;
    requestBody.first_name = txtFirstName.text;
    requestBody.last_name = txtSecondName.text;
    requestBody.email = txtEmail.text;
    requestBody.password = txtPassword.text;
    requestBody.password_confirmation = txtConPassword.text;
    if (delegate.userType == Family) {
        requestBody.type = @"family";
    }
    else {
        requestBody.type = @"caregiver";
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self performRestPost:USER_SIGNUP withParamaters:@[requestBody]];
    
}

- (IBAction)onTapBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)isValid {
    if ([txtFirstName.text isEqualToString:@""]) {
        [self showErrorMsg:[NSString stringWithFormat:NSLocalizedString(@"_FIRST_NAME_MISS_", nil)]];
        
        return false;
    }
    if ([txtSecondName.text isEqualToString:@""]) {
        [self showErrorMsg:[NSString stringWithFormat:NSLocalizedString(@"_SECOND_NAME_MISS_", nil)]];
        
        return false;
    }
    if ([txtPrefferedName.text isEqualToString:@""]) {
        [self showErrorMsg:[NSString stringWithFormat:NSLocalizedString(@"_PREFFERED_NAME_MISS_", nil)]];
        
        return false;
    }
    if ([txtEmail.text isEqualToString:@""]) {
        [self showErrorMsg:[NSString stringWithFormat:NSLocalizedString(@"_EMAIL_MISS_", nil)]];
        
        return false;
    }
    if ([txtPassword.text isEqualToString:@""]) {
        [self showErrorMsg:[NSString stringWithFormat:NSLocalizedString(@"_PASSWORD_MISS_", nil)]];
        
        return false;
    }
    if ([txtConPassword.text isEqualToString:@""]) {
        [self showErrorMsg:[NSString stringWithFormat:NSLocalizedString(@"_CONFIRM_PASSWORD_MISS_", nil)]];
        
        return false;
    }
    if (![txtPassword.text isEqualToString:txtConPassword.text]) {
        [self showErrorMsg:[NSString stringWithFormat:NSLocalizedString(@"_PASSWORD_NOT_MATCH_", nil)]];
        
        txtConPassword.text = @"";
        return false;
    }
    
    return true;
}


- (void)showAuthoMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:NSLocalizedString(@"_AUTHO_WORK_MESSAGE_", nil)] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *allow = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_NO_I_NOT_", nil)] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddPhotoViewController *addPhotoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPhotoViewController"];
        
        [self.navigationController pushViewController:addPhotoVC animated:YES];
    }];
    
    UIAlertAction *notAllow = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_YES_I_AM_", nil)] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddPhotoViewController *addPhotoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPhotoViewController"];
        
        [self.navigationController pushViewController:addPhotoVC animated:YES];
    }];
    
    [alert addAction:allow];
    [alert addAction:notAllow];
    
    alert.view.tintColor = ALERT_COLOR;
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showErrorMsg:(NSString*)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_OK_", nil)] style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:ok];
    
    alert.view.tintColor = ALERT_COLOR;
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)goProfileSetupPage {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (delegate.userType == CareProvider) {
        [self showAuthoMessage];
        return;
    }
    
    UIStoryboard *profileSetupStory = [UIStoryboard storyboardWithName:@"ProfileSetup" bundle:nil];
    
    UINavigationController *familySetup = (UINavigationController*)[profileSetupStory instantiateViewControllerWithIdentifier:@"FamilyProfileSetupNavi"];
    
    delegate.window.rootViewController = familySetup;
}

- (void)actionAfterSuccessfulAnswerToRestConnection:(connectionType)connection WithResult:(NSArray *)mappingResult {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    switch (connection) {
        case ERROR:
        {
            [self showErrorMsg:[NSString stringWithFormat:NSLocalizedString(@"_SIGNUP_ERROR_", nil)]];
            break;
        }
        case USER_SIGNUP:
        {
            for (LoginData *signup in mappingResult) {
                if ([signup isKindOfClass:[LoginData class]]) {
                    
                    delegate.accessToken = signup.access_token;
                    NSLog(@"User Id : %d", [signup.user_id integerValue]);

                    
                    [self getUserInfo:signup.access_token];
                }
            }
            break;
        }
        case GET_USER_PROFILE:
        {
            for (User *user in mappingResult) {
                if ([user isKindOfClass:[User class]]) {
                    NSLog(@"User Name : %@", user.username);
                    delegate.currentUser = user;
                    //[self goProfileSetup:user];
                    [self goProfileSetupPage];
                }
            }
            
            break;
        }
        default:
            break;
    }
}

- (void)getUserInfo:(NSString*)accessToken {
    BasicBody *requestBody = [[BasicBody alloc] init];
    
    requestBody.access_token = accessToken;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self performRestPost:GET_USER_PROFILE withParamaters:@[requestBody]];
}

- (void)goProfileSetup:(User*)user {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UIStoryboard *profileSetupStory = [UIStoryboard storyboardWithName:@"ProfileSetup" bundle:nil];
    
    if (user.usertype == 0) {
        
        UINavigationController *familyProfileSetupNavi = [profileSetupStory instantiateViewControllerWithIdentifier:@"FamilyProfileSetupNavi"];
        
        delegate.window.rootViewController = familyProfileSetupNavi;
    }
    else {
        UINavigationController *providerProfileSetupNavi = [profileSetupStory instantiateViewControllerWithIdentifier:@"ProviderProfileSetupNavi"];
        
        delegate.window.rootViewController = providerProfileSetupNavi;
    }
}

@end
