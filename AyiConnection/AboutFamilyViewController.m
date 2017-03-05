//
//  AboutFamilyViewController.m
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "AboutFamilyViewController.h"
#import "FamilyLookForViewController.h"
#import "VSDropdown.h"
#import "LanguageSelectViewController.h"

#define kNEXT_TOP_SPACE_IPHONE5     5
#define kNEXT_TOP_SPACE_IPHONE6     60

@interface AboutFamilyViewController ()<UITextFieldDelegate, VSDropdownDelegate>

@end

@implementation AboutFamilyViewController {
    UITextField *currentText;
    NSMutableArray *languages;
    
//    NSMutableArray *selectedLangauges;
//    
//    NSMutableArray *autoLanguageArray;
//    VSDropdown *languageDropDown;
    
    
    NSMutableArray *states;
    NSMutableArray *cities;
    
    NSString *selectedState;
    NSString *selectedCity;
    NSInteger selectedCityIndex;
    
    NSMutableArray *autoStateArray;
    NSMutableArray *autoCityArray;
    
    VSDropdown *stateDropDown;
    VSDropdown *cityDropDown;
}

@synthesize btnNext;
@synthesize lblName;
@synthesize txtPrefferName;
@synthesize segSex;
@synthesize lblLanguage;
@synthesize txtPhone;
@synthesize scrollView;
@synthesize selectedLangauges;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self getAllStates];
//    [self getAllStates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    User *user = delegate.currentUser;
    
    lblName.text = [NSString stringWithFormat:@"%@ %@", user.first_name, user.last_name];
    txtPrefferName.text = user.username;
    
    btnNext.layer.borderColor = MAIN_COLOR.CGColor;
    btnNext.layer.borderWidth = 1.5;
    btnNext.clipsToBounds = YES;
    btnNext.layer.cornerRadius = 8;
    
    _imgPhoto.clipsToBounds = YES;
    _imgPhoto.layer.cornerRadius = _imgPhoto.frame.size.height/2;
    
    txtPrefferName.delegate = self;
    txtPhone.delegate = self;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapped:)];
    [self.scrollView addGestureRecognizer:tapGes];
    
//    languageDropDown = [[VSDropdown alloc] initWithDelegate:self];
//    [languageDropDown setAdoptParentTheme:YES];
//    [languageDropDown setShouldSortItems:NO];
    
    stateDropDown = [[VSDropdown alloc] initWithDelegate:self];
    [stateDropDown setAdoptParentTheme:YES];
    [stateDropDown setShouldSortItems:NO];
    
    cityDropDown = [[VSDropdown alloc] initWithDelegate:self];
    [cityDropDown setAdoptParentTheme:YES];
    [cityDropDown setShouldSortItems:NO];
    
//    autoLanguageArray = [[NSMutableArray alloc] init];
    selectedLangauges = [[NSMutableArray alloc] init];
    languages = [[NSMutableArray alloc] init];
    
    NSMutableArray *languageArray = [delegate.languages mutableCopy];
    
    for (Language *content in languageArray) {
        [languages addObject:content.name];
    }
}

- (void)Tapped:(UITapGestureRecognizer*)gesture {
    [currentText resignFirstResponder];
    [self.view endEditing:YES];
}

-(void)showDropDownFor:(UIView *)sender dropDown:(VSDropdown*)dropDown adContents:(NSArray *)contents selectedString:(NSString*)selectedString
{
    
    [dropDown setDrodownAnimation:rand()%2];
    
    [dropDown setAllowMultipleSelection:NO];
    
    [dropDown setupDropdownForView:sender];
    
    [dropDown setSeparatorColor:[UIColor blackColor]];
    
    if (selectedString == nil) {
        selectedString = @"";
    }
    
    [dropDown reloadDropdownWithContents:contents andSelectedItems:@[selectedString]];
    
}

#pragma mark - Keyboard Hide/Show
- (void)keyboardWillShow:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, currentText.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, currentText.frame.origin.y-keyboardSize.height);
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
}

