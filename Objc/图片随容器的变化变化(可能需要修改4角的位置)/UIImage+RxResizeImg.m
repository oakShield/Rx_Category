//
//  UIImage+HMResizeImg.m
//  01QQ聊天信息1-10
//
//  Created by SZSYKT_iOSBasic_2 on 16/1/10.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "UIImage+RxResizeImg.h"

@implementation UIImage (RxResizeImg)
//通过指定的名称返回拉伸之后的图片对象
+ (UIImage *) resizeImgWithName:(NSString *)name
{
    //第一个参数：设置受保护区域，只有在间距范围交集的内容才能进行相应的拉伸和平铺，意味着要保护四个角点
    //第二个参数：图片是进行拉伸还是平铺：UIImageResizingModeStretch：拉伸  UIImageResizingModeTile:平铺
//    return [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 25, 20, 30) resizingMode:UIImageResizingModeTile];
    return [[self alloc] resizeImgWithName1:[UIImage imageNamed:name]];
}

- (UIImage *)resizeImgWithName1:(UIImage *)image
{
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(30, 25, 20, 30) resizingMode:UIImageResizingModeTile];
}
@end
