//
//  GYProfileTopView.h
//  tabbar
//
//  Created by hgy on 16/2/20.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GYProfileTopViewDelegate <NSObject>
@optional
- (void)ProfileTopViewButtonClick:(UIButton *)btn;

@end
@interface GYProfileTopView : UIView
@property (nonatomic,weak) id<GYProfileTopViewDelegate> delegate;

@end
