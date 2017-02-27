//
//  User+CoreDataProperties.h
//  
//
//  Created by JCB on 2/25/17.
//
//  This file was automatically generated and should not be edited.
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nonatomic) int32_t age;
@property (nullable, nonatomic, copy) NSString *bio;
@property (nonatomic) int32_t can_edit;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *first_name;
@property (nonatomic) int32_t gender;
@property (nonatomic) int32_t inactive;
@property (nullable, nonatomic, copy) NSString *last_name;
@property (nonatomic) int32_t location_id;
@property (nullable, nonatomic, copy) NSString *name_string;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nonatomic) int32_t profile_completed;
@property (nullable, nonatomic, copy) NSString *profile_photo;
@property (nullable, nonatomic, copy) NSString *qq;
@property (nullable, nonatomic, copy) NSDate *trial_ends_at;
@property (nonatomic) int32_t userable_id;
@property (nullable, nonatomic, copy) NSString *userable_type;
@property (nonatomic) int32_t userid;
@property (nullable, nonatomic, copy) NSString *username;
@property (nullable, nonatomic, copy) NSString *wechat;
@property (nullable, nonatomic, copy) NSString *whatsapp;
@property (nullable, nonatomic, copy) NSString *stripe_id;
@property (nullable, nonatomic, copy) NSString *card_brand;
@property (nullable, nonatomic, copy) NSString *card_last_four;
@property (nullable, nonatomic, retain) NSData *photo;
@property (nonatomic) int32_t usertype;
@property (nullable, nonatomic, retain) Userable *userable;

@end

NS_ASSUME_NONNULL_END
