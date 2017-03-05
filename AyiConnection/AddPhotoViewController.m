//
//  AddPhotoViewController.m
//  AyiConnection
//
//  Created by JCB on 2/21/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "AddPhotoViewController.h"


#define kAddTopSpace_IPHONE5    10
#define kAddTopSpace_IPHONE6    70

@interface AddPhotoViewController ()

@end

@implementation AddPhotoViewController
@synthesize btnAddPhoto;
@synthesize addPhotoTopSpace;

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
    btnAddPhoto.layer.borderColor = MAIN_COLOR.CGColor;
    btnAddPhoto.layer.borderWidth = 1.5;
    btnAddPhoto.clipsToBounds = YES;
    btnAddPhoto.layer.cornerRadius = 8;
    
    if (IS_IPHONE_5_OR_LESS) {
        addPhotoTopSpace.constant = kAddTopSpace_IPHONE5;
    }
    else {
        addPhotoTopSpace.constant = kAddTopSpace_IPHONE6;
    }
}


#pragma mark - Action

- (IBAction)onTapAddPhotoBtn:(id)sender {
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

- (IBAction)onTapBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    delegate.provider_image = (UIImage*)[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    UIStoryboard *profileSetupStory = [UIStoryboard storyboardWithName:@"ProfileSetup" bundle:nil];
    
    UINavigationController *providerProfileSetupNavi = [profileSetupStory instantiateViewControllerWithIdentifier:@"ProviderProfileSetupNavi"];
    
    delegate.window.rootViewController = providerProfileSetupNavi;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
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
