//
//  CareProviderShortViewController.m
//  AyiConnection
//
//  Created by JCB on 2/21/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "CareProviderShortViewController.h"
#import "SignUpViewController.h"
#import "LoginViewController.h"

@implementation CareProviderShortDefaultCell

@end

@interface CareProviderShortViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation CareProviderShortViewController
@synthesize btnLogin;
@synthesize btnSignup;
@synthesize vBottom;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    btnLogin.clipsToBounds = YES;
    btnLogin.layer.cornerRadius = 5;
    btnSignup.clipsToBounds = YES;
    btnSignup.layer.cornerRadius = 5;
    
    vBottom.layer.masksToBounds = NO;
    vBottom.layer.shadowOffset = CGSizeMake(1, 1);
    vBottom.layer.shadowRadius = 5;
    vBottom.layer.shadowOpacity = 0.5;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CareProviderShortDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CareProviderShortDefaultCell" forIndexPath:indexPath];
    
    cell.imgAvatar.clipsToBounds = YES;
    cell.imgAvatar.layer.cornerRadius = cell.imgAvatar.frame.size.height / 2;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self showAlertDialog];
}

#pragma mark - Action
- (IBAction)onTapLoginBtn:(id)sender {
    LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (IBAction)onTapSignupBtn:(id)sender {
    SignUpViewController *signUpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    
    [self.navigationController pushViewController:signUpVC animated:YES];
}

- (void)showAlertDialog {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_LOGIN_OR_SIGNUP_", nil)] message:[NSString stringWithFormat:NSLocalizedString(@"_LOGIN_OR_SIGNUP_MESSAGE_", nil)] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *login = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_LOGIN_", nil)] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *signup = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_SIGNUP_", nil)] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self onTapSignupBtn:nil];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_CANCEL_", nil)] style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:login];
    [alert addAction:signup];
    [alert addAction:cancel];
    
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
