//
//  SignUpViewController.m
//  AyiConnection
//
//  Created by JCB on 2/21/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "SignUpViewController.h"
#import "SignEmailViewController.h"
#import "LoginViewController.h"
#import <FBSDKLoginKit.h>
#import <FBSDKCoreKit.h>
#import <LinkedInHelper.h>
#import "AboutFamilyViewController.h"

#define kLoginTopSpace_IPHONE5  30
#define kLoginTopSpace_IPHONE6  90

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize btnSignEmail;
@synthesize btnLogin;
@synthesize loginTopSpace;

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
    btnSignEmail.layer.borderColor = MAIN_COLOR.CGColor;
    btnSignEmail.layer.borderWidth = 1.5;
    btnSignEmail.clipsToBounds = YES;
    btnSignEmail.layer.cornerRadius = 8;
    
    if (IS_IPHONE_5_OR_LESS) {
        loginTopSpace.constant = kLoginTopSpace_IPHONE5;
    }
    else {
        loginTopSpace.constant = kLoginTopSpace_IPHONE6;
    }
}

#pragma mark - Action

- (IBAction)onTapSocialBtn:(UIButton *)sender {
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
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self performRestPost:USER_LOGIN withParamaters:@[requestBody]];
        }
    }];
}

- (void)LinkedinLogin {
    
//    LinkedInHelper *linkedin = [LinkedInHelper sharedInstance];
//    
//    NSArray *permissions = @[@(BasicProfile),
//                             @(EmailAddress),
//                             @(Share),
//                             @(CompanyAdmin)];
//    
//    linkedin.showActivityIndicator = YES;
//    
//    [linkedin requestMeWithSenderViewController:self
//                                       clientId:@"786qt8xonztglg"         // Your App Client Id
//                                   clientSecret:@"qYa5tDtkfGwNPXnh"         // Your App Client Secret
//                                    redirectUrl:@"http://ayiconnection.com/"         // Your App Redirect Url
//                                    permissions:permissions
//                                          state:@""               // Your client state
//                                successUserInfo:^(NSDictionary *userInfo) {
//                                    // Whole User Info
//                                    NSLog(@"user Info : %@", userInfo);
//                                    
//                                }
//                              failUserInfoBlock:^(NSError *error) {
//                                  NSLog(@"error : %@", error.userInfo.description);
//                              }
//     ];
}

- (IBAction)onTapSignUpEmailBtn:(id)sender {
    SignEmailViewController *signEmailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignEmailViewController"];
    
    [self.navigationController pushViewController:signEmailVC animated:YES];
}

- (IBAction)onTapLoginBtn:(id)sender {
    LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (IBAction)onTapBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)actionAfterSuccessfulAnswerToRestConnection:(connectionType)connection WithResult:(NSArray *)mappingResult {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    switch (connection) {
        case USER_LOGIN:
        {
            for (LoginData *login in mappingResult) {
                if ([login isKindOfClass:[LoginData class]]) {
                    delegate.accessToken = login.access_token;
                    
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
