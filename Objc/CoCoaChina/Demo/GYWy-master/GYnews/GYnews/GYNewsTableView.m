//
//  GYNewsTableView.m
//  tabbar
//
//  Created by hgy on 16/2/26.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "Constants.h"
#import "GYNewsTableView.h"
#import "MJRefresh.h"
#import "XYString.h"
#import "UIImage+GIF.h"
#import "UIView+Extension.h"
#import "AFNetworking.h"
#import "GYNewsCellModel.h"
#import "MJExtension.h"
#import "GYNewsBaseCell.h"
#import "GYNewsFirstCell.h"
#import "GYNewsSecondCell.h"
#import "GYNewsThirdCell.h"
#import "GYNewsFourthCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
@interface GYNewsTableView()<UITableViewDelegate,UITableViewDataSource>
{
 MJRefreshComponent *myRefreshView;
     NSInteger page;
}

@end
@implementation GYNewsTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
         self.separatorColor = [UIColor clearColor];
        //..下拉刷新
//        self.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
//            
//            myRefreshView = self.mj_header;
//            myRefreshView.automaticallyChangeAlpha = YES;
//            [self loadData];
//        }];
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        
        // 设置文字
        [header setTitle:@"刚刚刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"刚刚刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
        header.lastUpdatedTimeLabel.hidden = YES;
        // 设置字体
        header.stateLabel.font = [UIFont systemFontOfSize:10];
        // 设置颜色
        header.stateLabel.textColor = [UIColor grayColor];
//        
//        UIImage *gif = [UIImage sd_animatedGIFNamed:@"circle"];
//        NSArray *imgs = [[NSArray alloc]init];
//        imgs = @[gif];
//        //设置GIF状态 要设置位置再点进去改
//        [header setImages:imgs forState:MJRefreshStateIdle];
//        [header setImages:imgs forState:MJRefreshStatePulling];
        
        
        // 马上进入刷新状态
        [header beginRefreshing];
        
        // 设置刷新控件
        self.mj_header = header;
        myRefreshView = self.mj_header;
        //..上拉刷新
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            page = page + 10;
            myRefreshView = self.mj_footer;
            [self loadData];
        }];
        self.mj_footer.hidden = YES;
        
        
    }
    return self;

    

}

- (void)setTitle:(NSString *)title
{
    _title = title;
}
- (void)loadData{
    
    NSString * urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/%ld-10.html",self.title,page];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [XYString getObjectFromJsonString:operation.responseString];
        
        NSString *key = [dict.keyEnumerator nextObject];//.取键值
        
        NSArray *temArray = dict[key];
        
        // 数组>>model数组
        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:[GYNewsCellModel mj_objectArrayWithKeyValuesArray:temArray]];
        
        if (myRefreshView == self.mj_header) {
            self.listArry = arrayM;
            self.mj_footer.hidden = self.listArry.count==0?YES:NO;
            
        }else if(myRefreshView == self.mj_footer){
            [self.listArry addObjectsFromArray:arrayM];
        }
        
        [self reloadData];
        [myRefreshView endRefreshing];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败");
        [myRefreshView endRefreshing];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    
    return self.listArry.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GYNewsBaseCell * cell = nil;
    GYNewsCellModel * newsModel = self.listArry[indexPath.row];
    
    NSString * identifier = [GYNewsBaseCell cellIdentifierForRow:newsModel];
    Class mClass =  NSClassFromString(identifier);
    
    cell =  [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[mClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.newsModel = newsModel;
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GYNewsCellModel * newsModel = self.listArry[indexPath.row];
    NSLog(@"didSelectRowAtIndexPath");
    [[NSNotificationCenter defaultCenter] postNotificationName:GYNewsTablecellClickNotification object:newsModel];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{     GYNewsCellModel * newsModel = self.listArry[indexPath.row];
    
    NSString * identifier = [GYNewsBaseCell cellIdentifierForRow:newsModel];
    Class mClass =  NSClassFromString(identifier);
    
    // 返回计算出的cell高度（普通简化版方法，同样只需一步设置即可完成）
    return [self cellHeightForIndexPath:indexPath model:newsModel keyPath:@"newsModel" cellClass:mClass contentViewWidth:[self cellContentViewWith]];
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
@end
