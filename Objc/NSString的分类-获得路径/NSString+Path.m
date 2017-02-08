//
//  NSString+Path.m
//  01-沙盒目录
//
//  Created by SZSYKT_iOSBasic_2 on 16/3/1.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)
// 追加文档路径
- (NSString *)appendDoucmentPath {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[self lastPathComponent]];
}
// 追加缓存路径
- (NSString *)appendCachePath {
     return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[self lastPathComponent]];
}
// 追加文档路径
- (NSString *)appendTempPath {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:[self lastPathComponent]];
}
@end
