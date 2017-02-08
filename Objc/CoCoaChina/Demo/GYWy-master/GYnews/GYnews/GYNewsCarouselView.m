//
//  GYNewsCarouselView.m
//  tabbar
//
//  Created by hgy on 16/2/29.
//  Copyright © 2016年 hgy. All rights reserved.
//

#define GYTitleSelecterColor [UIColor redColor]
#define GYTitleNormalColor [UIColor blackColor]

#import "Constants.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "GYNewsCellModel.h"
#import "XYString.h"
#import "UIView+Extension.h"
#import "UIColor+RGBA.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIImageView+WebCache.h"
#import "iCarousel.h"
#import "GYNewsBaseCell.h"
#import "GYNewsFirstCell.h"
#import "GYNewsSecondCell.h"
#import "GYNewsThirdCell.h"
#import "GYNewsFourthCell.h"
#import "GYNewsTableView.h"
#import "GYSegmentView.h"
#import "GYSortItemView.h"
#import "GYTitleArrayManager.h"
#import "GYNewsCarouselView.h"
@interface GYNewsCarouselView ()<iCarouselDelegate,
iCarouselDataSource>

@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) NSMutableArray *tempListArray;
@property (nonatomic,strong) iCarousel *carousel;

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic,strong) GYSegmentView *segmentView;
@property (nonatomic,strong) GYSortItemView *sortItemView;
@property (nonatomic,strong) UIButton *addbtn;
@property (nonatomic,strong) UIButton *selectedButton;
@property (nonatomic,assign) CGFloat scrollX;


@end

@implementation GYNewsCarouselView
#pragma mark - 懒加载
- (UIButton *)selectedButton
{
    if (!_selectedButton) {
        _selectedButton = [[UIButton alloc]init];
    }
    return _selectedButton;
}
- (UIButton *)addbtn
{
    if (!_addbtn) {
        _addbtn = [[UIButton alloc]init];
    }
    return _addbtn;
}
- (GYSortItemView *)sortItemView
{
    if (!_sortItemView) {
    
        _sortItemView = [[GYSortItemView alloc]init];
       
    }
    return _sortItemView;
}
- (GYSegmentView *)segmentView
{
    if (!_segmentView) {
        _segmentView = [[GYSegmentView alloc]initWithFrame:CGRectMake(0, 70, self.width - GYaddButtonWidth, GYSegmentViewHeight)];
        _segmentView.backgroundColor = [UIColor whiteColor];
     
    }
    return _segmentView;
}
- (NSMutableArray *)tempListArray
{
    if (!_tempListArray) {
        _tempListArray = [NSMutableArray array];
        NSUInteger count = self.titleList.count;
        for (int i = 0; i < count ; i++) {
            NSString *title  = self.titleList[i][@"urlString"];
            [_tempListArray addObject:title];
        }
    }
    return _tempListArray;

}

- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
        NSUInteger count = self.titleList.count;
        for (int i = 0; i < count ; i++) {
            NSString *title  = self.titleList[i][@"title"];
            [_titleArray addObject:title];
        }
    }
    return _titleArray;
}

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
        NSUInteger count = self.tempListArray.count;
    
        for (int i = 0; i < count; i++)
        {
            [_items addObject:@(i)];
        }
        
    }
    return _items;
    
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *v1 = [[UIView alloc]init];
        [self addSubview:v1];
        [self initNotificationCenter];
        
    }
    return self;
}
- (void)initNotificationCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tempListChange:) name:GYSortitemViewTitleArrayChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cutTempList:) name:GYSortitemViewcutTitleArrayNotification object:nil];
}
- (void)tempListChange:(NSNotification *)noti
{
   
   NSInteger num1 = [[noti.object firstObject] integerValue];
   NSInteger num2 = [[noti.object lastObject] integerValue];
    NSString *title = [self.tempListArray objectAtIndex:num1];
    NSLog(@"%ld,%ld",num1,num2);
    [self.tempListArray removeObjectAtIndex:num1];
    [self.tempListArray insertObject:title atIndex:num2];
   
    
}
- (void)cutTempList:(NSNotification *)noti
{

    NSNumber *num = noti.object;
    NSInteger index = [num integerValue];
    NSLog(@"%@",num);
   [self.tempListArray removeObjectAtIndex:index];
    [self.items removeObjectAtIndex:index];
}

