//
//  Userable+CoreDataProperties.h
//  
//
//  Created by JCB on 2/25/17.
//
//  This file was automatically generated and should not be edited.
//

#import "Userable+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Userable (CoreDataProperties)

+ (NSFetchRequest<Userable *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *age_kids;
@property (nonatomic) int32_t availability;
@property (nonatomic) int32_t available_end;
@property (nullable, nonatomic, copy) NSString *available_end_string;
@property (nonatomic) int32_t available_friday;
@property (nonatomic) int32_t available_monday;
@property (nonatomic) int32_t available_saturday;
@property (nonatomic) int32_t available_start;
@property (nullable, nonatomic, copy) NSString *available_start_string;
@property (nonatomic) int32_t available_sunday;
@property (nonatomic) int32_t available_thursday;
@property (nonatomic) int32_t available_tuesday;
@property (nonatomic) int32_t available_wednesday;
@property (nonatomic) int32_t background_check_id;
@property (nonatomic) int32_t experience;
@property (nonatomic) int32_t has_references;
@property (nonatomic) int32_t has_transportation;
@property (nonatomic) int32_t is_verified;
@property (nonatomic) int32_t is_work_eligible;
@property (nonatomic) int32_t living_status;
@property (nonatomic) int32_t num_days_available;
@property (nonatomic) int32_t num_kids;
@property (nonatomic) int32_t num_of_days;
@property (nonatomic) int32_t salary;
@property (nullable, nonatomic, copy) NSString *salary_string;
@property (nonatomic) int32_t salary_type;
@property (nullable, nonatomic, copy) NSString *salary_type_string;
@property (nullable, nonatomic, copy) NSDate *start_date;
@property (nonatomic) int32_t user_id;
@property (nonatomic) int32_t userable_id;
@property (nonatomic) int32_t will_background;
@property (nonatomic) int32_t will_relocate;
@property (nonatomic) int32_t will_work_agency;

@end

NS_ASSUME_NONNULL_END
