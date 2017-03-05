//
//  AppDelegate.h
//  AyiConnection
//
//  Created by JCB on 2/20/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "User+CoreDataClass.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic, strong) NSString *accessToken;

@property (nonatomic) User *currentUser;

@property (nonatomic) Language_Setting language;
@property (nonatomic) BOOL enableLocation;
@property (nonatomic) NSString *zipCode;
@property (nonatomic) UserType userType;
@property (nonatomic) UIImage *provider_image;

@property (nonatomic) NSMutableArray *languages;


/// Profile Setup

@property (nonatomic) NSMutableArray *selectedLanguages;
@property (nonatomic) NSMutableArray *selectedResp;
@property (nonatomic) NSMutableArray *selectedWeekdays;
@property (nonatomic) NSString *selectedStartDate;
@property (nonatomic) NSString *selectedEndDate;
@property (nonatomic) NSString *selectedPayment;

- (void)saveContext;


@end

