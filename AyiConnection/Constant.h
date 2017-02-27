//
//  Constant.h
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define MAIN_COLOR [UIColor colorWithRed:255 green:205 blue:178 alpha:1]


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_5_OR_LESS (SCREEN_MAX_LENGTH < 600)

#define CLIENT_ID       @"e167818ee07910e6f69c426b9a626e96"
#define CLIENT_SECRET   @"b1c1d8736f20db3fb6c1c66bb1455ed43909f0d8"

#endif /* Constant_h */
