//
//  GYSortItemView.h
//  tabbar
//
//  Created by hgy on 16/2/28.
//  Copyright © 2016年 hgy. All rights reserved.

#import <UIKit/UIKit.h>
typedef void (^ItemClickBlock)(UIButton *btn);

@interface GYSortItemView : UIView

@property (nonatomic,strong) NSMutableArray *currentItemsArray;
@property (nonatomic,weak) UIScrollView *itemView;
@property (nonatomic,weak) UIButton *sortAndCut;

@property (nonatomic,copy) ItemClickBlock itemClickBlock;
@end
