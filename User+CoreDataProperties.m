//
//  User+CoreDataProperties.m
//  
//
//  Created by JCB on 2/25/17.
//
//  This file was automatically generated and should not be edited.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic age;
@dynamic bio;
@dynamic can_edit;
@dynamic email;
@dynamic first_name;
@dynamic gender;
@dynamic inactive;
@dynamic last_name;
@dynamic location_id;
@dynamic name_string;
@dynamic phone;
@dynamic profile_completed;
@dynamic profile_photo;
@dynamic qq;
@dynamic trial_ends_at;
@dynamic userable_id;
@dynamic userable_type;
@dynamic userid;
@dynamic username;
@dynamic wechat;
@dynamic whatsapp;
@dynamic stripe_id;
@dynamic card_brand;
@dynamic card_last_four;
@dynamic photo;
@dynamic usertype;
@dynamic userable;

@end
