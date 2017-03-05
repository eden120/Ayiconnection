//
//  SplashViewController.m
//  AyiConnection
//
//  Created by JCB on 3/3/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "SplashViewController.h"
#import "LanguageViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController {
    NSMutableArray *languages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getAccessToken];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getAllLanguages {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    BasicBody *request = [[BasicBody alloc] init];
    request.access_token = delegate.accessToken;
    
    [self performRestPost:GET_ALL_LANGUAGES withParamaters:@[request]];
}

- (void)getAccessToken {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    BasicBody *requestBody = [[BasicBody alloc] init];
    requestBody.grant_type = @"client_credentials";
    requestBody.client_id = CLIENT_ID;
    requestBody.client_secret = CLIENT_SECRET;
    
    [self performRestPost:GET_TOKEN withParamaters:@[requestBody]];
}

- (void)actionAfterSuccessfulAnswerToRestConnection:(connectionType)connection WithResult:(NSArray *)mappingResult {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    switch (connection) {
        case ERROR:
        {
            [self showErrorMsg:[NSString stringWithFormat:NSLocalizedString(@"_ERROR_", nil)]];
            break;
        }
        case GET_TOKEN:
        {
            for (LoginData *login in mappingResult) {
                if ([login isKindOfClass:[LoginData class]]) {
                    delegate.accessToken = login.access_token;
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:login.access_token forKey:@"TOKEN"];
                    [defaults synchronize];
                    
                    [self getAllLanguages];
                }
            }
            
            break;
        }
        case GET_ALL_LANGUAGES:
        {
            languages = [[NSMutableArray alloc] init];
            for (Language *language in mappingResult) {
                if ([language isKindOfClass:[Language class]]) {
                    [languages addObject:language];
                }
            }
            
            delegate.languages = [languages mutableCopy];
            
            LanguageViewController *languageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LanguageViewController"];
            
            [self.navigationController pushViewController:languageVC animated:NO];
            
            break;
        }
        default:
            break;
    }
}

- (void)showErrorMsg:(NSString*)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_OK_", nil)] style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:ok];
    
    alert.view.tintColor = ALERT_COLOR;
    
    [self presentViewController:alert animated:YES completion:nil];
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
