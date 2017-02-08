//
//  GYSegmentView.h
//  tabbar
//
//  Created by hgy on 16/2/28.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TitlebtnClickBlock)(UIButton *btn);
@interface GYSegmentView : UIView
/**
 *  标题数组
 */
@property (nonatomic,strong) NSMutableArray *titleArray;
/**
 *  标题按钮数组
 */
@property (nonatomic,strong) NSMutableArray *titleButtonArray;
/**
 *  存放每一个按钮的滚动位置 点击滚到该位置
 */
@property (nonatomic,strong) NSMutableArray *scrollOffSet;
/**
 *  滚动条
 */
@property (nonatomic,strong) UIScrollView *titleScroll;

@property (nonatomic, copy) TitlebtnClickBlock titlebtnClickBlock ;
@end
