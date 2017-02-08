//
//  GYSortItemView.m
//  tabbar
//
//  Created by hgy on 16/2/28.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYSortItemView.h"
#import "UIView+Extension.h"
#import "GYSortButton.h"
#import "GYTitleArrayManager.h"
#import "Constants.h"
@interface GYSortItemView()
@property (nonatomic, strong) NSMutableArray *positionViews;
@property (nonatomic, strong) NSMutableDictionary *itemsDic;
@property (nonatomic, weak) GYSortButton *selectButton;
@property (nonatomic, weak) GYSortButton *otherButton;
@property (nonatomic, assign) CGRect selectItemFrame;
@property (nonatomic, assign) CGRect tmpRect;

@end
@implementation GYSortItemView
#pragma mark - 懒加载
- (NSMutableDictionary *)itemsDic{
    if (!_itemsDic) {
        _itemsDic = [NSMutableDictionary dictionary];
    }
    return _itemsDic;
}
- (NSMutableArray *)positionViews{
    if (!_positionViews) {
        _positionViews = [NSMutableArray array];
    }
    return _positionViews;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    
    UILabel *changeItem = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, GYItemWitdh, self.height)];
    changeItem.text = @"切换栏目";
    changeItem.font = [UIFont systemFontOfSize:15];
    [self addSubview:changeItem];
    UIButton *sortAndCut = [[UIButton alloc]initWithFrame:CGRectMake(self.width - GYsortButton, 0, GYsortButton, self.height)];
    [sortAndCut setTitle:@"排序删除" forState:UIControlStateNormal];
    [sortAndCut setTitle:@"完成" forState:UIControlStateSelected];
    [sortAndCut addTarget:self action:@selector(layoutBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    sortAndCut.titleLabel.font = [UIFont systemFontOfSize:13];
    [sortAndCut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sortAndCut setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    self.sortAndCut = sortAndCut;
    [self addSubview:self.sortAndCut];
   

}
#pragma mark - 配置属性
- (void)setCurrentItemsArray:(NSMutableArray *)currentItemsArray
{
    _currentItemsArray = currentItemsArray;
    [self setCurrentItem];
}
- (void)setCurrentItem
{
    NSUInteger count = self.currentItemsArray.count ;
    CGFloat rows = (count + GYsortItemViewmaxCols - 1) / GYsortItemViewmaxCols;
    CGFloat currentItemViewHeight = rows * (GYItemViewMargin + GYItemHeight);
    
    UIScrollView *itemview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.height, self.width + GYaddButtonWidth, currentItemViewHeight)];
    itemview.backgroundColor = [UIColor whiteColor];
    itemview.alpha = 1;
    itemview.contentSize = CGSizeMake(0, 1000);
    self.itemView = itemview;
    [self setupPositionViewsAndItemsWithItemArray:self.currentItemsArray];
    [self addSubview:self.itemView];
}

- (void)setupPositionViewsAndItemsWithItemArray:(NSMutableArray *)itemArray
{
    int num = 0;
    self.userInteractionEnabled = YES;
    for (int i = 0; i < itemArray.count; i++) {
        UIImageView *view = [[UIImageView alloc]init];
        view.image = [UIImage imageNamed:@"choose_city_normal"];
        view.alpha = 1;
        view.layer.cornerRadius = 5;
        [self.positionViews addObject:view];
        [self.itemView addSubview:view];
    }
    for (NSString *title in itemArray) {
        GYSortButton *item = [[GYSortButton alloc]init];
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [item setTitle:title forState:UIControlStateNormal];
         item.titleLabel.font = [UIFont systemFontOfSize:15];
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.itemsDic setObject:item forKey:title];
        [self.itemView addSubview:item];
        num++;
    }

}
#pragma mark - 取按钮
- (GYSortButton *)getSortButtonByTitle:(NSString *)title
{
    return [self.itemsDic objectForKey:title];
}
- (GYSortButton *)getSortButtonByKeyIndex:(NSUInteger)index
{
    return [self.itemsDic objectForKey:self.currentItemsArray[index]];
}
#pragma mark - 排序按钮点击
- (void)layoutBtn:(UIButton *)btn
{
    
    btn.selected = !btn.isSelected;
    if (btn.isSelected) {
        [self setuplongGesture];
        [self.itemsDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, GYSortButton *item, BOOL * _Nonnull stop) {
            UIButton *deletBtn = [[UIButton alloc]init];
            [deletBtn setImage:[UIImage imageNamed:@"newscontent_drag_return"] forState:UIControlStateNormal];
            [deletBtn addTarget:self action:@selector(deletClick:) forControlEvents:UIControlEventTouchUpInside];
            CGFloat deletW = deletItemW;
            CGFloat deletH = deletW;
            deletBtn.frame = CGRectMake(0, 0, deletW, deletH);
            deletBtn.centerX = 3;
            deletBtn.centerY = 3;
            item.deletIcon = deletBtn;
            item.deletIcon.alpha = 1;
        }];
    }
    else
    {
        [self removelongGesture];
        [self.itemsDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, GYSortButton *item, BOOL * _Nonnull stop) {
            
            item.deletIcon.alpha = 0;
            
        }];
        
    }
    
}

