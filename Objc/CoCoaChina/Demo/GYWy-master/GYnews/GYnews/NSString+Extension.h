//
//  NSString+Extension.h
//  微博
//
//  Created by hgy on 16/1/18.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;
@end
