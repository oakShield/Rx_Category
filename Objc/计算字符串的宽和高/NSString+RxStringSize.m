//
//  NSString+RxStringSize.m
//  1.QQ-V1.0
//
//  Created by RXL on 16/1/10.
//  Copyright © 2016年 RXL. All rights reserved.
//

#import "NSString+RxStringSize.h"

@implementation NSString (RxStringSize)

-(CGSize)stringSize:(CGSize)maxSize andFontSize:(NSInteger)fontSize{
    
    NSDictionary *textAtt=@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGSize textSize=[self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:textAtt context:nil].size;
    return textSize;
}
@end
