//
//  GYProfileCell.m
//  tableview
//
//  Created by hgy on 16/2/19.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYProfileCell.h"
#import "GYProfileItem.h"
#import "UIView+Extension.h"
@implementation GYProfileCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"SettingCell";
    GYProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[GYProfileCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    return cell;
}
- (void)setItem:(GYProfileItem *)item
{
    
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.detailTitle;
    self.detailTextLabel.font = [UIFont systemFontOfSize:10];
    self.imageView.image = [UIImage imageNamed:item.icon];
   
}
@end