- (void)setuplongGesture
{
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longGesture.minimumPressDuration = 0.4f;
    [self.itemView addGestureRecognizer:longGesture];
}
-(void)removelongGesture
{
    for (UILongPressGestureRecognizer *recognizer in [self.itemView gestureRecognizers]) {
        [self.itemView removeGestureRecognizer:recognizer];
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)longGesture
{
    if (longGesture.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [longGesture locationInView:longGesture.view];
        [self.itemsDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, GYSortButton *button, BOOL * _Nonnull stop) {
            CGRect rect = button.frame;
            if (CGRectContainsPoint(rect, location)) {
                *stop = YES;
                self.selectButton = button;
                self.selectItemFrame = self.selectButton.frame;
                self.tmpRect = self.selectItemFrame;
                [UIView animateWithDuration:0.3 animations:^{
                    self.selectButton.center = location;
                }];
                
            }
        }];
    }else if(longGesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint location = [longGesture locationInView:longGesture.view];
        self.selectButton.center = location;
        [self.itemsDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, GYSortButton *button, BOOL * _Nonnull stop) {
            self.otherButton = button;
           
            if (CGRectContainsPoint(self.selectButton.frame, self.otherButton.center)&&self.selectButton != self.otherButton) {
                *stop = YES;
                NSInteger selectBtnIndex = [self.currentItemsArray indexOfObject:self.selectButton.titleLabel.text];
            
                NSInteger otherBtnIndex = [self.currentItemsArray indexOfObject:self.otherButton.titleLabel.text];
               
                self.tmpRect = self.otherButton.frame;
                [self animationBetweenSelectItemIndex:selectBtnIndex AndOtherItemIndex:otherBtnIndex];
                self.selectItemFrame = self.tmpRect;
            }else{
                self.tmpRect = self.selectItemFrame;
                
            }
        }];
    }else if (longGesture.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.3 animations:^{
            self.selectButton.frame = self.tmpRect;
          
        }];
        
        //排列完成后，将排列好的标题数组发给管理者
        [[GYTitleArrayManager shareTitleArrayManager] setTitleArray:self.currentItemsArray];
       
    
    }


}
- (void)animationBetweenSelectItemIndex:(NSInteger)selectIndex AndOtherItemIndex:(NSInteger)otherIndex{
    NSMutableArray *needMoveItem = [NSMutableArray array];
    NSMutableArray *positionView = [NSMutableArray array];
    if (selectIndex < otherIndex) {
        for (int i = (int)selectIndex + 1; i <= otherIndex; i++) {
            GYSortButton *item = [self.itemsDic objectForKey:self.currentItemsArray[i]];
            [needMoveItem addObject:item];
            UIImageView *view = self.positionViews[i - 1];
            [positionView addObject:view];
        }
        int j = 0;
        for (GYSortButton *item in needMoveItem) {
            UIImageView *view = positionView[j];
            [UIView animateWithDuration:0.3 animations:^{
                item.frame = view.frame;
            }completion:^(BOOL finished) {
                if (j == needMoveItem.count - 1) {
                    
                }
            }];
            j++;
        }
        NSInteger num1 = [self.currentItemsArray indexOfObject:self.selectButton.titleLabel.text];
        NSInteger num2 = [self.currentItemsArray indexOfObject:self.otherButton.titleLabel.text];
     
        [self creatNotification:num1 :num2];
        [self resetcurrentItemsArray:num1:num2];
        
    }else{
        for (int i = (int)otherIndex; i < selectIndex; i++) {
            GYSortButton *item = [self.itemsDic objectForKey:self.currentItemsArray[i]];
            [needMoveItem addObject:item];
            UIImageView *view = self.positionViews[i + 1];
            [positionView addObject:view];
            
        }
        int j = (int)needMoveItem.count-1;
        for (int i = j; i >= 0; i--) {
            UIView *view = positionView[i];
            GYSortButton *item = needMoveItem[i];
            [UIView animateWithDuration:0.3 animations:^{
                item.frame = view.frame;
            }completion:^(BOOL finished) {
               
            }];
        }
        NSInteger num1 = [self.currentItemsArray indexOfObject:self.selectButton.titleLabel.text];
        NSInteger num2 = [self.currentItemsArray indexOfObject:self.otherButton.titleLabel.text];
      
        [self creatNotification:num1 :num2];
          [self resetcurrentItemsArray:num1:num2];
    
          }
   

    
}
//通知 按钮排序变化发送 carousel view的数据源数组顺序改变
- (void)creatNotification:(NSUInteger)n1 :(NSUInteger)n2
{
    NSNumber *num1 = @(n1);
    NSNumber *num2 = @(n2);
    NSArray *arry = @[num1,num2];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:GYSortitemViewTitleArrayChangeNotification object:arry userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
- (void)resetcurrentItemsArray:(NSUInteger)n1 :(NSUInteger)n2
{
    [self.currentItemsArray removeObjectAtIndex:n1];
    [self.currentItemsArray insertObject:self.selectButton.titleLabel.text atIndex:n2];
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.currentItemsArray.count == 0) return;
    NSUInteger count = self.currentItemsArray.count;
    CGFloat buttonW = GYItemWitdh;
    CGFloat buttonH = GYItemHeight;
    CGFloat margin = (self.itemView.width - GYsortItemViewmaxCols * GYItemWitdh)/ (1 + GYsortItemViewmaxCols);
    CGFloat buttonY = GYItemViewMargin;
    CGFloat rows = (count + GYsortItemViewmaxCols - 1) / GYsortItemViewmaxCols;
    for (int i = 0; i < rows; i++) {
        CGFloat buttonX = margin;
        for (int j = 0; j < GYsortItemViewmaxCols; j ++) {
            NSUInteger index = j + i* GYsortItemViewmaxCols;
#warning 控制按钮数量等于数组的数量
            if (index == count)
                break;
            GYSortButton *item = [self getSortButtonByKeyIndex:index];
            
            UIImageView *view = self.positionViews[index];
            CGRect frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            item.frame = frame;
            view.frame = frame;
            
            
            buttonX += buttonW + margin;
            
        }
        buttonY += buttonH + GYItemViewMargin;
    }
}

