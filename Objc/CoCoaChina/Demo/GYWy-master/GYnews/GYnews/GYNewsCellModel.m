//
//  GYNewsCellModel.m
//  tabbar
//
//  Created by hgy on 16/2/24.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYNewsCellModel.h"
#import "MJExtension.h"
@implementation GYNewsCellModel

+(NSDictionary*)mj_objectClassInArray{
    
    return @{
             @"imgextra":@"Imgextra",
             @"editor":@"Editor",
             @"ads":@"Ads"
             };
}

@end
