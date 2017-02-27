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

- (void)saveContext;


@end

