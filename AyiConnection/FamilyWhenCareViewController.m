//
//  FamilyWhenCareViewController.m
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "FamilyWhenCareViewController.h"
#import "FamilyRateViewController.h"

#define kPickerHeight       250


@interface FamilyWhenCareViewController ()

@end

@implementation FamilyWhenCareViewController {
    BOOL pickerVisible;
    UILabel *currentLabel;
    
    NSString *selectedStartDate;
    NSString *selectedEndDate;
    NSString *selectedStartTime;
    NSString *selectedEndTime;
    
    NSMutableArray *strWeeks;
    NSMutableArray *selectedWeeks;
}
@synthesize btnNext;
@synthesize btnMon;
@synthesize btnTue;
@synthesize btnWed;
@synthesize btnThu;
@synthesize btnFri;
@synthesize btnSat;
@synthesize btnSun;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    strWeeks = [NSMutableArray arrayWithObjects:@"mo", @"tu", @"we", @"th", @"fr", @"sa", @"su", nil];
    selectedWeeks = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    btnNext.layer.borderColor = MAIN_COLOR.CGColor;
    btnNext.layer.borderWidth = 1.5;
    btnNext.clipsToBounds = YES;
    btnNext.layer.cornerRadius = 8;
    
    [self setupWeekDayButton:btnMon];
    [self setupWeekDayButton:btnTue];
    [self setupWeekDayButton:btnWed];
    [self setupWeekDayButton:btnThu];
    [self setupWeekDayButton:btnFri];
    [self setupWeekDayButton:btnSat];
    [self setupWeekDayButton:btnSun];
    
    pickerVisible = NO;
    
    self.vPicker.hidden = YES;
    
    selectedStartDate = [self getDateStringFromDate:[NSDate date]];
    _lblStartDate.text = [self getDateStringFromDate:[NSDate date]];
    selectedEndDate = [self getDateStringFromDate:[NSDate date]];
    _lblEndDate.text = [self getDateStringFromDate:[NSDate date]];
    selectedStartTime = [self getTimeStringFromDate:[NSDate date]];
    _lblStartTime.text = [self getTimeStringFromDate:[NSDate date]];
    selectedEndTime = [self getTimeStringFromDate:[NSDate date]];
    _lblEndTime.text = [self getTimeStringFromDate:[NSDate date]];
    
    
    //self.vPicker.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self hideDatePicker];
}

- (void)setupWeekDayButton:(UIButton *)button {
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 5;
    button.layer.borderColor = MAIN_COLOR.CGColor;
    button.layer.borderWidth = 1;
}

- (void)showDatePicker {
    
    [UIView animateWithDuration:0.5 animations:^
     {
         self.vPicker.hidden = NO;
         CGRect frame = self.vPicker.frame;
         frame.origin.y = SCREEN_HEIGHT - kPickerHeight;
         
         self.vPicker.frame = frame;
         
     }completion:^(BOOL finished)
     {
         pickerVisible = YES;
     }];
}

- (void)hideDatePicker {
    [UIView animateWithDuration:0.5 animations:^
     {
         CGRect frame = self.vPicker.frame;
         frame.origin.y = SCREEN_HEIGHT;
         
         self.vPicker.frame = frame;
         
     }completion:^(BOOL finished)
     {
         pickerVisible = NO;
         self.vPicker.hidden = NO;
     }];
}


#pragma mark - Action
- (IBAction)onTapWeekBtn:(UIButton *)sender {
    NSString *selectedStr = [strWeeks objectAtIndex:sender.tag];
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setBackgroundColor:MAIN_COLOR];
        
        [selectedWeeks addObject:selectedStr];
    }
    else {
        [sender setBackgroundColor:[UIColor whiteColor]];
        
        NSMutableArray *temp = [selectedWeeks mutableCopy];
        
        for (NSString *str in strWeeks) {
            if ([str isEqualToString:selectedStr]) {
                [selectedWeeks removeObject:str];
            }
        }
    }
}

- (IBAction)onTapStartDate:(id)sender {
    [self.datePicker setMinimumDate:[NSDate date]];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker setDate:[self getDateFromString:selectedStartDate]];
    
    currentLabel = _lblStartDate;
    
    if (!pickerVisible) {
        [self showDatePicker];
    }
}

- (IBAction)onTapEnddate:(id)sender {
    [self.datePicker setMinimumDate:[NSDate date]];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker setDate:[self getDateFromString:selectedEndDate]];
    
    currentLabel = _lblEndDate;
    
    if (!pickerVisible) {
        [self showDatePicker];
    }
}

- (IBAction)onTapStartTime:(id)sender {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:-30];
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [self.datePicker setMinimumDate:minDate];
    [self.datePicker setDatePickerMode:UIDatePickerModeTime];
    [self.datePicker setDate:[self getTimefromString:selectedStartTime]];
    
    
    currentLabel = _lblStartTime;
    
    if (!pickerVisible) {
        [self showDatePicker];
    }
}

- (IBAction)onTapEndTime:(id)sender {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:-30];
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [self.datePicker setMinimumDate:minDate];
    [self.datePicker setDatePickerMode:UIDatePickerModeTime];
    [self.datePicker setDate:[self getTimefromString:selectedEndTime]];
    
    currentLabel = _lblEndTime;
    
    if (!pickerVisible) {
        [self showDatePicker];
    }
}
- (IBAction)onChanged:(UIDatePicker *)sender {
    if ([currentLabel isEqual:_lblStartDate] || [currentLabel isEqual:_lblEndDate]) {
        currentLabel.text = [self getDateStringFromDate:sender.date];
    }
    
    else {
        currentLabel.text = [self getTimeStringFromDate:sender.date];
    }
}

- (IBAction)onChangeSwitch:(UISwitch *)sender {
    
}

- (IBAction)onTapNextBtn:(id)sender {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.selectedWeekdays = selectedWeeks;
    delegate.selectedStartDate = _lblStartDate.text;
    delegate.selectedEndDate = _lblEndDate.text;
    
    FamilyRateViewController *familyRateVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FamilyRateViewController"];
    
    [self.navigationController pushViewController:familyRateVC animated:YES];
}

- (IBAction)onTapBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onTapDoneBtn:(id)sender {
    [self hideDatePicker];
    
    selectedStartDate = _lblStartDate.text;
    selectedEndDate = _lblEndDate.text;
    selectedStartTime = _lblStartTime.text;
    selectedEndTime = _lblEndTime.text;
}
- (IBAction)onTapCancelBtn:(id)sender {
    [self hideDatePicker];
    
    _lblStartDate.text = selectedStartDate;
    _lblEndDate.text = selectedEndDate;
    _lblStartTime.text = selectedStartTime;
    _lblEndTime.text = selectedEndTime;
}

- (NSString*)getDateStringFromDate:(NSDate*)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM.dd.yyyy"];
    NSString *theDate = [dateFormat stringFromDate:date];
    
    return theDate;
}

- (NSDate*)getDateFromString:(NSString*)dateString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM.dd.yyyy"];
    NSDate *date = [dateFormat dateFromString:dateString];
    
    return date;
}

- (NSString*)getTimeStringFromDate:(NSDate*)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"h:mm a"];
    NSString *theDate = [dateFormat stringFromDate:date];
    
    return theDate;
}

- (NSDate*)getTimefromString:(NSString *)timeString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"h:mm a"];
    NSDate* date = [dateFormat dateFromString:timeString];
    
    return date;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
