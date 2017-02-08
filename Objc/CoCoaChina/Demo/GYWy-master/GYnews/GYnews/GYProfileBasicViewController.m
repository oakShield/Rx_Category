//
//  GYProfileBasicViewController.m
//  tableview
//
//  Created by hgy on 16/2/19.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYProfileBasicViewController.h"
#import "GYProfileItem.h"
#import "GYProfileCell.h"
#import "GYProfileGroup.h"
@interface GYProfileBasicViewController ()

@end

@implementation GYProfileBasicViewController


- (instancetype)init{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
       
    }
    
    return self;
}
- (NSMutableArray *)cellData{
    if (!_cellData) {
        _cellData = [NSMutableArray array];
    }
    
    return _cellData;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
//    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
//    self.view.backgroundColor = [UIColor redColor];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.cellData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GYProfileGroup *group = self.cellData[section];
    return group.items.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GYProfileCell *cell = [GYProfileCell cellWithTableView:tableView];
    
    //获取组的模型数据
    GYProfileGroup *group = self.cellData[indexPath.section];
    
    //获取行的模型数据
    GYProfileItem *item = group.items[indexPath.row];
    
    //设置模型 显示数据
    cell.item = item;
    return cell;
}

@end
