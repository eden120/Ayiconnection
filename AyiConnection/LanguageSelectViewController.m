//
//  LanguageSelectViewController.m
//  AyiConnection
//
//  Created by JCB on 3/3/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "LanguageSelectViewController.h"

#define kCollection_LeftSpace   30
#define kAlginSpace         10

@implementation LanguageCell

@end

@interface LanguageSelectViewController ()

@end

@implementation LanguageSelectViewController
@synthesize languages;
@synthesize selectedLanguages;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    selectedLanguages = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [languages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LanguageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LanguageCell" forIndexPath:indexPath];
    
    [cell.btnCheck setImage:[UIImage imageNamed:@"uncheck_box.png"] forState:UIControlStateNormal];
    [cell.btnCheck setImage:[UIImage imageNamed:@"check_box.png"] forState:UIControlStateSelected];
    cell.btnCheck.tag = indexPath.row;
    cell.btnCheck.selected = NO;
    
    [cell.btnCheck addTarget:self action:@selector(selectLanguage:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *str = (NSString *)[languages objectAtIndex:indexPath.row];
    
    for (NSString *language in selectedLanguages) {
        if ([str isEqualToString:language]) {
            cell.btnCheck.selected = YES;
        }
    }
    
    cell.lblName.text = str;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat cellWidth = (width - 2 * kCollection_LeftSpace - kAlginSpace * 4) / 2;
    
    return CGSizeMake(cellWidth, 80);
    
}

- (void)selectLanguage:(UIButton*)sender {
    sender.selected = !sender.selected;
    NSString *language = (NSString*)[languages objectAtIndex:sender.tag];
    if (sender.selected) {
        [selectedLanguages addObject:language];
    }
    else {
        for (NSString *str in selectedLanguages) {
            if ([str isEqualToString:language]) {
                [selectedLanguages removeObject:str];
            }
        }
    }
}

- (IBAction)onTapCancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTapOkBtn:(id)sender {
    [_delegate selectLanguages:selectedLanguages];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
