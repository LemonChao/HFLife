//
//  TFCTabBarController.m
//  TFC
//
//  Created by 张海彬 on 2018/6/8.
//  Copyright © 2018年 张海彬. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
/** 导航栏 */
#import <WRNavigationBar/WRNavigationBar.h>

#import "FinancialVC.h"
#import "BonusOrePoolVC.h"
#import "ProjectAllianceVC.h"
#import "MyGcdVC.h"
#import "TFCShopVC.h"

#import "RankingVC.h"
@interface BaseTabBarController ()<AxcAE_TabBarDelegate>
{
    NSArray *titleArray;
    NSInteger selsctIndex;
}
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //覆盖原生Tabbar的上横线
//      [[UITabBar appearance] setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
//    //背景图片为透明色
//      [[UITabBar appearance] setBackgroundImage:[self createImageWithColor:[UIColor clearColor]]];
//    self.tabBar.backgroundColor = [UIColor clearColor];
    self.tabBar.backgroundImage = [self createImageWithColor:[UIColor clearColor]];
    self.tabBar.shadowImage = [[UIImage alloc]init];
    //设置为半透明
    self.tabBarController.tabBar.translucent = YES;
    // 初始化所有控制器
//    [self setUpChildVC];
    titleArray = @[@"TOP排名",@"商店",@"财务中心",@"项目联盟",@"我的"];
    [self addChildViewControllers];
    // 创建tabbar中间的tabbarItem
    [self setUpMidelTabbarItem];
    [self setNavBarAppearence];
//    [self.tabBar setBackgroundImage:MMGetImage(@"background1")];
}

#pragma mark -创建tabbar中间的tabbarItem

- (void)setUpMidelTabbarItem {
    
//    TBTabBar *tabBar = [[TBTabBar alloc] init];
//    [self setValue:tabBar forKey:@"tabBar"];
//
//    __weak typeof(self) weakSelf = self;
//    [tabBar setDidClickPublishBtn:^{
//
//        TBPlusViewController *hmpositionVC = [[TBPlusViewController alloc] init];
//        TBNavigationController *nav = [[TBNavigationController alloc] initWithRootViewController:hmpositionVC];
//        [weakSelf presentViewController:nav animated:YES completion:nil];
//
//    }];
    
}

#pragma mark -初始化所有控制器

- (void)setUpChildVC {
    
    FinancialVC *homeVC = [[FinancialVC alloc] init];
    [self setChildVC:homeVC title:@"财务中心" image:@"tabbar_voucher_normal" selectedImage:@"tabbar_voucher_select"];
//
    BonusOrePoolVC *bonusVC = [[BonusOrePoolVC alloc] init];
    [self setChildVC:bonusVC title:@"奖金矿池" image:@"tabbar_find_normal" selectedImage:@"tabbar_find_select"];
//
    ProjectAllianceVC *projectAllVC = [[ProjectAllianceVC alloc] init];
    [self setChildVC:projectAllVC title:@"项目联盟" image:@"tabbar_home_normal" selectedImage:@"tabbar_home_select"];
    
    MyGcdVC *myGcd = [[MyGcdVC alloc] init];
    [self setChildVC:myGcd title:@"我的" image:@"tabbar_my_normal" selectedImage:@"tabbar_my_select"];
    
}
- (void)addChildViewControllers{
    // 创建选项卡的数据 想怎么写看自己，这块我就写笨点了
    
    NSArray <NSDictionary *>*VCArray =
    @[@{@"vc":[RankingVC new],@"normalImg":@"TOP",@"selectImg":@"TOPSelect",@"itemTitle":@"TOP排名"},
      @{@"vc":[TFCShopVC new],@"normalImg":@"shangdian",@"selectImg":@"shangdian1",@"itemTitle":@"商城"},
      @{@"vc":[FinancialVC new],@"normalImg":@"caiwu",@"selectImg":@"caiwuzhongxin",@"itemTitle":@"财务中心"},
      @{@"vc":[ProjectAllianceVC new],@"normalImg":@"lianm",@"selectImg":@"lianmeng",@"itemTitle":@"线下联盟"},
      @{@"vc":[MyGcdVC new],@"normalImg":@"gerenzhongxin",@"selectImg":@"geren",@"itemTitle":@"我的"}];
//
    // 1.遍历这个集合
    // 1.1 设置一个保存构造器的数组
    NSMutableArray *tabBarConfs = @[].mutableCopy;
    // 1.2 设置一个保存VC的数组
    NSMutableArray *tabBarVCs = @[].mutableCopy;
    [VCArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 2.根据集合来创建TabBar构造器
        AxcAE_TabBarConfigModel *model = [AxcAE_TabBarConfigModel new];
        // 3.item基础数据三连
        model.itemTitle = [obj objectForKey:@"itemTitle"];
        model.selectImageName = [obj objectForKey:@"selectImg"];
        model.normalImageName = [obj objectForKey:@"normalImg"];
        // 4.设置单个选中item标题状态下的颜色
        model.selectColor = HEX_COLOR(0x149DC7);
        model.normalColor = HEX_COLOR(0x408B9E);
//        model.isRepeatClick = YES;//是否重复动画
//        model.interactionEffectStyle = AxcAE_TabBarInteractionEffectStyleSpring;//动画样式
        
        // 示例中为了方便就在这写了
        UIViewController *vc = [obj objectForKey:@"vc"];
        // 5.将VC添加到系统控制组
        [tabBarVCs addObject:[self setChildVC:vc title:[obj objectForKey:@"itemTitle"] image:@"" selectedImage:@""]];
        // 5.1添加构造Model到集合
        [tabBarConfs addObject:model];
    }];
    // 5.2 设置VCs -----
    // 一定要先设置这一步，然后再进行后边的顺序，因为系统只有在setViewControllers函数后才不会再次创建UIBarButtonItem，以免造成遮挡
    // 大意就是一定要让自定义TabBar遮挡住系统的TabBar
    self.viewControllers = tabBarVCs;
    //////////////////////////////////////////////////////////////////////////
    // 注：这里方便阅读就将AE_TabBar放在这里实例化了 使用懒加载也行
    // 6.将自定义的覆盖到原来的tabBar上面
    // 这里有两种实例化方案：
    // 6.1 使用重载构造函数方式：
    //    self.axcTabBar = [[AxcAE_TabBar alloc] initWithTabBarConfig:tabBarConfs];
    // 6.2 使用Set方式：
    self.axcTabBar = [AxcAE_TabBar new] ;
    self.axcTabBar.tabBarConfig = tabBarConfs;
    // 7.设置委托
    self.axcTabBar.delegate = self;
    // DEMO 设置背景图片
    /******************************************************************************/
