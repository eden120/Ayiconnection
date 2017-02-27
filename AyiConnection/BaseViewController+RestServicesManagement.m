	//
//  BaseViewController+RestServicesManagement.m
//  GoldenSpear
//
//  Created by Jose Antonio Sanchez Martinez on 13/04/15.
//  Copyright (c) 2015 GoldenSpear. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseViewController+RestServicesManagement.h"
#import <objc/runtime.h>

@implementation BaseViewController (RestServicesManagement)

#pragma mark - Rest services management
- (void) performRestPost:(connectionType)connection withParamaters:(NSArray *)parameters {
    [self performRestPost:connection withParamaters:parameters retrying:YES];
}
    
- (void) performRestPost:(connectionType)connection withParamaters:(NSArray *)parameters retrying:(BOOL) bRetrying {
    NSString * postString;
    id dataObject;
    NSArray *failedAnswerErrorMessage;
    
    switch (connection) {
        case USER_LOGIN:
        {
            if(!(parameters == nil))
            {
                if ([parameters count] == 1)
                {
                    
                    postString = @"/api/access_token";
                    //Data object to post
                    dataObject = (BasicBody*)[parameters objectAtIndex:0];
                    
                    //Message to show if not succeed
                    failedAnswerErrorMessage = nil;
                }
                else
                {
                    NSLog(@"XXXX Incorrect number of parameters to perform request! XXXX");
                    
                    
                    return;
                }
            }
            break;
        }
        case USER_SIGNUP:
        {
            if(!(parameters == nil))
            {
                if ([parameters count] == 1)
                {
                    
                    postString = @"/api/auth/register";
                    //Data object to post
                    dataObject = (BasicBody*)[parameters objectAtIndex:0];
                    
                    //Message to show if not succeed
                    failedAnswerErrorMessage = nil;
                }
                else
                {
                    NSLog(@"XXXX Incorrect number of parameters to perform request! XXXX");
                    
                    
                    return;
                }
            }
            break;
        }
        case SEND_SMS:
        {
            if(!(parameters == nil))
            {
                if ([parameters count] == 1)
                {
                    
                    postString = @"/api/auth/send_sms";
                    //Data object to post
                    dataObject = (BasicBody*)[parameters objectAtIndex:0];
                    
                    //Message to show if not succeed
                    failedAnswerErrorMessage = nil;
                }
                else
                {
                    NSLog(@"XXXX Incorrect number of parameters to perform request! XXXX");
                    
                    
                    return;
                }
            }
            break;
        }
        case GET_USER_PROFILE:
        {
            if(!(parameters == nil))
            {
                if ([parameters count] == 1)
                {
                    
                    postString = @"/api/user/profile";
                    //Data object to post
                    dataObject = (BasicBody*)[parameters objectAtIndex:0];
                    
                    //Message to show if not succeed
                    failedAnswerErrorMessage = nil;
                }
                else
                {
                    NSLog(@"XXXX Incorrect number of parameters to perform request! XXXX");
                    
                    
                    return;
                }
            }
            break;
        }
        case UPDATE_USER_PROFILE:
        {
            if(!(parameters == nil))
            {
                if ([parameters count] == 2)
                {
                    NSNumber *user_type = [parameters objectAtIndex:0];
                    if ([user_type integerValue] == 0) {
                        postString = @"/api/user/family/update";
                    }
                    else {
                        postString = @"/api/user/caregiver/update";
                    }
                    
                    //Data object to post
                    dataObject = (BasicBody*)[parameters objectAtIndex:1];
                    
                    //Message to show if not succeed
                    failedAnswerErrorMessage = nil;
                }
                else
                {
                    NSLog(@"XXXX Incorrect number of parameters to perform request! XXXX");
                    
                    
                    return;
                }
            }
            break;
        }
        default:
            break;
    }
    
    if(!(postString == nil) && (!(dataObject == nil)))
    {
        if (!([postString isEqualToString:@""]))
        {
            NSDate *methodStart = [NSDate date];
            
            [[RKObjectManager sharedManager] postObject:dataObject
                                                   path:postString
                                             parameters:nil
                                                success:^(RKObjectRequestOperation * operation, RKMappingResult * mappingResult)
             {
                 
                 NSDate *methodFinish = [NSDate date];
                 
                 NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
                 
                 NSLog(@"Operation <%@> succeed!! It took: %f", operation.HTTPRequestOperation.request.URL, executionTime);
                 
                 [self processAnswerToRestConnection:connection WithResult: [mappingResult array] lookingForClasses:[NSArray arrayWithObject:dataObject] andIfErrorMessage:failedAnswerErrorMessage];
             }
                                                failure:^(RKObjectRequestOperation * operation, NSError *error)
             {
                 //Message to show if no results were provided
                 NSArray *errorMessage = [NSArray arrayWithObjects:NSLocalizedString(@"_ERROR_", nil), NSLocalizedString(@"_CONNECTION_ERROR_MSG_", nil), NSLocalizedString(@"_OK_", nil), nil];
                 
                 // If 'failedAnswerErrorMessage' is nil, it means that we don't want to provide messages to the user
                 if(failedAnswerErrorMessage == nil)
                 {
                     errorMessage = nil;
                 }
                 
                 NSManagedObjectContext *currentContext = [RKObjectManager sharedManager].managedObjectStore.mainQueueManagedObjectContext;
                 
                 if ([dataObject isKindOfClass:[NSManagedObject class]])
                 {
                     [currentContext deleteObject:dataObject];
                     NSError * error = nil;
                     if (![currentContext save:&error])
                     {
                         NSLog(@"Error saving context! %@", error);
                     }
                     
                 }
                 
                 NSLog(@"Operation <%@> failed with error: %ld", operation.HTTPRequestOperation.request.URL, (long)operation.HTTPRequestOperation.response.statusCode);
                 
                 
                 if(((long)operation.HTTPRequestOperation.response.statusCode) < 250)
                 {
                     [self processAnswerToRestConnection:connection WithResult: nil lookingForClasses:[NSArray arrayWithObject:dataObject] andIfErrorMessage:failedAnswerErrorMessage];
                 }
                 else
                 {
                     [self processRestConnection: connection WithErrorMessage:errorMessage forOperation:operation];
                 }
                 // #ifndef _OSAMA_
                 //                     [[NSNotificationCenter defaultCenter] postNotificationName:@"FailedItemToWardrobeNotification" object:self];
                 // #endif
                 
             }];
            
            return;
        }
    }
    
#ifndef _OSAMA_
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FailedItemToWardrobeNotification" object:self];
#endif
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"_ERROR_", nil) message:NSLocalizedString(@"_CONNECTION_ERROR_MSG_", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"_OK_", nil) otherButtonTitles:nil];
    
    [alertView show];
    
    [self processRestConnection: connection WithErrorMessage:nil forOperation:nil];
}

// Rest answer arrived. Check if it succeedded or not
- (void)processAnswerToRestConnection:(connectionType)connection WithResult:(NSArray *)mappingResult lookingForClasses:(NSArray *)dataClasses andIfErrorMessage:(NSArray *)errorMessage {
    if (mappingResult != nil) {
        [self actionAfterSuccessfulAnswerToRestConnection:connection WithResult:mappingResult];
        
        return;
    }
}
    
// Rest answer not reached
- (void)processRestConnection:(connectionType)connection WithErrorMessage:(NSArray *)errorMessage forOperation:(RKObjectRequestOperation *)operation {
    [self actionAfterSuccessfulAnswerToRestConnection:ERROR WithResult:nil];
}


// Action to perform once an answer is succesfully processed
- (void) actionAfterSuccessfulAnswerToRestConnection:(connectionType)connection WithResult:(NSArray *)mappingResult
{
    NSLog(@"XXXX This is an abstract method and should be overridden XXXX");
    
}

@end

