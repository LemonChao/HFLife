//
//  customTabBarViewController.m
//  HRFramework
//
//  Created by sxf_pro on 2018/5/3.
//

#import "customTabBarViewController.h"
#import "BaseNavigationController.h"//自定义导航栏
#import "HomePageVC.h"
#import "NearPageVC.h"
#import "ShopPageVC.h"
#import "VRMarket.h"
#import "MainPageVC.h"
@interface customTabBarViewController ()<JMTabBarDelegate>

@end

@implementation customTabBarViewController
+ (customTabBarViewController *) configerTableBarVC{
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"首页",@"线上商城",@"本地服务", @"VR商城", @"我的", nil];
    NSMutableArray *imageNormalArr = [NSMutableArray arrayWithObjects:@"shouye_weixuanzhong",@"shangcheng_weixuanzhong",@"faxianweixuanzhong",@"vr_weixuanzhong", @"wode_weixuanzhong", nil];
    NSMutableArray *imageSelectedArr = [NSMutableArray arrayWithObjects:@"shouye_xuanzhong",@"shangcheng_weixuanzhong",@"faxian_xuanzhong", @"vr_xuanzhong", @"wode_xuanzhong",  nil];
    NSMutableArray *controllersArr = [NSMutableArray array];
    
    //这里添加需要的控制器
    HomePageVC *homeVC = [[HomePageVC alloc] init];
    BaseNavigationController *homeNav = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
    [homeVC.customNavBar wr_setLeftButtonWithNormal:image(@"") highlighted:image(@"")];
    [controllersArr addObject:homeNav];

    
    ShopPageVC *shopVC = [[ShopPageVC alloc] init];
    BaseNavigationController *shopNav = [[BaseNavigationController alloc] initWithRootViewController:shopVC];
    [shopVC.customNavBar wr_setLeftButtonWithNormal:image(@"") highlighted:image(@"")];
    [controllersArr addObject:shopNav];
    
    
    NearPageVC *nearVC = [[NearPageVC alloc] init];
    BaseNavigationController *naerNav = [[BaseNavigationController alloc] initWithRootViewController:nearVC];
    [nearVC.customNavBar wr_setLeftButtonWithNormal:image(@"") highlighted:image(@"")];
    [controllersArr addObject:naerNav];
    
    VRMarket *vrVC = [[VRMarket alloc] init];
    BaseNavigationController *vrNav = [[BaseNavigationController alloc] initWithRootViewController:vrVC];
    [vrVC.customNavBar wr_setLeftButtonWithNormal:image(@"") highlighted:image(@"")];
    [controllersArr addObject:vrNav];
    
    
    MainPageVC *mainVC = [[MainPageVC alloc] init];
    BaseNavigationController *mainNav = [[BaseNavigationController alloc] initWithRootViewController:mainVC];
    [mainVC.customNavBar wr_setLeftButtonWithNormal:image(@"") highlighted:image(@"")];
    [controllersArr addObject:mainNav];
    
    
    //初始化配置信息
    JMConfig *config = [JMConfig config];
    
    config.norTitleColor = HEX_COLOR(0x666666);
    config.selTitleColor = HEX_COLOR(0x7C02F2);
    config.titleFont = 10.0f;
    config.titleOffset = -2;
    config.animType = JMConfigTabBarAnimTypeRotationY;
    config.tabBarAnimType = JMConfigTabBarAnimTypeBoundsMax;
    config.isFollow = NO;
    config.isClearTabBarTopLine = NO;
    config.tabBarTopLineColor = [UIColor groupTableViewBackgroundColor];
    customTabBarViewController *tabBarVc = [[customTabBarViewController alloc] initWithTabBarControllers:controllersArr NorImageArr:imageNormalArr SelImageArr:imageSelectedArr TitleArr:titleArr Config:config];
    tabBarVc.JM_TabBar.myDelegate = tabBarVc;
    return tabBarVc;
}
- (void)tabBar:(JMTabBar *)tabBar didSelectIndex:(NSInteger)selectIndex {
    self.selectedIndex = selectIndex;
    NSLog(@"----%ld", selectIndex);
}
@end
