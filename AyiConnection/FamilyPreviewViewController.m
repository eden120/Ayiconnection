//
//  FamilyPreviewViewController.m
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "FamilyPreviewViewController.h"

@interface FamilyPreviewViewController ()

@end

@implementation FamilyPreviewViewController
@synthesize btnPost;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    
    btnPost.clipsToBounds = YES;
    btnPost.layer.cornerRadius = 8;
    
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    _lblTitle.text = _jobTitle;
    _lblComment.text = self.comment;
    _lblRate.text = [NSString stringWithFormat:@"$%@", _rate];
    
    NSMutableArray *languageArray = [delegate.selectedLanguages mutableCopy];
    _lblLanguage.text = (NSString*)[languageArray firstObject];
    for (int i = 1; i < [languageArray count]; i ++) {
        NSString *str = (NSString*)[languageArray objectAtIndex:i];
        
        _lblLanguage.text = [NSString stringWithFormat:@"%@, %@", _lblLanguage.text, str];
    }
    
    [_lblLanguage sizeToFit];
    
    
    NSMutableArray *weekViewArray = [NSMutableArray arrayWithObjects:_btnMon, _btnTue, _btnWed, _btnThu, _btnFri, _btnSat, _btnSun, nil];
    
    for (UIButton *btn in weekViewArray) {
        btn.hidden = YES;
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = MAIN_COLOR.CGColor;
        btn.layer.borderWidth = 1;
    }
    
    NSMutableArray *strWeeks = [NSMutableArray arrayWithObjects:@"mo", @"tu", @"we", @"th", @"fr", @"sa", @"su", nil];
    NSMutableArray *selectedWeeks = [delegate.selectedWeekdays mutableCopy];
    
    for (NSString *str in selectedWeeks) {
        for (int i = 0; i < [strWeeks count]; i++) {
            NSString *week = [strWeeks objectAtIndex:i];
            if ([str isEqualToString:week]) {
                UIButton *btn = [weekViewArray objectAtIndex:i];
                btn.hidden = NO;
            }
        }
    }
    
    NSMutableArray *responseImages = [NSMutableArray arrayWithObjects:_imgInfant, _imgYoungBaby, _imgToddler, _imgPreschooler, _imgGradschooler, _imgsimplehouse, _imgLaundry, _imgpremeal, _imgCookmeal, _imgRunerrand, nil];
    NSMutableArray *responseLabels = [NSMutableArray arrayWithObjects:_lblInfant, _lblYoungBaby, _lblToddler, _lblPreschooler, _lblGradschooler, _lblSimplehouse, _lblLaundry, _lblPremeal, _lblCookmeal, _iblRunerrand, nil];
    
    for (int i = 0; i < [responseImages count]; i ++) {
        UIImageView *imageView = [responseImages objectAtIndex:i];
        [self setImage:imageView isSelected:NO];
    }
    
    NSMutableArray *responseTitles = [NSMutableArray arrayWithObjects:@"infant", @"young baby", @"toddler", @"preschooler", @"gradeschooler", @"simple housework", @"laundry", @"prep meal", @"cook meal", @"run errands", @"special needs", nil];
    NSMutableArray *selectedResoponse = [delegate.selectedResp mutableCopy];
    
    for (NSString *str in selectedResoponse) {
        for (int i = 0; i < [responseTitles count]; i ++) {
            NSString *response = [responseTitles objectAtIndex:i];
            if ([str isEqualToString:response]) {
                UIImageView *imageView = [responseImages objectAtIndex:i];
                [self setImage:imageView isSelected:YES];
            }
        }
    }
    
    _lblStartDate.text = delegate.selectedStartDate;
    _lblEnddate.text = delegate.selectedEndDate;
}

