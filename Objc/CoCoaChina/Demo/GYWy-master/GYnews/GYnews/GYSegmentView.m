//
//  GYSegmentView.m
//  tabbar
//
//  Created by hgy on 16/2/28.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYSegmentView.h"
#import "UIView+Extension.h"
#import "Constants.h"
@interface GYSegmentView()

@end
@implementation GYSegmentView
#pragma mark - 懒加载
- (NSMutableArray *)scrollOffSet
{
    if (!_scrollOffSet) {
        _scrollOffSet = [NSMutableArray array];
    }
    return _scrollOffSet;
}
- (UIScrollView *)titleScroll
{
    if (!_titleScroll) {
        _titleScroll = [[UIScrollView alloc]init];
    }
    return _titleScroll;
}
- (NSMutableArray *)titleButtonArray
{
    if (!_titleButtonArray) {
        _titleButtonArray = [NSMutableArray array];
    }
    return _titleButtonArray;
}
- (UIScrollView *)titiltScroll
{
    if (!_titleScroll) {
        _titleScroll = [[UIScrollView alloc]init];
  
    }
    return _titleScroll;
}
#pragma  mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
#pragma  mark - 配置属性
- (void)setTitleArray:(NSMutableArray *)titleArray
{
    _titleArray = titleArray;
     [self setup];
}

- (void)setup
{
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(GYSegmentViewMargin, 0, self.width - 2 * GYSegmentViewMargin, self.height)];
    sc.backgroundColor = [UIColor whiteColor];
    sc.showsHorizontalScrollIndicator = NO;
    self.titleScroll = sc;
    [self addSubview:self.titleScroll];
    
    UIView *cover1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, GYSegmentViewMargin * 2, self.height)];
    cover1.backgroundColor = [UIColor whiteColor];
    cover1.alpha = 0.5;
    UIView *cover2 = [[UIView alloc]initWithFrame:CGRectMake(self.width - 2 * GYSegmentViewMargin, 0, GYSegmentViewMargin * 2, self.height)];
    cover2.backgroundColor = [UIColor whiteColor];
    cover2.alpha = 0.5;
    [self addSubview:cover1];
    [self addSubview:cover2];
  
    [self setupTitleButton];
    
}

- (void)setupTitleButton
{
    CGFloat btnHeight = self.height;
    CGFloat btnX = GYSegmentViewMargin;
    CGFloat btnY = 0;

    NSMutableArray *array = [NSMutableArray array];
    //防止新添加的按钮遮盖 导致字体效果也被遮盖
    if (self.titleButtonArray.count > 0) {
        [self.titleButtonArray removeAllObjects];
    }
    for (int i = 0; i < _titleArray.count; i++)
    {
        NSString *title = _titleArray[i];
        
        CGFloat btnWidth = title.length * GYTitleButtonMaxFont + GYSegmentViewMargin;
        
        UIButton *btn = [[UIButton alloc]init];
        [btn  setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:GYTitleButtonMinFont];
        btn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        btnX += btnWidth + GYSegmentViewMargin;
        btn.tag = i;
      
        [array addObject:btn];
       
        [self.titleScroll addSubview:btn];
        [self.scrollOffSet addObject:@(btnX)];
      
    }
    [self.titleButtonArray addObjectsFromArray:array];
    self.titleScroll.contentSize = CGSizeMake(btnX + GYLastTitleWidth, self.height);
   
}
#pragma mark -按钮点击
- (void)titleClick:(UIButton *)btn
{
    if (self.titlebtnClickBlock) {
        self.titlebtnClickBlock(btn);
    }
}

@end
