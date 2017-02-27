//
//  LoginData.h
//  AyiConnection
//
//  Created by JCB on 2/23/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginData : NSObject

@property (nonatomic, weak) NSString *access_token;
@property (nonatomic, weak) NSString *token_type;

@property (nonatomic, weak) NSNumber *registered;
@property (nonatomic, weak) NSNumber *user_id;

@end
