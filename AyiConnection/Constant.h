//
//  Constant.h
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define MAIN_COLOR [UIColor colorWithRed:255.0f/255.0f green:206.0f/255.0f blue:176.0f/255.0f alpha:1]

#define ALERT_COLOR [UIColor colorWithRed:59.0f/255.0f green:215.0f/255.0f blue:207.0f/255.0f alpha:1]

#define CARE_TYPE_BORDER_COLOR  [UIColor colorWithRed:222.0f/255.0f green:222.0f/255.0f blue:222.0f/255.0f alpha:1]

#define RESPONSE_SELECTED_COLOR     [UIColor colorWithRed:74.0f/255.0f green:74.0f/255.0f blue:74.0f/255.0f alpha:1]
#define RESPONSE_UNSELECTED_COLOR     [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1]

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_5_OR_LESS (SCREEN_MAX_LENGTH < 600)

#define CLIENT_ID       @"e167818ee07910e6f69c426b9a626e96"
#define CLIENT_SECRET   @"b1c1d8736f20db3fb6c1c66bb1455ed43909f0d8"

typedef enum Language_Setting
{
    En,
    Es,
    Cn
}
Language_Setting;

typedef enum UserType
{
    Family,
    CareProvider
}
UserType;

typedef enum CareType
{
    ChildCare = 1,
    SeniorCare,
    HomeCare,
    Tutor
}
CareType;

#endif /* Constant_h */
