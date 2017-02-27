//
//  BaseViewController+RestServicesManagement.h
//  GoldenSpear
//
//  Created by Jose Antonio Sanchez Martinez on 13/04/15.
//  Copyright (c) 2015 GoldenSpear. All rights reserved.
//

#import "BaseViewController.h"
#import <RestKit/RestKit.h>

typedef enum connectionType
{
    USER_LOGIN,
    USER_SIGNUP,
    GET_USER_PROFILE,
    UPDATE_USER_PROFILE,
    ERROR,
    
    SEND_SMS
}
connectionType;

@interface BaseViewController (RestServicesManagement)

- (void) performRestPost:(connectionType)connection withParamaters:(NSArray *)parameters;
- (void) actionAfterSuccessfulAnswerToRestConnection:(connectionType)connection WithResult:(NSArray *) mappingResult;

@end
