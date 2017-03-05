//
//  ProfileBody.h
//  AyiConnection
//
//  Created by JCB on 2/26/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileBody : NSObject

@property (nonatomic, weak) NSString *access_token;
@property (nonatomic) NSString *username;
@property (nonatomic, weak) NSString *first_name;
@property (nonatomic, weak) NSString *last_name;
@property (nonatomic, weak) NSString *email;
@property (nonatomic, weak) NSNumber *location;
@property (nonatomic, weak) NSNumber *gender;
@property (nonatomic, weak) NSNumber *age;
@property (nonatomic, weak) NSString *bio;
@property (nonatomic, weak) NSNumber *inactive;
@property (nonatomic, weak) NSString *phone;
@property (nonatomic, weak) NSString *wechat;
@property (nonatomic, weak) NSString *qq;
@property (nonatomic, weak) NSString *whatsapp;
@property (nonatomic, weak) NSData *photo;
@property (nonatomic, weak) NSNumber *profile_completed;
@property (nonatomic, weak) NSArray *languages;

@property (nonatomic, weak) NSNumber *experience;
@property (nonatomic, weak) NSNumber *salary;
@property (nonatomic, weak) NSNumber *salary_type;
@property (nonatomic, weak) NSNumber *living_status;
@property (nonatomic, weak) NSNumber *availability;
@property (nonatomic, weak) NSNumber *available_sunday;
@property (nonatomic, weak) NSNumber *available_monday;
@property (nonatomic, weak) NSNumber *available_tuesday;
@property (nonatomic, weak) NSNumber *available_wednesday;
@property (nonatomic, weak) NSNumber *available_thursday;
@property (nonatomic, weak) NSNumber *available_friday;
@property (nonatomic, weak) NSNumber *available_saturday;
@property (nonatomic, weak) NSString *available_start;
@property (nonatomic, weak) NSString *available_end;
@property (nonatomic, weak) NSString *start_date;
@property (nonatomic, weak) NSNumber *has_transportation;
@property (nonatomic, weak) NSNumber *has_references;

@property (nonatomic, weak) NSNumber *will_relocate;
@property (nonatomic, weak) NSNumber *will_background;
@property (nonatomic, weak) NSNumber *is_work_eligible;
@property (nonatomic, weak) NSNumber *will_work_agency;

@end
