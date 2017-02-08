
//
//  GYProfileTopView.m
//  tabbar
//
//  Created by hgy on 16/2/20.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYProfileTopView.h"
#import "Masonry.h"
#import "UIView+Extension.h"
@implementation GYProfileTopView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setup];
    }
    return self;
}
- (void)setup
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"设置" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentImage.size;
    
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(btn.size.width);
        make.width.mas_equalTo(btn.size.height);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(self.mas_top).offset(10);
    }];
    
    
}
- (void)btnclick:(UIButton *)btn
{
    
    if ([self.delegate respondsToSelector:@selector(ProfileTopViewButtonClick:)]) {
        [self.delegate ProfileTopViewButtonClick:btn];
    }

}
@end