#pragma mark - VSDropdown Delegate
- (void)dropdown:(VSDropdown *)dropDown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected
{
//    if ([dropDown isEqual:languageDropDown]) {
//        [selectedLangauges addObject:str];
//        
//        txtLanguage.text = selectedLangauges.firstObject;
//        for (int i = 1; i < [selectedLangauges count]; i ++) {
//            
//            txtLanguage.text = [NSString stringWithFormat:@"%@, %@", txtLanguage.text, [selectedLangauges objectAtIndex:i]];
//            
//        }
//        
//        txtLanguage.text = [NSString stringWithFormat:@"%@, ", txtLanguage.text];
//    }
    if ([dropDown isEqual:stateDropDown]) {
        _lblState.text = str;
        selectedState = str;
        
        if (index == 0) {
            _lblCity.text = [autoCityArray firstObject];
            [autoCityArray removeAllObjects];
            
            return;
        }
        
        [self getAllCityForState];
    }
    if ([dropDown isEqual:cityDropDown]) {
        _lblCity.text = str;
        selectedCity = str;
        selectedCityIndex = index;
    }
}

- (UIColor *)outlineColorForDropdown:(VSDropdown *)dropdown
{
    return [UIColor blackColor];
}

- (CGFloat)outlineWidthForDropdown:(VSDropdown *)dropdown
{
    return 2.0;
}

- (CGFloat)cornerRadiusForDropdown:(VSDropdown *)dropdown
{
    return 3.0;
}

- (CGFloat)offsetForDropdown:(VSDropdown *)dropdown
{
    return -2.0;
}

#pragma mark - Action
- (IBAction)onTapLanguageBtn:(id)sender {
    LanguageSelectViewController *languageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LanguageSelectViewController"];
    
    languageVC.languages = [languages mutableCopy];
    languageVC.selectedLanguages = [selectedLangauges mutableCopy];
    languageVC.delegate = self;
    
    [self presentViewController:languageVC animated:YES completion:nil];
}

- (IBAction)onChangeSex:(id)sender {
    
}

- (IBAction)onTapPhotoBtn:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Take a Photo" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openLibrary];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    
    [alert addAction:camera];
    [alert addAction:photo];
    [alert addAction:cancel];
    
    [alert.view setTintColor:ALERT_COLOR];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)onTapNextBtn:(id)sender {

    [self showPhoneVerifyMessage];
    
//    ProfileBody *requestBody = [self getProfileUpdateParam];
//    
//    NSLog(@"Request Body : %@", requestBody.username);
//    NSLog(@"Preffered Text : %@", txtPrefferName.text);
//    
//    requestBody.username = txtPrefferName.text;
//    requestBody.phone = txtPhone.text;
//    requestBody.gender = [NSNumber numberWithInteger:segSex.selectedSegmentIndex];
//    City *city = [autoCityArray objectAtIndex:selectedCity];
//    requestBody.location = city.city_id;
//    UIImage *image = _imgPhoto.image;
//    NSData *imageData = UIImagePNGRepresentation(image);
//    requestBody.photo = imageData;
//    
//    requestBody.languages = [NSArray arrayWithObjects:[NSNumber numberWithInteger:1], [NSNumber numberWithInteger:2], nil];
//    
//    NSNumber *userType = [NSNumber numberWithInteger:0];
//    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    
//    [self performRestPost:UPDATE_USER_PROFILE withParamaters:@[userType, requestBody, imageData]];
    
}

- (void)showPhoneVerifyMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_PHONE_VERIFY_", nil)] message:[NSString stringWithFormat:NSLocalizedString(@"_VERIFY_MESSAGE_", nil)] preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"";
        textField.textColor = [UIColor colorWithRed:77.0/255.0 green:77/255 blue:77/255 alpha:1.0];
        textField.layer.borderColor = [UIColor colorWithRed:77.0/255.0 green:77/255 blue:77/255 alpha:0.78].CGColor;
        textField.layer.borderWidth = 1;
        [textField setBorderStyle:UITextBorderStyleNone];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_CANCEL_", nil)] style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *verify = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_VERIFY_", nil)] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray *textFeilds = alert.textFields;
        UITextField *txtVerify = textFeilds.firstObject;
        
        [self sendVerifyCode:txtVerify.text];
    }];
    
    [alert addAction:cancel];
    [alert addAction:verify];
    
    alert.view.tintColor = ALERT_COLOR;
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)sendVerifyCode:(NSString*)code {
    if ([code isEqualToString:@""]) {
        [self showErrorMsg:[NSString stringWithFormat:NSLocalizedString(@"_VERIFY_ERROR_", nil)]];
        return;
    }
    
    FamilyLookForViewController *familyLookForVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FamilyLookForViewController"];
    
    [self.navigationController pushViewController:familyLookForVC animated:YES];
}

