//
//  GYProfileItem.h
//  tableview
//
//  Created by hgy on 16/2/19.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYProfileItem : NSObject
@property(nonatomic,copy) NSString *icon;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *detailTitle;
@property (nonatomic, copy) Class destinationControllerClass;
- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title detailTitle:(NSString *)detailTitle destinationControllerClass:(Class)destinationControllerClass;


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title detailTitle:(NSString *)detailTitle destinationControllerClass:(Class)destinationControllerClass;
@end