- (void)setImage:(UIImageView*)imageView isSelected:(BOOL)isSelected {
    if ([imageView isEqual:_imgInfant]) {
        if (isSelected) {
            imageView.image = [UIImage imageNamed:@"infant_click.png"];
            _lblInfant.textColor = RESPONSE_SELECTED_COLOR;
        }
        else {
            imageView.image = [UIImage imageNamed:@"infant_unclick.png"];
            _lblInfant.textColor = RESPONSE_UNSELECTED_COLOR;
        }
    }
    else if ([imageView isEqual:_imgYoungBaby]) {
        if (isSelected) {
            imageView.image = [UIImage imageNamed:@"youngbaby_click.png"];
            _lblYoungBaby.textColor = RESPONSE_SELECTED_COLOR;
        }
        else {
            imageView.image = [UIImage imageNamed:@"youngbaby_unclick.png"];
            _lblYoungBaby.textColor = RESPONSE_UNSELECTED_COLOR;
        }
        
    }
    else if ([imageView isEqual:_imgToddler]) {
        if (isSelected) {
            imageView.image = [UIImage imageNamed:@"toddler_click.png"];
            _lblToddler.textColor = RESPONSE_SELECTED_COLOR;
        }
        else {
            imageView.image = [UIImage imageNamed:@"toddler_unclick.png"];
            _lblToddler.textColor = RESPONSE_UNSELECTED_COLOR;
        }
    }
    else if ([imageView isEqual:_imgPreschooler]) {
        if (isSelected) {
            imageView.image = [UIImage imageNamed:@"prescholler_click.png"];
            _lblPreschooler.textColor = RESPONSE_SELECTED_COLOR;
        }
        else {
            imageView.image = [UIImage imageNamed:@"prescholler_unclick.png"];
            _lblPreschooler.textColor = RESPONSE_UNSELECTED_COLOR;
        }
    }
    else if ([imageView isEqual:_imgGradschooler]) {
        if (isSelected) {
            imageView.image = [UIImage imageNamed:@"gradeschooller_click.png"];
            _lblGradschooler.textColor = RESPONSE_SELECTED_COLOR;
        }
        else {
            imageView.image = [UIImage imageNamed:@"gradeschooller_unclick.png"];
            _lblGradschooler.textColor = RESPONSE_UNSELECTED_COLOR;
        }
    }
    else if ([imageView isEqual:_imgsimplehouse]) {
        if (isSelected) {
            imageView.image = [UIImage imageNamed:@"homecare_click.png"];
            _lblSimplehouse.textColor = RESPONSE_SELECTED_COLOR;
        }
        else {
            imageView.image = [UIImage imageNamed:@"homecare_unclick.png"];
            _lblSimplehouse.textColor = RESPONSE_UNSELECTED_COLOR;
        }
    }
    else if ([imageView isEqual:_imgLaundry]) {
        if (isSelected) {
            imageView.image = [UIImage imageNamed:@"laundry_click.png"];
            _lblLaundry.textColor = RESPONSE_SELECTED_COLOR;
        }
        else {
            imageView.image = [UIImage imageNamed:@"laundry_unclick.png"];
            _lblLaundry.textColor = RESPONSE_UNSELECTED_COLOR;
        }
    }
    else if ([imageView isEqual:_imgpremeal]) {
        if (isSelected) {
            imageView.image = [UIImage imageNamed:@"prepmeal_click.png"];
            _lblPremeal.textColor = RESPONSE_SELECTED_COLOR;
        }
        else {
            imageView.image = [UIImage imageNamed:@"prepmeal_unclick.png"];
            _lblPremeal.textColor = RESPONSE_UNSELECTED_COLOR;
        }
    }
    else if ([imageView isEqual:_imgCookmeal]) {
        if (isSelected) {
            imageView.image = [UIImage imageNamed:@"cookmeal_click.png"];
            _lblCookmeal.textColor = RESPONSE_SELECTED_COLOR;
        }
        else {
            imageView.image = [UIImage imageNamed:@"cookmeal_unclick.png"];
            _lblCookmeal.textColor = RESPONSE_UNSELECTED_COLOR;
        }
    }
    else if ([imageView isEqual:_imgRunerrand]) {
        if (isSelected) {
            imageView.image = [UIImage imageNamed:@"runerrands_click.png"];
            _iblRunerrand.textColor = RESPONSE_SELECTED_COLOR;
        }
        else {
            imageView.image = [UIImage imageNamed:@"runerrand_unclick.png"];
            _iblRunerrand.textColor = RESPONSE_UNSELECTED_COLOR;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)onTapPostBtn:(id)sender {

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
