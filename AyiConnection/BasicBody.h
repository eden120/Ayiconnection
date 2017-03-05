//
//  BasicBody.h
//  AyiConnection
//
//  Created by JCB on 2/23/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicBody : NSObject

//// Request Body for Get Access Token
@property (nonatomic, strong) NSString *grant_type;
@property (nonatomic, strong) NSString *client_id;
@property (nonatomic, strong) NSString *client_secret;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *first_name;
@property (nonatomic, strong) NSString *last_name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *password_confirmation;
@property (nonatomic, strong) NSString *provider;
@property (nonatomic, strong) NSString *social_token;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *access_token;


@property (nonatomic, strong) NSString *phoneNumber;


@property (nonatomic, strong) NSString *lang;
@property (nonatomic, strong) NSString *state_code;


@end
