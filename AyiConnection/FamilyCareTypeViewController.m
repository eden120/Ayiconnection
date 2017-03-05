//
//  FamilyCareTypeViewController.m
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "FamilyCareTypeViewController.h"
#import "FamilyPositionDetailViewController.h"

@implementation CareTypeCell

@end

@interface FamilyCareTypeViewController ()<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *childCareArray;
    NSMutableArray *seniorCareArray;
    NSMutableArray *homeCareArray;
    NSMutableArray *tutorArray;
    
    NSMutableArray *selectedArray;
}

@end

@implementation FamilyCareTypeViewController
@synthesize btnNext;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    childCareArray = [NSMutableArray arrayWithObjects:@"Nanny/Babysitter", @"Maternity Care", @"At Home Daycare", nil];
    seniorCareArray = [NSMutableArray arrayWithObjects:@"Companion Care", @"Personal Care", nil];
    homeCareArray = [NSMutableArray arrayWithObjects:@"Meal Preperation/Cooking", @"House Cleaning", nil];
    tutorArray = [NSMutableArray arrayWithObjects:@"Homework Supervision", @"Language Study", nil];
    
    NSString *str = @"What Type of %@?";
    
    switch (_careType) {
        case ChildCare:
            selectedArray = [childCareArray mutableCopy];
            str = [NSString stringWithFormat:str, @"Child Care"];
            break;
        case SeniorCare:
            selectedArray = [seniorCareArray mutableCopy];
            str = [NSString stringWithFormat:str, @"Senior Care"];
            break;
        case HomeCare:
            selectedArray = [homeCareArray mutableCopy];
            str = [NSString stringWithFormat:str, @"Home Care"];
            break;
        case Tutor:
            selectedArray = [tutorArray mutableCopy];
            str = [NSString stringWithFormat:str, @"Tutor"];
            break;
        default:
            break;
    }
    
    self.topTitle.text = str;
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self setupUI];
}

- (void)setupUI {
    btnNext.layer.borderColor = MAIN_COLOR.CGColor;
    btnNext.layer.borderWidth = 1.5;
    btnNext.clipsToBounds = YES;
    btnNext.layer.cornerRadius = 8;
}

#pragma mark - Action
- (IBAction)onChangedSwitch:(UISwitch *)sender {
}

- (IBAction)onTapNextBtn:(id)sender {
    FamilyPositionDetailViewController *familyPositionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FamilyPositionDetailViewController"];
    
    [self.navigationController pushViewController:familyPositionVC animated:YES];
}

- (IBAction)onTapBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [selectedArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CareTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CareTypeCell" forIndexPath:indexPath];
    
    cell.lblCaretype.text = (NSString*)[selectedArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
