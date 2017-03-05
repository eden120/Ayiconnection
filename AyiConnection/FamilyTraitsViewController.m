//
//  FamilyTraitsViewController.m
//  AyiConnection
//
//  Created by JCB on 2/22/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "FamilyTraitsViewController.h"
#import "FamilyAddTitleViewController.h"

#define kCellHeight         43
#define kLabelHeight        32

@implementation TraitCell

@end

@interface FamilyTraitsViewController ()

@end

@implementation FamilyTraitsViewController {
    NSMutableArray *traitArray;
    NSMutableArray *swTitleArray;
}
@synthesize btnNext;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    traitArray = [[NSMutableArray alloc] init];
    swTitleArray = [NSMutableArray arrayWithObjects:@"Aliquam bibendum ex non", @"Donec eget augue", @"Nam placerat ligula", @"Vivamus tincidunt quam", @"Maecenas sit amet", @"Suspendisse sed turpis", @"Nullam a lectus sed", @"Duis tempor tortor sed egestas", nil];
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
    
    self.vTable.hidden = YES;
    self.consTableHeight.constant = 0;
}

#pragma mark - Action
- (IBAction)onChangeSwitch:(UISwitch *)sender {
    NSString *selectedStr = (NSString*)[swTitleArray objectAtIndex:sender.tag - 1];
    if (sender.isOn) {
        [traitArray addObject:selectedStr];
        
        [self.tableView reloadData];
        
        [self refreshTableView];
    }
    else {
        NSMutableArray *temp = [traitArray mutableCopy];
        
        for (NSString *str in temp) {
            
            if ([str isEqualToString:selectedStr]) {
                [traitArray removeObject:str];
            }
        }
        
        [self.tableView reloadData];
        
        [self refreshTableView];
    }
}

- (void)refreshTableView {
    if ([traitArray count] > 0) {
        self.consTableHeight.constant = kCellHeight * [traitArray count] + kLabelHeight;
        self.vTable.hidden = NO;
    }
    else {
        self.vTable.hidden = YES;
        self.consTableHeight.constant = 0;
    }
}

- (IBAction)onTapNextBtn:(id)sender {
    FamilyAddTitleViewController *familyTitleVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FamilyAddTitleViewController"];
    
    [self.navigationController pushViewController:familyTitleVC animated:YES];
}

- (IBAction)onTapBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [traitArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TraitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TraitCell" forIndexPath:indexPath];
    
    cell.lblNo.text = [NSString stringWithFormat:@"%li", indexPath.row + 1];
    cell.lblDes.text = [traitArray objectAtIndex:indexPath.row];
    
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
