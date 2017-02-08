//
//  GYNewsTableView.h
//  tabbar
//
//  Created by hgy on 16/2/26.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYNewsTableView : UITableView
@property (nonatomic,strong) NSMutableArray *listArry;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) NSUInteger index;

@end
