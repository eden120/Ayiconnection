//
//  City.h
//  AyiConnection
//
//  Created by JCB on 2/28/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic) NSNumber *city_id;
@property (nonatomic) NSString *city_name;
@property (nonatomic) NSString *state;
@property (nonatomic) NSString *zip;
@property (nonatomic) NSNumber *region_id;

@end
