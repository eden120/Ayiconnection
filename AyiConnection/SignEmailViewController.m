//
//  SignEmailViewController.m
//  AyiConnection
//
//  Created by JCB on 2/21/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "SignEmailViewController.h"
#import "AddPhotoViewController.h"

#define kSpace_IPHONE5  8
#define kSpace_IPHONE6  58

@interface SignEmailViewController ()

@end

@implementation SignEmailViewController
@synthesize btnTerms;
@synthesize btnSignup;
@synthesize signupTopSpace;

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
    
    if (IS_IPHONE_5_OR_LESS) {
        signupTopSpace.constant = kSpace_IPHONE5;
    }
    else {
        signupTopSpace.constant = kSpace_IPHONE6;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)onTapTermsBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)onTapSignupBtn:(id)sender {
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    BasicBody *requestBody = [[BasicBody alloc] init];
    
    requestBody.grant_type = @"password";
    requestBody.client_id = CLIENT_ID;
    requestBody.client_secret = CLIENT_SECRET;
    requestBody.access_token = delegate.accessToken;
    requestBody.username = @"Tester";
    requestBody.first_name = @"ABC";
    requestBody.last_name = @"DEF";
    requestBody.email = @"test@test.com";
    requestBody.password = @"123456";
    requestBody.password_confirmation = @"123456";
    if (self.userType == Family) {
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


- (void)showAuthoMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:NSLocalizedString(@"_AUTHO_WORK_MESSAGE_", nil)] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *allow = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_NO_I_NOT_", nil)] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddPhotoViewController *addPhotoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPhotoViewController"];
        
        [self.navigationController pushViewController:addPhotoVC animated:YES];
    }];
    
    UIAlertAction *notAllow = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_YES_I_AM_", nil)] style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:allow];
    [alert addAction:notAllow];
    
    alert.view.tintColor = MAIN_COLOR;
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showErrorMsg:(NSString*)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_OK_", nil)] style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:ok];
    
    alert.view.tintColor = MAIN_COLOR;
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)goProfileSetupPage {
    if (self.userType == CareProvider) {
        [self showAuthoMessage];
        return;
    }
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
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
                    NSLog(@"User Id : %li", [signup.user_id integerValue]);
                    
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
                    [self goProfileSetup:user];
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
