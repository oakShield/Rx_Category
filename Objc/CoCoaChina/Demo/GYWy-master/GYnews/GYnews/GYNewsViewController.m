//
//  GYNewsViewController.m
//  tabbar
//
//  Created by hgy on 16/2/25.
//  Copyright © 2016年 hgy. All rights reserved.
//

#define GYaddButton 40
#define GYSegmentScrollMargin 30
#define GYSegmentHeight 44
#define GYSegmentMargin 10
#define GYTitleSelecterColor [UIColor redColor]
#define GYTitleNormalColor [UIColor blackColor]
#import "GYNewsViewController.h"
#import "UIView+Extension.h"
#import "GYNewsTableView.h"
#import "Constants.h"
#import "GYNewsCarouselView.h"
#import "GYNewsDetailViewController.h"
@interface GYNewsViewController()

@property (nonatomic,strong) GYNewsCarouselView *newsCarouselView;
@property (nonatomic,strong) NSMutableArray *titleList;

@end

@implementation GYNewsViewController
- (GYNewsCarouselView *)newsCarouselView
{
    if (!_newsCarouselView) {
        _newsCarouselView = [[GYNewsCarouselView alloc]init];
    }
    return _newsCarouselView;
}

- (NSMutableArray *)titleList
{
    if (!_titleList) {
        _titleList = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"NewsURLs.plist" ofType:nil]];
    }
    return _titleList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNotificationCenter];
    GYNewsCarouselView *carousel = [[GYNewsCarouselView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    carousel.titleList = self.titleList;
    [self.view addSubview:carousel];
  

 
    
}

- (void)initNotificationCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableviewClick:) name:GYNewsTablecellClickNotification object:nil];
   }
- (void)tableviewClick:(NSNotification *)noti
{
   
    
    GYNewsDetailViewController *vc = [[GYNewsDetailViewController alloc] init];
    vc.newsmodel = noti.object;
   
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
