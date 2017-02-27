//
//  FamilyChildNumViewController.m
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "FamilyChildNumViewController.h"
#import "FamilyWhenCareViewController.h"

@implementation FamilyChildCell

@end

@interface FamilyChildNumViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation FamilyChildNumViewController {
    NSInteger childNum;
}
@synthesize btnNext;
@synthesize lblChildNum;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    childNum = 1;
    lblChildNum.text = [NSString stringWithFormat:@"%d", childNum];
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

- (IBAction)onTapMinusChildNumBtn:(id)sender {
    childNum --;
    lblChildNum.text = [NSString stringWithFormat:@"%d", childNum];
    [_tableView reloadData];
}

- (IBAction)onTapPlusChildNumBtn:(id)sender {
    childNum ++;
    lblChildNum.text = [NSString stringWithFormat:@"%d", childNum];
    [_tableView reloadData];
}

- (IBAction)onTapNextBtn:(id)sender {
    FamilyWhenCareViewController *familyWhenCareVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FamilyWhenCareViewController"];
    
    [self.navigationController pushViewController:familyWhenCareVC animated:YES];
}

- (IBAction)onTapBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleteChild:(UIButton*)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    childNum --;
    
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    lblChildNum.text = [NSString stringWithFormat:@"%d", childNum];
    [_tableView reloadData];
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return childNum;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FamilyChildCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FamilyChildCell" forIndexPath:indexPath];
    
    NSLog(@"Section : %d", indexPath.section);
    cell.btnDelete.tag = indexPath.row;
    [cell.btnDelete addTarget:self action:@selector(deleteChild:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
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
