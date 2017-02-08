//
//  GYTitleArrayManager.h
//  tabbar
//
//  Created by hgy on 16/2/29.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GYSegmentView.h"
#import "GYSortItemView.h"
@interface GYTitleArrayManager : NSObject
@property (nonatomic, weak) GYSegmentView *segmentView;
@property (nonatomic, weak) GYSortItemView *sortItemView;
+ (id)shareTitleArrayManager;
- (void)setTitleArray:(NSMutableArray *)titles;
- (void)setSegmentVIewTitleArray:(NSMutableArray *)titles;
- (void)setSortItemViewCurrenItemsArray:(NSMutableArray *)titles;

@end
