//
//  GYNewsThirdCell.m
//  tabbar
//
//  Created by hgy on 16/2/24.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYNewsThirdCell.h"

@implementation GYNewsThirdCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup{

    // 设置约束
    CGFloat margin = 10;
    
    self.lblTitle.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .rightSpaceToView(self.contentView,margin)
    .topSpaceToView(self.contentView,margin)
    .heightIs(21);
    
    self.imgIcon.sd_layout
    .topSpaceToView(self.lblTitle,margin)
    .rightSpaceToView(self.contentView,margin)
    .leftSpaceToView(self.contentView,margin)
    .heightIs(130);
    
    self.lblSubtitle.sd_layout
    .topSpaceToView(self.imgIcon,margin)
    .rightSpaceToView(self.contentView,margin)
    .leftSpaceToView(self.contentView,margin)
    .autoHeightRatio(0);

    self.lineView.sd_layout
    .topSpaceToView(self.lblSubtitle,margin)
    .rightSpaceToView(self.contentView,0)
    .leftSpaceToView(self.contentView,0)
    .heightIs(1);

    [self setupAutoHeightWithBottomView:self.lineView bottomMargin:0];

}

- (void)setNewsModel:(GYNewsCellModel *)newsModel{
    
    self.lblTitle.text = newsModel.title;
    self.lblSubtitle.text = [NSString stringWithFormat:@"%@",newsModel.digest];
    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"303"]];

}

@end
