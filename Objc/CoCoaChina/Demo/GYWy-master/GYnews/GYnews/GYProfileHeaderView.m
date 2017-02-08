//
//  GYProfileHeaderView.m
//  tabbar
//
//  Created by hgy on 16/2/19.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYProfileHeaderView.h"
#import "GYWaterView.h"
#import "GYProfileTopView.h"
#import "Masonry.h"
#import "UIView+Extension.h"
@interface GYProfileHeaderView()
@property (nonatomic,strong) GYWaterView *water;

@end
@implementation GYProfileHeaderView

- (GYWaterView *)water
{
    if (!_water) {
        _water = [[GYWaterView alloc]init];
    }
    return _water;

}
- (void)setWaveheight:(CGFloat)waveheight
{

    _waveheight = waveheight;
    self.water.currentLinePointY = waveheight;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
        [self setup];
    }
    return self;
}
- (void)setup
{
    [self setupTopView];
    [self setupWaterView];

}
- (void)setupTopView
{
    GYProfileTopView *topView = [[GYProfileTopView alloc]init];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.width);
        make.height.mas_equalTo(self.height * 0.6);
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
    }];
     self.topView = topView;
}
- (void)setupWaterView
{
    GYWaterView  *water =[[GYWaterView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height )];
    water.currentcolor = [UIColor orangeColor];
    water.alpha = 0.8;
   self.water = water;
    [self addSubview:self.water];
    [water mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.width);
        make.height.mas_equalTo(self.height * 0.4);
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
    }];
   
    
    
   

}
@end
