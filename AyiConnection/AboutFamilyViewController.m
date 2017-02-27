//
//  AboutFamilyViewController.m
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "AboutFamilyViewController.h"
#import "FamilyLookForViewController.h"

#define kNEXT_TOP_SPACE_IPHONE5     5
#define kNEXT_TOP_SPACE_IPHONE6     60

@interface AboutFamilyViewController ()<UITextFieldDelegate>

@end

@implementation AboutFamilyViewController {
    UITextField *currentText;
}
@synthesize btnNext;
@synthesize consNextTopSpace;
@synthesize lblName;
@synthesize txtPrefferName;
@synthesize segSex;
@synthesize txtLanguage;
@synthesize txtLocation;
@synthesize txtPhone;
@synthesize scrollView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
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
    _imgPhoto.layer.cornerRadius = 50;
    
    if (IS_IPHONE_5_OR_LESS) {
        consNextTopSpace.constant = kNEXT_TOP_SPACE_IPHONE5;
    }
    else {
        consNextTopSpace.constant = kNEXT_TOP_SPACE_IPHONE6;
    }
    
    txtPrefferName.delegate = self;
    txtLanguage.delegate = self;
    txtLocation.delegate = self;
    txtPhone.delegate = self;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapped:)];
    [self.scrollView addGestureRecognizer:tapGes];
}

- (void)Tapped:(UITapGestureRecognizer*)gesture {
    [currentText resignFirstResponder];
    [self.view endEditing:YES];
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

#pragma mark - Action
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
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:camera];
    [alert addAction:photo];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)onTapNextBtn:(id)sender {
    
    ProfileBody *requestBody = [self getProfileUpdateParam];
    
    requestBody.username = txtPrefferName.text;
    requestBody.phone = txtPhone.text;
    requestBody.gender = [NSNumber numberWithInteger:segSex.selectedSegmentIndex];
    
    NSNumber *userType = [NSNumber numberWithInteger:0];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self performRestPost:UPDATE_USER_PROFILE withParamaters:@[userType, requestBody]];
    
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

#pragma mark - TextFeild Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:txtPrefferName]) {
        [txtLanguage becomeFirstResponder];
    }
    else if ([textField isEqual:txtLanguage]) {
        [txtLocation becomeFirstResponder];
    }
    else if ([textField isEqual:txtLocation]) {
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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"_OK_", nil)] style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:ok];
    
    alert.view.tintColor = MAIN_COLOR;
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)actionAfterSuccessfulAnswerToRestConnection:(connectionType)connection WithResult:(NSArray *)mappingResult {
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    switch (connection) {
        case ERROR:
        {
            [self showErrorMsg:@"Error"];
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
        default:
            break;
    }
}

@end
