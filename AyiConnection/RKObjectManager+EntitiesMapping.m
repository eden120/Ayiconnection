//
//  RKObjectManager+EntitiesMapping.m
//  GoldenSpear
//
//  Created by Jose Antonio Sanchez Martinez on 08/04/15.
//  Copyright (c) 2015 GoldenSpear. All rights reserved.
//

#import "RKObjectManager+EntitiesMapping.h"
#import "User+CoreDataClass.h"

@implementation RKObjectManager (EntitiesMapping)

- (void)defineMappings
{
    
    //// --------------------------------------------------////
    //// -------------- RESPONSE ENTITIES MAPPING ---------////
    //// --------------------------------------------------////
    
    
    // User Login
    RKObjectMapping *loginDataMapping = [RKObjectMapping mappingForClass:[LoginData class]];
    
    [loginDataMapping addAttributeMappingsFromDictionary:@{
                                                           @"access_token" : @"access_token",
                                                           @"token_type" : @"token_type"
                                                           }];
    
    RKResponseDescriptor *loginResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:loginDataMapping method:RKRequestMethodPOST pathPattern:@"/api/access_token" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    // User Singup Via Email
    RKObjectMapping *emailSignupMapping = [RKObjectMapping mappingForClass:[LoginData class]];
    
    [emailSignupMapping addAttributeMappingsFromDictionary:@{
                                                             @"registered" : @"registered",
                                                             @"id" : @"user_id"
                                                             }];
    
    RKResponseDescriptor *emailSignupResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:emailSignupMapping method:RKRequestMethodPOST pathPattern:@"/api/auth/register" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    
    
    // User Profile
    
    RKEntityMapping *userProfileMapping = [RKEntityMapping mappingForEntityForName:@"User" inManagedObjectStore:[RKManagedObjectStore defaultStore]];
    
    userProfileMapping.identificationAttributes = @[@"userid"];
    
    [userProfileMapping addAttributeMappingsFromDictionary:@{
                                                             @"id" : @"userid",
                                                             @"age" : @"age",
                                                             @"bio" : @"bio",
                                                             @"can_edit" : @"can_edit",
                                                             @"card_brand" : @"card_brand",
                                                             @"card_last_four" : @"card_last_four",
                                                             @"email" : @"email",
                                                             @"first_name" : @"first_name",
                                                             @"gender" : @"gender",
                                                             @"inactive" : @"inactive",
                                                             @"last_name" : @"last_name",
                                                             @"location_id" : @"location_id",
                                                             @"name_string" : @"name_string",
                                                             @"phone" : @"phone",
                                                             @"photo" : @"photo",
                                                             @"profile_completed" : @"profile_completed",
                                                             @"profile_photo" : @"profile_photo",
                                                             @"qq" : @"qq",
                                                             @"stripe_id" : @"stripe_id",
                                                             @"trial_ends_at" : @"trial_ends_at",
                                                             @"userable_id" : @"userable_id",
                                                             @"userable_type" : @"userable_type",
                                                             @"username" : @"username",
                                                             @"wechat" : @"wechat",
                                                             @"whatsapp" : @"whatsapp",
                                                             @"usertype" : @"usertype"
                                                             }];
    
    RKEntityMapping *userableMapping = [RKEntityMapping mappingForEntityForName:@"Userable" inManagedObjectStore:[RKManagedObjectStore defaultStore]];
    
    userableMapping.identificationAttributes = @[@"userable_id"];
    
    [userableMapping addAttributeMappingsFromDictionary:@{
                                                          @"id" : @"userable_id",
                                                          @"age_kids" : @"age_kids",
                                                          @"availability" : @"availability",
                                                          @"available_end" : @"available_end",
                                                          @"available_end_string" : @"available_end_string",
                                                          @"available_friday" : @"available_friday",
                                                          @"available_monday" : @"available_monday",
                                                          @"available_saturday" : @"available_saturday",
                                                          @"available_start" : @"available_start",
                                                          @"available_start_string" : @"available_start_string",
                                                          @"available_sunday" : @"available_sunday",
                                                          @"available_thursday" : @"available_thursday",
                                                          @"available_tuesday" : @"available_tuesday",
                                                          @"available_wednesday" : @"available_wednesday",
                                                          @"background_check_id" : @"background_check_id",
                                                          @"experience" : @"experience",
                                                          @"has_references" : @"has_references",
                                                          @"has_transportation" : @"has_transportation",
                                                          @"is_verified" : @"is_verified",
                                                          @"is_work_eligible" : @"is_work_eligible",
                                                          @"living_status" : @"living_status",
                                                          @"num_days_available" : @"num_days_available",
                                                          @"num_kids" : @"num_kids",
                                                          @"num_of_days" : @"num_of_days",
                                                          @"salary" : @"salary",
                                                          @"salary_string" : @"salary_string",
                                                          @"salary_type" : @"salary_type",
                                                          @"salary_type_string" : @"salary_type_string",
                                                          @"start_date" : @"start_date",
                                                          @"user_id" : @"user_id",
                                                          @"will_background" : @"will_background",
                                                          @"will_relocate" : @"will_relocate",
                                                          @"will_work_agency" : @"will_work_agency"
                                                          }];
    
    
    [userProfileMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"userable" toKeyPath:@"userable" withMapping:userableMapping]];
    
    RKResponseDescriptor *userProfileResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userProfileMapping method:RKRequestMethodPOST pathPattern:@"/api/user/profile" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *familyProfileUpdateResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userProfileMapping method:RKRequestMethodPOST pathPattern:@"/api/user/family/update" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *providerProfileUpdateResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:userProfileMapping method:RKRequestMethodPOST pathPattern:@"/api/user/caregiver/update" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    //// --------------------------------------------------////
    //// ----------------REQUEST ENTITIES MAPPING ---------////
    //// --------------------------------------------------////
    
    RKObjectMapping *basicBodyRequestMapping = [RKObjectMapping mappingForClass:[BasicBody class]];
    
    [basicBodyRequestMapping addAttributeMappingsFromDictionary:@{
                                                                  @"grant_type" : @"grant_type",
                                                                  @"client_id" : @"client_id",
                                                                  @"client_secret" : @"client_secret",
                                                                  @"username" : @"username",
                                                                  @"password" : @"password",
                                                                  @"provider" : @"provider",
                                                                  @"social_token" : @"social_token",
                                                                  @"type" : @"type",
                                                                  @"access_token" : @"access_token",
                                                                  @"phone" : @"phoneNumber"
                                                                  
                                                                  }];
    
    RKRequestDescriptor *basicBodyRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[basicBodyRequestMapping inverseMapping] objectClass:[BasicBody class] rootKeyPath:nil method:RKRequestMethodPOST];
    
    
    // Profile Update
    
    RKObjectMapping *profileUpateMapping = [RKObjectMapping mappingForClass:[ProfileBody class]];
    
    [profileUpateMapping addAttributeMappingsFromDictionary:@{
                                                              @"access_token" : @"access_token",
                                                              @"age" : @"age",
                                                              @"bio" : @"bio",
                                                              @"email" : @"email",
                                                              @"first_name" : @"first_name",
                                                              @"gender" : @"gender",
                                                              @"inactive" : @"inactive",
                                                              @"last_name" : @"last_name",
                                                              @"location" : @"location",
                                                              @"phone" : @"phone",
                                                              @"photo" : @"photo",
                                                              @"profile_completed" : @"profile_completed",
                                                              @"profile_photo" : @"profile_photo",
                                                              @"qq" : @"qq",
                                                              @"username" : @"username",
                                                              @"wechat" : @"wechat",
                                                              @"whatsapp" : @"whatsapp",
                                                              @"usertype" : @"usertype",
                                                              @"living_status" : @"living_status",
                                                              @"experience" : @"experience",
                                                              @"salary_type" : @"salary_type",
                                                              @"salary" : @"salary",
                                                              @"availability" : @"availability",
                                                              @"available_start" : @"available_start",
                                                              @"available_end" : @"available_end",
                                                              @"available_friday" : @"available_friday",
                                                              @"available_monday" : @"available_monday",
                                                              @"available_saturday" : @"available_saturday",
                                                              @"available_sunday" : @"available_sunday",
                                                              @"available_thursday" : @"available_thursday",
                                                              @"available_tuesday" : @"available_tuesday",
                                                              @"available_wednesday" : @"available_wednesday",
                                                              @"has_references" : @"has_references",
                                                              @"has_transportation" : @"has_transportation",
                                                              @"will_background" : @"will_background",
                                                              @"will_relocate" : @"will_relocate",
                                                              @"is_work_eligible" : @"is_work_eligible",
                                                              @"will_work_agency" : @"will_work_agency"
                                                              }];
    
    RKRequestDescriptor *userProfileRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[profileUpateMapping inverseMapping] objectClass:[ProfileBody class] rootKeyPath:nil method:RKRequestMethodPOST];
    
    
    
    
    [self addRequestDescriptorsFromArray:@[basicBodyRequestDescriptor,
                                           userProfileRequestDescriptor]];
    
    [self addResponseDescriptorsFromArray:@[loginResponseDescriptor,
                                            emailSignupResponseDescriptor,
                                            userProfileResponseDescriptor,
                                            familyProfileUpdateResponseDescriptor,
                                            providerProfileUpdateResponseDescriptor]];
}

@end