- (IBAction)onTapStateBtn:(id)sender {
    [self showDropDownFor:_lblState dropDown:stateDropDown adContents:autoStateArray selectedString:selectedState];
}

- (IBAction)ontapCityBtn:(id)sender {
    [self showDropDownFor:_lblCity dropDown:cityDropDown adContents:autoCityArray selectedString:selectedCity];
}


- (void)openCamera {
    UIImagePickerController *imgPickerController = [[UIImagePickerController alloc]init];
    
    imgPickerController.delegate = self;
    imgPickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imgPickerController animated:YES completion:nil];
}

- (void)openLibrary {
    UIImagePickerController *imgPickerController = [[UIImagePickerController alloc]init];
    
    imgPickerController.delegate = self;
    imgPickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imgPickerController animated:YES completion:nil];
}

#pragma mark - Image Pickter Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    _imgPhoto.image = (UIImage*)[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextFeild Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:txtPrefferName]) {
        [txtPhone becomeFirstResponder];
    }
    else if ([textField isEqual:txtPhone]) {
        [txtPhone resignFirstResponder];
        [self.view endEditing:YES];
        
        currentText = nil;
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentText = textField;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)showErrorMsg:(NSString*)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_OK_", nil)] style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:ok];
    
    alert.view.tintColor = ALERT_COLOR;
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)actionAfterSuccessfulAnswerToRestConnection:(connectionType)connection WithResult:(NSArray *)mappingResult {
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    switch (connection) {
        case ERROR:
        {
            [self showErrorMsg:[NSString stringWithFormat:NSLocalizedString(@"_ERROR_", nil)]];
            break;
        }
        case UPDATE_USER_PROFILE:
        {
            for (User *user in mappingResult) {
                if ([user isKindOfClass:[User class]]) {
                    delegate.currentUser = user;

                    FamilyLookForViewController *familyLookForVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FamilyLookForViewController"];
                    
                    [self.navigationController pushViewController:familyLookForVC animated:YES];

                }
            }
            break;
        }
        case GET_ALL_LANGUAGES:
        {
            languages = [[NSMutableArray alloc] init];
            for (Language *language in mappingResult) {
                if ([language isKindOfClass:[Language class]]) {
                    [languages addObject:language.name];
                }
            }
            
            [self getAllStates];
            
            break;
        }
        case GET_ALL_STATES:
        {
            states = [[NSMutableArray alloc] init];
            autoStateArray = [[NSMutableArray alloc] init];
            [autoStateArray addObject:@"All State"];
            for (State *state in mappingResult) {
                if ([state isKindOfClass:[State class]]) {
                    [states addObject:state];
                    [autoStateArray addObject:state.name];
                }
            }
            
            break;
        }
        case GET_ALL_CITY_FOR_STATE:
        {
            [cities removeAllObjects];
            cities = [NSMutableArray new];
            
            [autoCityArray removeAllObjects];
            autoCityArray = [NSMutableArray new];
            
            for (City *city in mappingResult) {
                if ([city isKindOfClass:[City class]]) {
                    [cities addObject:city];
                    [autoCityArray addObject:city.city_name];
                }
            }
        }
        default:
            break;
    }
}

- (void)getAllLanguages {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    BasicBody *request = [[BasicBody alloc] init];
    request.access_token = delegate.accessToken;
    
    [self performRestPost:GET_ALL_LANGUAGES withParamaters:@[request]];
}

- (void)getAllStates {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    BasicBody *request = [[BasicBody alloc] init];
    request.access_token = delegate.accessToken;
    request.lang = @"en";
    
    [self performRestPost:GET_ALL_STATES withParamaters:@[request]];
}

- (void)getAllCityForState {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    BasicBody *request = [[BasicBody alloc] init];
    request.access_token = delegate.accessToken;
    request.lang = @"en";
    request.state_code = selectedState;
    
    [self performRestPost:GET_ALL_CITY_FOR_STATE withParamaters:@[request]];
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

@end
