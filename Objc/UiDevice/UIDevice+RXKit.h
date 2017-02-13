//
//  UIDevice+RXKit.h
//  RxFMDBManager
//
//  Created by RXL on 17/2/13.
//  Copyright © 2017年 RXL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (RXKit)

/**
 获取手机型号
 */
+ (NSString *)deviceType;


/**
 获取手机系统版本
 */
+ (NSString *)deviceVersion;

/**
 电池电量
 */
+ (CGFloat)deviceBatteryLevel;

@end
