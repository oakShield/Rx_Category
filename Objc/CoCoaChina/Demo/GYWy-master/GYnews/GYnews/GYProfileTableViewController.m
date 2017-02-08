//
//  GYProfileTableViewController.m
//  tableview
//
//  Created by hgy on 16/2/19.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYProfileTableViewController.h"
#import "GYProfileBasicViewController.h"
#import "GYProfileGroup.h"
#import "GYProfileTopView.h"
#import "GYProfileItem.h"
#import "GYWaterView.h"
#import "GYProfileHeaderView.h"
#import "UIView+Extension.h"
@interface GYProfileTableViewController ()<GYProfileTopViewDelegate>

@end

@implementation GYProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//   self.navigationController.navigationBarHidden = YES;
    GYProfileHeaderView *header = [[GYProfileHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 150)];
    header.waveheight = 20;
    header.topView.delegate = self;
  //    header.backgroundColor = [UIColor blackColor];
    self.tableView.tableHeaderView = header;
    
    GYProfileItem *item1 = [GYProfileItem itemWithIcon:@"09999978Icon" title:@"爱心" detailTitle:@"人人都献出一份爱" destinationControllerClass:[GYProfileBasicViewController class]];
    GYProfileGroup *group1 = [[GYProfileGroup alloc]init];
    group1.items = @[item1];
    [self.cellData addObject:group1];
    
    GYProfileItem *item2 = [GYProfileItem itemWithIcon:@"20000032Icon" title:@"财富" detailTitle:@"咋有钱" destinationControllerClass:[GYProfileBasicViewController class]];
    GYProfileItem *item3 = [GYProfileItem itemWithIcon:@"20000059Icon" title:@"招财" detailTitle:@"快来快来数一数" destinationControllerClass:[GYProfileBasicViewController class]];
    GYProfileItem *item4 = [GYProfileItem itemWithIcon:@"20000077Icon" title:@"电影" detailTitle:@"未满18禁入" destinationControllerClass:[GYProfileBasicViewController class]];
    GYProfileGroup *group2 = [[GYProfileGroup alloc]init];
    group2.items = @[item2,item3,item4];
    [self.cellData addObject:group2];
    
    GYProfileItem *item5 = [GYProfileItem itemWithIcon:@"20000110Icon" title:@"保障" detailTitle:@"为你撑出一片天" destinationControllerClass:[GYProfileBasicViewController class]];
    GYProfileItem *item6 = [GYProfileItem itemWithIcon:@"20000118Icon" title:@"什么鬼" detailTitle:@"我不知道" destinationControllerClass:[GYProfileBasicViewController class]];
    GYProfileItem *item7 = [GYProfileItem itemWithIcon:@"20000180Icon" title:@"随身贷" detailTitle:@"哪里要钱给哪里" destinationControllerClass:[GYProfileBasicViewController class]];
    GYProfileGroup *group3 = [[GYProfileGroup alloc]init];
    group3.items = @[item5,item6,item7];
    [self.cellData addObject:group3];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
  
}
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{  GYProfileGroup *group = self.cellData[indexPath.section];
    
    GYProfileItem *item = group.items[indexPath.row];
 
    UIViewController *vc = [[item.destinationControllerClass alloc] init];
    vc.title = item.title;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)ProfileTopViewButtonClick:(UIButton *)btn
{
    NSLog(@"aaa");
}
@end