#pragma mark - 配置属性
- (void)setTitleList:(NSMutableArray *)titleList
{
    _titleList = titleList;
    GYTitleArrayManager *manager = [GYTitleArrayManager shareTitleArrayManager];
    manager.segmentView = self.segmentView;
    manager.sortItemView = self.sortItemView;
    
    
    //单独给segmentview添加数组 因为给sortitem也添加 会造成重叠 因为再点击创建sortitem后会重新添加数组
    [manager setSegmentVIewTitleArray:self.titleArray];
    [self setup];
}


- (void)setup
{
    [self setupTitleView];
    [self setupAddButton];
    [self setupcarousel];
}
- (void)setupTitleView
{
    
    [self addSubview:self.segmentView];
    __weak typeof(self) weakSelf = self;
    self.segmentView.titlebtnClickBlock = ^(UIButton *btn){
        
        NSInteger index = [weakSelf.segmentView.titleArray indexOfObject:btn.titleLabel.text];
        [weakSelf.carousel scrollToItemAtIndex:index animated:NO];
        [weakSelf titleBtnChange:btn];
    };
    UIButton *btn = self.segmentView.titleButtonArray[0];
    [self titleBtnChange: btn];
}
- (void)setupAddButton
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.segmentView.width, 70, GYaddButtonWidth, GYSegmentViewHeight)];
    [btn setImage:[UIImage imageNamed:@"iconfont-iosplusempty"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    self.addbtn = btn;
    [self addSubview: self.addbtn];
    
}
/**
 *  加号按钮点击
 *
 *  @param btn <#btn description#>
 */
- (void)addBtnclick:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
    if (self.sortItemView.sortAndCut.isSelected){
        return;
    }
    if (btn.selected) {
        CABasicAnimation *ani = [CABasicAnimation animation];
        ani.keyPath = @"transform.rotation.z";
        ani.byValue = @(M_PI_4);
        ani.removedOnCompletion = NO;
        ani.fillMode = kCAFillModeForwards;
        [btn.imageView.layer addAnimation:ani forKey:nil];
        
        [UIView animateWithDuration:0.5f animations:^{
            self.segmentView.alpha = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25f animations:^{
                [self addSortItemView];
                self.sortItemView.itemView.frame = CGRectMake(0, self.segmentView.height + 62, self.width, self.sortItemView.itemView.height);
            }];
        }];
        
    }
    else{
        CABasicAnimation *ani = [CABasicAnimation animation];
        ani.keyPath = @"transform.rotation.z";
        ani.byValue = @(-M_PI_4);
        ani.removedOnCompletion = NO;
        ani.fillMode = kCAFillModeForwards;
        [btn.imageView.layer addAnimation:ani forKey:nil];
        [UIView animateWithDuration:0.5 animations:^{
            self.sortItemView.alpha = 0;
            self.sortItemView.itemView.alpha = 0;
        } completion:^(BOOL finished) {
            self.segmentView.alpha = 1.0f;
        }];
       [self.carousel reloadData];
        [self titleBtnChange:self.selectedButton];
    }
}
- (void)addSortItemView

{
    BOOL isExistSotrItemView = self.sortItemView && (self.sortItemView.alpha == 0);
   
    if (isExistSotrItemView) {
        self.sortItemView.alpha = 1;
        self.sortItemView.itemView.alpha = 1;
    }
    else{
        GYSortItemView *sortItemView = [[GYSortItemView alloc]initWithFrame:CGRectMake(0, 70, self.width - GYaddButtonWidth, GYSegmentViewHeight)];
        
        _sortItemView = sortItemView;
        _sortItemView.currentItemsArray = self.titleArray;
        _sortItemView.itemView.height = self.height;
        __weak typeof(self) WeakSelf = self;
        _sortItemView.itemClickBlock = ^(UIButton *btn)
        {
            [WeakSelf itemViewButtonClick:btn];
            
            
        };
        
        [self addSubview:_sortItemView];
        [self addSubview:_sortItemView.itemView];
    }

    
    
}
- (void)setupcarousel
{
    _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 114, self.width, self.height-106)];
    
    
    _carousel.type = iCarouselTypeLinear;
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.decelerationRate = 0.5;
    _carousel.scrollSpeed = 0;
    _carousel.bounces = NO;
    _carousel.pagingEnabled = YES;
    [self addSubview:_carousel];

   
}
#pragma mark - icarousel相关代理
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    
    return self.items.count;
   
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    [view removeFromSuperview];
    view = nil;
    
    
    if (!view)
    {
        view = [[UIView alloc] initWithFrame:carousel.bounds];
        GYNewsTableView *tv = [[GYNewsTableView alloc]initWithFrame:CGRectMake(0, 0, carousel.width, carousel.height)];
       
        
        tv.title = self.tempListArray[index];

        [view addSubview:tv];
       
    
      
       
    }
 
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return NO;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.0f;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}

