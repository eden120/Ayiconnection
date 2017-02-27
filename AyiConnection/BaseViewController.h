//
//  BaseViewController.h
//  AyiConnection
//
//  Created by JCB on 2/23/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileBody.h"

typedef enum Language
{
    En,
    Es,
    Cn
}
Language;

typedef enum UserType
{
    Family,
    CareProvider
}
UserType;

@interface BaseViewController : UIViewController

@property (nonatomic) Language language;
@property (nonatomic) BOOL enableLocation;
@property (nonatomic) NSString *zipCode;
@property (nonatomic) UserType userType;

- (ProfileBody *)getProfileUpdateParam;

@end
