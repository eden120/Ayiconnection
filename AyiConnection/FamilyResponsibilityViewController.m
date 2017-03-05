//
//  FamilyResponsibilityViewController.m
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "FamilyResponsibilityViewController.h"
#import "FamilyChildNumViewController.h"

@interface FamilyResponsibilityViewController ()

@end

@implementation FamilyResponsibilityViewController {
    NSMutableArray *swArray;
    NSMutableArray *selectedResponse;
}
@synthesize btnNext;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    swArray = [NSMutableArray arrayWithObjects:@"infant", @"young baby", @"toddler", @"preschooler", @"gradeschooler", @"simple housework", @"laundry", @"prep meal", @"cook meal", @"run errands", @"special needs", nil];
    
    selectedResponse = [[NSMutableArray alloc] init];
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
}

#pragma mark - Action

- (IBAction)onChangeSwitch:(UISwitch *)sender {
    NSString *selectedStr = [swArray objectAtIndex:sender.tag];
    if (sender.isOn) {
        [selectedResponse addObject:selectedStr];
    }
    else {
        NSMutableArray *temp = [selectedResponse mutableCopy];
        
        for (NSString *str in temp) {
            if ([str isEqualToString:selectedStr]) {
                [selectedResponse removeObject:str];
            }
        }
    }
}

- (IBAction)onTapNextBtn:(id)sender {
    if ([selectedResponse count] > 0) {
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] init];
        delegate.selectedResp = [selectedResponse mutableCopy];
    }
    
    FamilyChildNumViewController *familyChildNumVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FamilyChildNumViewController"];
    
    [self.navigationController pushViewController:familyChildNumVC animated:YES];
}

- (IBAction)onTapBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
