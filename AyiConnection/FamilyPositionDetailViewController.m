//
//  FamilyPositionDetailViewController.m
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "FamilyPositionDetailViewController.h"
#import "FamilyResponsibilityViewController.h"

#define kROW_HEIGHT_IPHONE5    45
#define kROW_HEIGHT_IPHONE6    55


@interface FamilyPositionDetailViewController ()

@end

@implementation FamilyPositionDetailViewController {
    NSMutableArray *languages;
}
@synthesize btnNext;
@synthesize lblLanguage;
@synthesize selectedLangauges;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
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

    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    selectedLangauges = [[NSMutableArray alloc] init];
    languages = [[NSMutableArray alloc] init];
    
    NSMutableArray *languageArray = [delegate.languages mutableCopy];
    
    for (Language *content in languageArray) {
        if ([[content.name lowercaseString] isEqualToString:@"english"]) {
            continue;
        }
        
        [languages addObject:content.name];
    }
}

#pragma mark - Action
- (IBAction)onChangeSegment:(UISegmentedControl *)sender {
    
}

- (IBAction)onTapLanguageBtn:(id)sender {
    LanguageSelectViewController *languageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LanguageSelectViewController"];
    
    languageVC.languages = [languages mutableCopy];
    languageVC.selectedLanguages = [selectedLangauges mutableCopy];
    languageVC.delegate = self;
    
    [self presentViewController:languageVC animated:YES completion:nil];
}

- (IBAction)onChangeSwitch:(UISwitch *)sender {
}

- (IBAction)onTapNextBtn:(id)sender {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.selectedLanguages = [self.selectedLangauges mutableCopy];
    
    FamilyResponsibilityViewController *familyReponsibilityVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FamilyResponsibilityViewController"];
    
    [self.navigationController pushViewController:familyReponsibilityVC animated:YES];
}

- (IBAction)onTapBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Language Protocol

- (void)selectLanguages:(NSMutableArray *)languageArray {
    self.selectedLangauges = [languageArray mutableCopy];
    
    if ([languageArray count] == 0) {
        
        return;
    }
    
    lblLanguage.text = (NSString*)[languageArray firstObject];
    for (int i = 1; i < [languageArray count]; i ++) {
        NSString *str = (NSString*)[languageArray objectAtIndex:i];
        
        lblLanguage.text = [NSString stringWithFormat:@"%@, %@", lblLanguage.text, str];
    }
    
    [lblLanguage sizeToFit];
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
