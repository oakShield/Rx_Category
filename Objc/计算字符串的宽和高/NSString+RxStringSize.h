//
//  NSString+RxStringSize.h
//  Created by RXL on 16/1/10.
//  Copyright © 2016年 RXL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (RxStringSize)

/**
 *  计算字符串的高度和宽度
 *
 *  @param maxSize  设置字符串最大的高度和宽度,超过这个范围只会返回这个值
 *  @param fontSize 字符串字体的大小
 *
 *  @return CGSize类型的值,表示字符串的宽和高
 */
-(CGSize)stringSize:(CGSize)maxSize andFontSize:(NSInteger)fontSize;

@end
