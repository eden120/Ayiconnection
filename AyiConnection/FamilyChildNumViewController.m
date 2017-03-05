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

@implementation ChildObj

@end

@interface FamilyChildNumViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@end

@implementation FamilyChildNumViewController {
    NSInteger childNum;
    NSMutableArray *childArray;
}
@synthesize btnNext;
@synthesize lblChildNum;

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
    
    childNum = 1;
    lblChildNum.text = [NSString stringWithFormat:@"%d", childNum];
    
    childArray = [[NSMutableArray alloc] init];
    
    ChildObj *initObj = [[ChildObj alloc] init];
    
    [childArray addObject:initObj];
}

#pragma mark - Action

- (IBAction)onTapMinusChildNumBtn:(id)sender {
    [self.view endEditing:YES];
    
    if ([childArray count] > 0) {
        [childArray removeLastObject];
        
        childNum = [childArray count];
        lblChildNum.text = [NSString stringWithFormat:@"%d", childNum];
        
        [_tableView reloadData];
    }
}

- (IBAction)onTapPlusChildNumBtn:(id)sender {
    [self.view endEditing:YES];
    
    ChildObj *initObj = [[ChildObj alloc] init];
    [childArray addObject:initObj];
    
    childNum = [childArray count];
    lblChildNum.text = [NSString stringWithFormat:@"%d", childNum];
    
    [_tableView reloadData];
}

- (IBAction)onTapNextBtn:(id)sender {
    [self.view endEditing:YES];
    
    FamilyWhenCareViewController *familyWhenCareVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FamilyWhenCareViewController"];
    
    [self.navigationController pushViewController:familyWhenCareVC animated:YES];
}

- (IBAction)onTapBackBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleteChild:(UIButton*)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    [childArray removeObjectAtIndex:sender.tag];
    childNum = [childArray count];
    
    
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    childNum = [childArray count];
    lblChildNum.text = [NSString stringWithFormat:@"%d", childNum];
    [_tableView reloadData];
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [childArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FamilyChildCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FamilyChildCell" forIndexPath:indexPath];
    
    NSLog(@"Section : %d", indexPath.section);
    
    cell.lblChildIndex.text = [NSString stringWithFormat:@"Child %d", indexPath.row + 1];
    cell.btnDelete.tag = indexPath.row;
    [cell.btnDelete addTarget:self action:@selector(deleteChild:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.txtChildName.tag = indexPath.row;
    cell.txtAge.tag = indexPath.row;
    cell.txtChildName.delegate = self;
    cell.txtAge.delegate = self;
    cell.segSex.tag = indexPath.row;
    [cell.segSex addTarget:self action:@selector(onChanged:) forControlEvents:UIControlEventValueChanged];
    
    ChildObj *child = [childArray objectAtIndex:indexPath.row];
    
    cell.txtChildName.text = child.childName;
    cell.txtAge.text = child.childAge;
    if (child.isBoy) {
        cell.segSex.selectedSegmentIndex = 0;
    }
    else {
        cell.segSex.selectedSegmentIndex = 1;
    }
    
    return cell;
}


-(void)textFieldDidEndEditing:(UITextField *)textField {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
    FamilyChildCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    
    ChildObj *child = [childArray objectAtIndex:textField.tag];
    
    child.childName = cell.txtChildName.text;
    child.childAge = cell.txtAge.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    
    return YES;
}

- (void)onChanged:(UISegmentedControl*)sender {
    [self.view endEditing:YES];
    
    
    ChildObj *child = [childArray objectAtIndex:sender.tag];
    
    if (sender.selectedSegmentIndex == 0) {
        child.isBoy = YES;
    }
    else {
        child.isBoy = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
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