- (void)layoutItemsAfterDeletItem:(GYSortButton *)item
{
    if (self.currentItemsArray.count ==1) return;
    NSUInteger index = [self.currentItemsArray indexOfObject:item.titleLabel.text];
        NSLog(@"%ld",index);
    for (NSUInteger i = index; i<self.currentItemsArray.count-1; i++) {
        UIImageView *view = self.positionViews[i];
        GYSortButton *nextbtm = [self getSortButtonByTitle:self.currentItemsArray[i+1]];
        [UIView animateWithDuration:1.0 animations:^{
            nextbtm.frame = view.frame;
        }];
        
    }
    UIImageView *lastview = [self.positionViews lastObject];
    [UIView animateWithDuration:0.3 animations:^{
        item.alpha = 0;
        lastview.alpha = 0;
    }];
    [self.currentItemsArray removeObject:item.titleLabel.text];
    [self.positionViews removeLastObject];
    NSLog(@"%@",item.titleLabel.text);
    [self.itemsDic removeObjectForKey:item.titleLabel.text];
//重新设置segmentview的title
    [[GYTitleArrayManager shareTitleArrayManager] setSegmentVIewTitleArray:self.currentItemsArray];

    
}
#pragma mark - 按钮点击
- (void)deletClick:(UIButton *)btn
{
    NSLog(@"deletClick");
    if (self.currentItemsArray.count > 3) {
        GYSortButton *sort = (GYSortButton *)btn.superview;
        
       
        
        NSUInteger index = [self.currentItemsArray indexOfObject:sort.titleLabel.text];
            NSLog(@"%ld",index);
        NSNumber *num = @(index);
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:GYSortitemViewcutTitleArrayNotification object:num];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
         [self layoutItemsAfterDeletItem:sort];
    }
   
}
- (void)itemClick:(UIButton *)btn
{
    if (self.sortAndCut.isSelected){
        return;
    }
    NSLog(@"itemClick");
    if (self.itemClickBlock) {
        self.itemClickBlock(btn);
    }

}
@end
