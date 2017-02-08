//
//  GYProfileItem.m
//  tableview
//
//  Created by hgy on 16/2/19.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYProfileItem.h"

@implementation GYProfileItem
- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title detailTitle:(NSString *)detailTitle destinationControllerClass:(Class)destinationControllerClass
{
    if (self = [super init]) {
        self.icon = icon;
        self.title = title;
        self.detailTitle = detailTitle;
        self.destinationControllerClass = destinationControllerClass;
    }
    return self;
}
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title detailTitle:(NSString *)detailTitle destinationControllerClass:(Class)destinationControllerClass
{
    return [[self alloc]initWithIcon:icon title:title detailTitle:detailTitle destinationControllerClass:destinationControllerClass];
}
@end
