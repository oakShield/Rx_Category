//
//  GYTabBarViewController.m
//  tabbar
//
//  Created by hgy on 16/2/18.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYTabBarViewController.h"
#import "GYNavigationController.h"
#import "UIView+Extension.h"
#import "UIButton+Extension.h"
#import "GYProfileTableViewController.h"
#import "GYNewsViewController.h"
@interface GYTabBarViewController ()
@property (nonatomic,strong) UIView *v1;
@property (nonatomic,strong) UIButton *btn;
@end
@implementation GYTabBarViewController
- (UIButton *)btn
{
    if (!_btn) {
        _btn = [[UIButton alloc]init];
    }
    return _btn;
}
- (UIView *)v1
{
    if (_v1) {
        _v1 = [[UIView alloc]init];
    }
    return _v1;
}
- (void)viewDidLoad
{
   
    [super viewDidLoad];
 

    
   
    self.view.backgroundColor = [UIColor whiteColor];

    GYNewsViewController *new = [[GYNewsViewController alloc]init];
    [self addChildVc:new title:@"新闻" image:@"tabbar_icon_news_normal" selectedImage:@"tabbar_icon_news_highlight"];
    
    UIViewController *messageCenter = [[UIViewController alloc] init];
    [self addChildVc:messageCenter title:@"阅读" image:@"tabbar_icon_media_normal" selectedImage:@"tabbar_icon_media_highlight"];
    UIViewController *found = [[UIViewController alloc]init];
    [self addChildVc:found title:@"发现" image:@"tabbar_icon_found_normal" selectedImage:@"tabbar_icon_found_highlight"];
    UIViewController *discover = [[UIViewController alloc] init];
    [self addChildVc:discover title:@"视听" image:@"tabbar_icon_media_normal" selectedImage:@"tabbar_icon_media_highlight"];
    
    GYProfileTableViewController *profile = [[GYProfileTableViewController alloc] init];
    [self addChildVc:profile title:@"我" image:@"tabbar_icon_me_normal" selectedImage:@"tabbar_icon_me_highlight"];
   

   
    

}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [_btn setImage:[UIImage imageNamed:@"iconfont-delete"] forState:UIControlStateNormal];
//    CABasicAnimation *ani = [CABasicAnimation animation];
//    ani.keyPath = @"transform.rotation.z";
//    ani.byValue = @(M_PI * 2);
//    ani.repeatCount = MAXFLOAT;
//    [_btn.imageView.layer addAnimation:ani forKey:nil];
//}
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title;
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    GYNavigationController *nav = [[GYNavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    UIImage *img = [[UIImage alloc]init];
    
    [nav.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    [nav.navigationBar setBackgroundColor:[UIColor redColor]];
    [self addChildViewController:nav];
}
- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    
    statusBarView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
   
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleBlackOpaque;
}
@end
