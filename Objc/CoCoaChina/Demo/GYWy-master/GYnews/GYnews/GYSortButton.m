//
//  GYSortButton.m
//  tabbar
//
//  Created by hgy on 16/3/1.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYSortButton.h"
#import "UIView+Extension.h"

@implementation GYSortButton
- (void)setDeletIcon:(UIButton *)deletIcon
{
    _deletIcon = deletIcon;
    [self addSubview:deletIcon];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
        
        
    }
    return self;
}
- (void)setup{
    
    
    
    
//    self.layer.cornerRadius = 5;
//    self.layer.borderWidth = 1;
//    self.layer.borderColor = [UIColor colorWithRed:126/255.0 green:222/255.0 blue:184/255.0 alpha:0.6].CGColor;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
//    self.backgroundColor = [UIColor colorWithRed:31/255.0 green:192/255.0 blue:120/255.0 alpha:0.6];
    self.backgroundColor = [UIColor clearColor];
}
- (void)layoutSubviews{
    [super layoutSubviews];
  
}

@end
