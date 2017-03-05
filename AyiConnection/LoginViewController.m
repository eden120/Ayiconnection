//
//  LoginViewController.m
//  AyiConnection
//
//  Created by JCB on 2/21/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpViewController.h"
#import <FBSDKLoginKit.h>
#import <FBSDKCoreKit.h>
#import <LinkedInHelper.h>


#define kLoginTopSpace_IPHONE5  10
#define kLoginTopSpace_IPHONE6  30
#define kSignupTopSpace_IPHONE5 8
#define kSignupTopSpace_IPHONE6 30

@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController
@synthesize txtEmail;
@synthesize txtPassword;
@synthesize btnLogin;
@synthesize loginTopSpace;
@synthesize signupTopSpace;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupUI {
    btnLogin.layer.borderColor = MAIN_COLOR.CGColor;
    btnLogin.layer.borderWidth = 1.5;
    
    btnLogin.clipsToBounds = YES;
    btnLogin.layer.cornerRadius = 8;
    
    txtEmail.delegate = self;
    txtPassword.delegate = self;
    
    if (IS_IPHONE_5_OR_LESS) {
        loginTopSpace.constant = kLoginTopSpace_IPHONE5;
        signupTopSpace.constant = kSignupTopSpace_IPHONE5;
    }
    else {
        loginTopSpace.constant = kLoginTopSpace_IPHONE6;
        signupTopSpace.constant = kSignupTopSpace_IPHONE6;
    }
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
         frame.origin.y = -keyboardSize.height + 120;
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

#pragma mark - TextFeild Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:txtEmail]) {
        [txtPassword becomeFirstResponder];
    }
    else {
        [txtPassword resignFirstResponder];
        [self.view endEditing:YES];
    }
    
    return YES;
}

#pragma mark - Action
- (IBAction)onTapSocialBtn:(UIButton*)sender {
    switch (sender.tag) {
        case 1:
            NSLog(@"Signup via Facebook");
            [self FBLogin];
            break;
        case 2:
            NSLog(@"Signup via Linkedin");
            [self LinkedinLogin];
            break;
        case 3:
            NSLog(@"Signup via Wechat");
            break;
        default:
            break;
    }
}

- (void)FBLogin {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Process Error");
        }
        else if (result.isCancelled) {
            NSLog(@"Login Cancel");
        }
        else {
            NSLog(@"Login OK : %@", result.token.tokenString);
            BasicBody *requestBody = [[BasicBody alloc] init];
            requestBody.grant_type = @"social";
            requestBody.client_id = CLIENT_ID;
            requestBody.client_secret = CLIENT_SECRET;
            requestBody.provider = @"facebook";
            requestBody.social_token = result.token.tokenString;
            
            if (delegate.userType == Family) {
                requestBody.type = @"family";
            }
            else {
                requestBody.type = @"caregiver";
            }
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self performRestPost:USER_LOGIN withParamaters:@[requestBody]];
        }
    }];
}

- (void)LinkedinLogin {
    LinkedInHelper *linkedin = [LinkedInHelper sharedInstance];
    
    NSArray *permissions = @[@(BasicProfile),
                             @(EmailAddress),
                             @(Share),
                             @(CompanyAdmin)];
    
    linkedin.showActivityIndicator = YES;
    
    [linkedin requestMeWithSenderViewController:self
                                       clientId:@"784ws95s91kfuk"         // Your App Client Id
                                   clientSecret:@"Z934xBlNmt946Jl8"         // Your App Client Secret
                                    redirectUrl:@"http://jcb120.com/"         // Your App Redirect Url
                                    permissions:permissions
                                          state:@""               // Your client state
                                successUserInfo:^(NSDictionary *userInfo) {
                                    // Whole User Info
                                    NSLog(@"user Info : %@", userInfo);
                                    
                                }
                              failUserInfoBlock:^(NSError *error) {
                                  NSLog(@"error : %@", error.userInfo.description);
                              }
     ];
}


- (IBAction)onTapLoginBtn:(id)sender {
    if ([txtEmail.text isEqualToString:@""]) {
        [self showErrorMsg:[NSString stringWithFormat:NSLocalizedString(@"_EMAIL_MISS_", nil)]];
        return;
    }
    if ([txtPassword.text isEqualToString:@""]) {
        [self showErrorMsg:[NSString stringWithFormat:NSLocalizedString(@"_PASSWORD_MISS_", nil)]];
        return;
    }
    
    BasicBody *requestBody = [[BasicBody alloc] init];
    requestBody.grant_type = @"password";
    requestBody.client_id = CLIENT_ID;
    requestBody.client_secret = CLIENT_SECRET;
    requestBody.username = txtEmail.text;
    requestBody.password = txtPassword.text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self performRestPost:USER_LOGIN withParamaters:@[requestBody]];
}

- (IBAction)onTapSignupBtn:(id)sender {
    SignUpViewController *signupVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    
    [self.navigationController pushViewController:signupVC animated:YES];
}

- (IBAction)onTapBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)showErrorMsg:(NSString*)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_OK_", nil)] style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:ok];
    
    alert.view.tintColor = ALERT_COLOR;
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)actionAfterSuccessfulAnswerToRestConnection:(connectionType)connection WithResult:(NSArray *)mappingResult {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    switch (connection) {
        case ERROR:
        {
            [self showErrorMsg:[NSString stringWithFormat:NSLocalizedString(@"_LOGIN_ERROR_", nil)]];
            break;
        }
        case USER_LOGIN:
        {
            for (LoginData *login in mappingResult) {
                if ([login isKindOfClass:[LoginData class]]) {
                    delegate.accessToken = login.access_token;
                    NSLog(@"Login Success Token : %@", login.access_token);
                    
                    [self getUserInfo:login.access_token];
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
                    if (user.profile_completed == 0) {
                        [self goProfileSetup:user];
                    }
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
