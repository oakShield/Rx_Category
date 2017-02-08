//
//  NSString+Path.h
//  01-沙盒目录
//
//  Created by SZSYKT_iOSBasic_2 on 16/3/1.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)
// 追加文档路径
- (NSString *)appendDoucmentPath;
// 追加缓存路径
- (NSString *)appendCachePath;
// 追加文档路径
- (NSString *)appendTempPath;
@end
