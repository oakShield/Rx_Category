//
//  GYTitleArrayManager.m
//  tabbar
//
//  Created by hgy on 16/2/29.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYTitleArrayManager.h"
@interface GYTitleArrayManager()
@property (nonatomic, strong) NSMutableArray *titles;
@end
@implementation GYTitleArrayManager
- (NSMutableArray *)titles{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}
+ (id)shareTitleArrayManager{
    static GYTitleArrayManager *manger = nil;
    if (manger == nil) {
        manger = [[GYTitleArrayManager alloc]init];
    }
    return manger;
}
-(void)setTitleArray:(NSMutableArray *)titles
{
    _titles = titles;
    self.segmentView.titleArray = titles;
    self.sortItemView.currentItemsArray = titles;
}
- (void)setSegmentVIewTitleArray:(NSMutableArray *)titles
{
    _titles = titles;
    self.segmentView.titleArray = titles;
}
- (void)setSortItemViewCurrenItemsArray:(NSMutableArray *)titles
{
    _titles = titles;
    self.sortItemView.currentItemsArray = titles;

}
@end
