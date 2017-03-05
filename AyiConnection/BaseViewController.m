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
    
    NSLog(@"Login Access Token : %@", user.username);
    
    profileReqeust.access_token = delegate.accessToken;
    profileReqeust.first_name = user.first_name;
    profileReqeust.last_name = user.last_name;
    profileReqeust.username = user.username;
    profileReqeust.email = user.email;
    profileReqeust.bio = user.bio;
    profileReqeust.age = [NSNumber numberWithInteger:user.age];
    profileReqeust.gender = [NSNumber numberWithInteger:user.gender];
    profileReqeust.location = [NSNumber numberWithInteger:user.location_id];
    profileReqeust.phone = user.phone;
    profileReqeust.wechat = user.wechat;
    profileReqeust.qq = user.qq;
    profileReqeust.whatsapp = user.whatsapp;
    
//    Userable *userable = user.userable;
//    profileReqeust.experience =[NSNumber numberWithInteger: userable.experience];
//    profileReqeust.salary = [NSNumber numberWithInteger:userable.salary];
//    profileReqeust.salary_type = [NSNumber numberWithInteger:userable.salary_type];
//    profileReqeust.living_status = [NSNumber numberWithInteger:userable.living_status];
//    profileReqeust.availability = [NSNumber numberWithInteger:userable.availability];
//    profileReqeust.available_monday = [NSNumber numberWithInteger:userable.available_monday];
//    profileReqeust.available_tuesday = [NSNumber numberWithInteger:userable.available_tuesday];
//    profileReqeust.available_wednesday = [NSNumber numberWithInteger:userable.available_wednesday];
//    profileReqeust.available_thursday = [NSNumber numberWithInteger:userable.available_thursday];
//    profileReqeust.available_friday = [NSNumber numberWithInteger:userable.available_friday];
//    profileReqeust.available_saturday = [NSNumber numberWithInteger:userable.available_saturday];
//    profileReqeust.available_sunday = [NSNumber numberWithInteger:userable.available_sunday];
    
    
    
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