//    self.axcTabBar.backgroundImageView.backgroundColor = [UIColor clearColor];
    self.axcTabBar.backgroundImageView.image = [UIImage imageNamed:@"daohang"];
//    self.axcTabBar.maskBackgroundImageView.image = [UIImage imageNamed:@"68.png"];
//    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"68.png"]];
    self.axcTabBar.backgroundColor = [UIColor blackColor];
    /******************************************************************************/
    // 8.添加覆盖到上边
    [self.tabBar addSubview:self.axcTabBar];
//    [self addLayoutTabBar]; // 10.添加适配
  
}
-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
#pragma mark ==代理===
//第一点击对应的tabbar调用
- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
    NSString *title = titleArray[index];
    if ([title isEqualToString:@"商店"]||[title isEqualToString:@"项目联盟"]) {
        [WXZTipView showCenterWithText:@"该板块还未开放"];
        [self setSelectedIndex:selsctIndex];
    }else{
         selsctIndex = index;
        // 通知 切换视图控制器
        [self setSelectedIndex:index];
        [self animationWithIndex:index];
    }
   
    // 自定义的AE_TabBar回调点击事件给TabBarVC，TabBarVC用父类的TabBarController函数完成切换
}
//重复点击调用
-(void)axcAE_RepeatClickTabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
    
    [self animationWithIndex:index];
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
   
    if(self.axcTabBar){
        
        self.axcTabBar.selectIndex = selectedIndex;
    }
}
- (BaseNavigationController *) setChildVC:(UIViewController *)childVC title:(NSString *) title image:(NSString *) image selectedImage:(NSString *) selectedImage {
    
    childVC.tabBarItem.title = title;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
//    HEX_COLOR(0x4a80f7)
    NSMutableDictionary *selectDict = [NSMutableDictionary dictionary];
    selectDict[NSForegroundColorAttributeName] = HEX_COLOR(0x4a80f7);
    selectDict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVC.tabBarItem setTitleTextAttributes:selectDict forState:UIControlStateSelected];
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
//    [self addChildViewController:nav];
    return nav;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"item name = %@", item.title);
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self animationWithIndex:index];
    if([item.title isEqualToString:@"发现"])
    {
        
    }
}
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.axcTabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"AxcAE_TabBarItem")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
}
-(void)setNavBarAppearence
{
    //    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]}];
    //    [UINavigationBar appearance].tintColor = [UIColor yellowColor];
    //    [UINavigationBar appearance].barTintColor = [UIColor redColor];
    
    
    // 设置是 广泛使用WRNavigationBar，还是局部使用WRNavigationBar，目前默认是广泛使用
    [WRNavigationBar wr_widely];
    //    [WRNavigationBar wr_setBlacklist:@[@"SpecialController",
    //                                       @"TZPhotoPickerController",
    //                                       @"TZGifPhotoPreviewController",
    //                                       @"TZAlbumPickerController",
    //                                       @"TZPhotoPreviewController",
    //                                       @"TZVideoPlayerController"]];
    
    // 设置导航栏默认的背景颜色 [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]HEX_COLOR(0x54a8dd)
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:SUBJECTCOLOR];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:NO];
}
//Interface的方向是否会跟随设备方向自动旋转，如果返回NO,后两个方法不会再调用
-(BOOL)shouldAutorotate{
    return NO;
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.axcTabBar.frame = self.tabBar.bounds;
    [self.axcTabBar viewDidLayoutItems];
}
@end
