//
//  ShopTabbarViewController.m
//  HFLife
//
//  Created by zchao on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "ShopTabbarViewController.h"
#import "ZC_HF_ShopHomeVC.h"
#import "ZC_HF_ShopClassifyVC.h"
#import "ZC_HF_ShopCartVC.h"
#import "ZC_HF_ShopOrderVC.h"
#import "sxfTouchBtn.h"
@interface ShopTabbarViewController ()<JMTabBarDelegate>

@end

@implementation ShopTabbarViewController


+ (ShopTabbarViewController *)configerTableBarVC {
    
    BaseNavigationController *homeNav = [[BaseNavigationController alloc] initWithRootViewController:[ZC_HF_ShopHomeVC new]];
    BaseNavigationController *classifyNav = [[BaseNavigationController alloc] initWithRootViewController:[ZC_HF_ShopClassifyVC new]];
    BaseNavigationController *cartNav = [[BaseNavigationController alloc] initWithRootViewController:[ZC_HF_ShopCartVC new]];
    BaseNavigationController *orderNav = [[BaseNavigationController alloc] initWithRootViewController:[ZC_HF_ShopOrderVC new]];

    NSArray *titleArr = @[@"首页",@"分类",@"购物车", @"订单中心"];
    NSArray *imageNormalArr = @[@"shop_home_normal",@"shop_classify_normal",@"shop_cart_normal", @"shop_order_normal"];
    NSArray *imageSelectedArr = @[@"shop_home_select",@"shop_classify_select",@"shop_cart_select",  @"shop_order_select"];
    NSArray *controllerArr = @[homeNav,classifyNav,cartNav,orderNav];
    
    //配置信息
    JMConfig *config = [JMConfig config];
    config.norTitleColor = HEX_COLOR(0x131313);
    config.selTitleColor = HEX_COLOR(0xCA1400);
    config.titleFont = 11.0f;
    config.titleOffset = -2;
    config.animType = JMConfigTabBarAnimTypeNormal;
    config.tabBarAnimType = JMConfigTabBarAnimTypeNormal;
    config.isFollow = NO;
    config.isClearTabBarTopLine = NO;
    
    ShopTabbarViewController *tabBarVc = [[ShopTabbarViewController alloc] initWithTabBarControllers:controllerArr NorImageArr:imageNormalArr SelImageArr:imageSelectedArr TitleArr:titleArr Config:config];
    tabBarVc.JM_TabBar.myDelegate = tabBarVc;
    
    sxfTouchBtn *btn = [sxfTouchBtn buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"shop_hanfu"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"shop_hanfu"] forState:UIControlStateSelected];
    [btn setTitle:@"返回首页" forState:UIControlStateNormal];
    [btn setTitle:@"返回首页" forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:10.f];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width / 4;
    btn.frame = CGRectMake(0, 0, btnW, tabBarVc.JM_TabBar.frame.size.height);
    [btn tabBarItem_setImagePosition:ImagePositionTypeTop spacing:4.f];

    [config addCustomBtn:btn AtIndex:2 BtnClickBlock:^(UIButton *btn, NSInteger index) {
        [[JMConfig config].tabBarController dismissViewControllerAnimated:YES completion:^{
            JMConfig *config = [JMConfig config];
            config.norTitleColor = HEX_COLOR(0xAAAAAA);
            config.selTitleColor = HEX_COLOR(0xCA1400);
        }];
    }];

    return tabBarVc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)tabBar:(JMTabBar *)tabBar didSelectIndex:(NSInteger)selectIndex {
    self.selectedIndex = selectIndex;
}

@end
