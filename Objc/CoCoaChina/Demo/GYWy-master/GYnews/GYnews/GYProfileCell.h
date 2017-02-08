//
//  GYProfileCell.h
//  tableview
//
//  Created by hgy on 16/2/19.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYProfileItem;
@interface GYProfileCell : UITableViewCell
@property(nonatomic,strong)GYProfileItem *item;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
