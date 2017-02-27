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
@property (nonatomic, weak) NSString *grant_type;
@property (nonatomic, weak) NSString *client_id;
@property (nonatomic, weak) NSString *client_secret;
@property (nonatomic, weak) NSString *username;
@property (nonatomic, weak) NSString *first_name;
@property (nonatomic, weak) NSString *last_name;
@property (nonatomic, weak) NSString *email;
@property (nonatomic, weak) NSString *password;
@property (nonatomic, weak) NSString *password_confirmation;
@property (nonatomic, weak) NSString *provider;
@property (nonatomic, weak) NSString *social_token;
@property (nonatomic, weak) NSString *type;

@property (nonatomic, weak) NSString *access_token;


@property (nonatomic, weak) NSString *phoneNumber;


@end
