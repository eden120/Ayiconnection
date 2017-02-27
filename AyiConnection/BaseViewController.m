//
//  BaseViewController.m
//  AyiConnection
//
//  Created by JCB on 2/23/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ProfileBody *)getProfileUpdateParam {
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    User *user = delegate.currentUser;
    
    ProfileBody *profileReqeust = [[ProfileBody alloc] init];
    
    NSLog(@"Login Access Token : %@", delegate.accessToken);
    
    profileReqeust.access_token = delegate.accessToken;
    profileReqeust.first_name = user.first_name;
    profileReqeust.last_name = user.last_name;
    profileReqeust.username = user.username;
    profileReqeust.email = user.email;
    profileReqeust.bio = user.bio;
    profileReqeust.age = [NSNumber numberWithInteger:user.age];
    profileReqeust.gender = [NSNumber numberWithInteger:user.gender];
    
    return profileReqeust;
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
