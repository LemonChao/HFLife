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
#import "ShopTabbarViewController.h"

@interface customTabBarViewController ()<JMTabBarDelegate>

@end

@implementation customTabBarViewController
{
    NSInteger _selectedIndex;
    NSString *_controllerArr;
}
+ (customTabBarViewController *) configerTableBarVC{
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"首页",@"线上商城",@"本地服务", @"我的", nil];
    NSMutableArray *imageNormalArr = [NSMutableArray arrayWithObjects:@"shouye_weixuanzhong",@"shangcheng_weixuanzhong",@"faxianweixuanzhong", @"wode_weixuanzhong", nil];
    NSMutableArray *imageSelectedArr = [NSMutableArray arrayWithObjects:@"shouye_xuanzhong",@"shangcheng_weixuanzhong",@"faxian_xuanzhong",  @"wode_xuanzhong",  nil];
    NSMutableArray *controllersArr = [NSMutableArray array];
    
    //这里添加需要的控制器
    HomePageVC *homeVC = [[HomePageVC alloc] init];
    BaseNavigationController *homeNav = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
    [homeVC.customNavBar wr_setLeftButtonWithNormal:image(@"") highlighted:image(@"")];
    [controllersArr addObject:homeNav];

    
    BaseViewController *shopVC = [[BaseViewController alloc] init];
    BaseNavigationController *shopNav = [[BaseNavigationController alloc] initWithRootViewController:shopVC];
    [shopVC.customNavBar wr_setLeftButtonWithNormal:image(@"") highlighted:image(@"")];
    [controllersArr addObject:shopNav];
    
    
    NearPageVC *nearVC = [[NearPageVC alloc] init];
    BaseNavigationController *naerNav = [[BaseNavigationController alloc] initWithRootViewController:nearVC];
    [nearVC.customNavBar wr_setLeftButtonWithNormal:image(@"") highlighted:image(@"")];
    [controllersArr addObject:naerNav];
    
//    VRMarket *vrVC = [[VRMarket alloc] init];
//    BaseNavigationController *vrNav = [[BaseNavigationController alloc] initWithRootViewController:vrVC];
//    [vrVC.customNavBar wr_setLeftButtonWithNormal:image(@"") highlighted:image(@"")];
//    [controllersArr addObject:vrNav];
    
    MainPageVC *mainVC = [[MainPageVC alloc] init];
    BaseNavigationController *mainNav = [[BaseNavigationController alloc] initWithRootViewController:mainVC];
    [mainVC.customNavBar wr_setLeftButtonWithNormal:image(@"") highlighted:image(@"")];
    [controllersArr addObject:mainNav];
    
    //5.设置导航栏隐藏
    [[UINavigationBar appearance] setHidden:YES];
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
    
    
    
    UIButton *btn = [[UIButton alloc] init];
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width / 4;
    btn.frame = CGRectMake(0, 0, btnW, tabBarVc.JM_TabBar.frame.size.height);
    btn.backgroundColor = [UIColor clearColor];
    
    [tabBarVc.JM_TabBar addSubview:btn];
    NSLog(@"%@", tabBarVc.JM_TabBar.subviews);
    for (UIView *btnView in tabBarVc.JM_TabBar.subviews) {
        if ([btnView isKindOfClass:[JMTabBarButton class]]) {
            if (btnView.tag == 1) {
                JMTabBarButton *jmbtn = (JMTabBarButton *)btnView;

                [jmbtn removeGestureRecognizer:jmbtn.tap];
                [btn addTarget:nil action:@selector(clickMyBtn:) forControlEvents:UIControlEventTouchUpInside];
                [jmbtn addSubview:btn];
            }
        }
    }
    
    return tabBarVc;
}

- (void) clickMyBtn:(UIButton *)secder{
    
    ShopTabbarViewController *shopTabbarVC = [ShopTabbarViewController configerTableBarVC];
    [self presentViewController:shopTabbarVC animated:YES completion:nil];
}


- (void)tabBar:(JMTabBar *)tabBar didSelectIndex:(NSInteger)selectIndex {
    self.selectedIndex = selectIndex;
    NSLog(@"----%ld", selectIndex);
}
//- (UIViewController *)jsd_getRootViewController{
//
//    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
//    NSAssert(window, @"The window is empty");
//    return window.rootViewController;
//}
//- (UIViewController *)jsd_getCurrentViewController{
//
//    UIViewController* currentViewController = [self jsd_getRootViewController];
//    BOOL runLoopFind = YES;
//    while (runLoopFind) {
//        if (currentViewController.presentedViewController) {
//
//            currentViewController = currentViewController.presentedViewController;
//        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
//
//            UINavigationController* navigationController = (UINavigationController* )currentViewController;
//            currentViewController = [navigationController.childViewControllers lastObject];
//
//        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
//
//            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
//            currentViewController = tabBarController.selectedViewController;
//        } else {
//
//            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
//            if (childViewControllerCount > 0) {
//
//                currentViewController = currentViewController.childViewControllers.lastObject;
//
//                return currentViewController;
//            } else {
//
//                return currentViewController;
//            }
//        }
//
//    }
//    return currentViewController;
//}
@end
