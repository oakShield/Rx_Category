//
//  UIImage+HMResizeImg.h
//  01QQ聊天信息1-10
//
//  Created by SZSYKT_iOSBasic_2 on 16/1/10.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RxResizeImg)
//通过指定的名称返回拉伸之后的图片对象
+ (UIImage *) resizeImgWithName:(NSString *)name;
@end