- (void)carouselDidScroll:(iCarousel *)carousel
{
    NSUInteger index = carousel.scrollOffset / 1;
    CGFloat p = index > 0?(carousel.scrollOffset - index):carousel.scrollOffset;
    
    if ((index + 1)< self.segmentView.titleButtonArray.count ) {
        UIButton *currentBtn = self.segmentView.titleButtonArray[index];
        self.selectedButton = currentBtn;
        UIButton *nextBtn = self.segmentView.titleButtonArray[index+1];
        [self changeFontAndColor: self.selectedButton:p];
        [self changeFontAndColor:nextBtn:p];
    }
}


- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    NSUInteger index = carousel.scrollOffset / 1;
    
    UIButton *btn = self.segmentView.titleButtonArray[index];
    
    if (index > 2) {
        self.segmentView.titleScroll.contentOffset = CGPointMake(btn.centerX - GYsortButton, 0);
    }
    else
    {
        self.segmentView.titleScroll.contentOffset = CGPointMake(0, 0);
    }
}

- (void)itemViewButtonClick:(UIButton *)btn;
{
   
    [self addBtnclick:self.addbtn];
     NSInteger index = [self.sortItemView.currentItemsArray indexOfObject:btn.titleLabel.text];
  
    [self.carousel scrollToItemAtIndex:index animated:NO];
    UIButton *titlebtn = self.segmentView.titleButtonArray[index];
      [self titleBtnChange:titlebtn];
    if (index > 2) {
        self.segmentView.titleScroll.contentOffset = CGPointMake(titlebtn.centerX - GYsortButton, 0);
    }
    else
    {
        self.segmentView.titleScroll.contentOffset = CGPointMake(0, 0);
    }
    
}

- (void)changeFontAndColor:(UIButton *)button:(CGFloat)p
{
    
    RGBA rgba1 = RGBAFromUIColor(GYTitleNormalColor);
    RGBA rgba2 = RGBAFromUIColor(GYTitleSelecterColor);
    CGFloat red1 = rgba1.r;
    CGFloat green1 = rgba1.g;
    CGFloat blue1 = rgba1.b;
    CGFloat red2 = rgba2.r;
    CGFloat green2 = rgba2.g;
    CGFloat blue2 = rgba2.b;
    CGFloat redTemp1 = ((red2 - red1) * (1-p)) + red1;
    CGFloat greenTemp1 = ((green2 - green1) * (1 - p)) + green1;
    CGFloat blueTemp1 = ((blue2 - blue1) * (1 - p)) + blue1;
    
    CGFloat redTemp2 = ((red2 - red1) * p) + red1;
    CGFloat greenTemp2 = ((green2 - green1) * p) + green1;
    CGFloat blueTemp2 = ((blue2 - blue1) * p) + blue1;
    if (button == self.selectedButton) {
        [button setTitleColor:[UIColor colorWithRed:redTemp1 green:greenTemp1 blue:blueTemp1 alpha:1] forState:UIControlStateNormal];
        CGFloat font = GYTitleButtonMaxFont - p * (GYTitleButtonMaxFont - GYTitleButtonMinFont);
        button.titleLabel.font = [UIFont systemFontOfSize:font];
    }
    else{
        CGFloat font = GYTitleButtonMinFont + p *(GYTitleButtonMaxFont -GYTitleButtonMinFont);
        button.titleLabel.font = [UIFont systemFontOfSize:font];
        self.selectedButton = button;
        [button setTitleColor:[UIColor colorWithRed:redTemp2 green:greenTemp2 blue:blueTemp2 alpha:1] forState:UIControlStateNormal];
    }
}
#pragma mark - 其他方法
- (void)titleBtnChange:(UIButton *)btn
{
    NSLog(@"titleBtnChange");
    if (btn!= self.selectedButton) {
        for (UIButton *btn in self.segmentView.titleButtonArray) {
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:GYTitleNormalColor forState:UIControlStateNormal];
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        [btn setTitleColor:GYTitleSelecterColor forState:UIControlStateNormal];
        self.selectedButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.selectedButton setTitleColor:GYTitleNormalColor forState:UIControlStateNormal];
        
        self.selectedButton = btn;
    }
    else
    {
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        [btn setTitleColor:GYTitleSelecterColor forState:UIControlStateNormal];
        
    }
}
@end
