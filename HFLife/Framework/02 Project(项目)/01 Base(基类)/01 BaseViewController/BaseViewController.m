//
//  ParentViewController.m
//  DuDuJR
//
//  Created by sxf on 2017/11/7.
//  Copyright © 2017年 sxf. All rights reserved.
//

#import "BaseViewController.h"
#import "JQToastWindow.h"
//网络状态
typedef enum NetStatus
{
    WIFI = 0,
    MOBEL,
    BASY,
    NONET
}NetStatus;
@interface BaseViewController ()<UINavigationControllerDelegate>
@property (nonatomic ,copy) NSMutableString *savetitle;
@property (nonatomic,strong)JQToastWindow * loadingToastView;//自定义加载框
//@property (nonatomic ,strong) NSTimer *timer;

@end

@implementation BaseViewController
-(JQToastWindow *)loadingToastView
{
    if (!_loadingToastView) {
        _loadingToastView  = XIB(JQToastWindow);
        _loadingToastView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    }
    return _loadingToastView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    [self setupNavBar];
}

- (void)setupNavBar
{
    [self.view addSubview:self.customNavBar];
    
    // 设置自定义导航栏背景图片
//    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"navi_bg"];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    // 设置自定义导航栏标题颜色
    self.customNavBar.titleLabelColor = HEX_COLOR(0x0C0B0B);
    
    if (self.navigationController.childViewControllers.count != 1) {
        for (UIViewController *vc in self.navigationController.childViewControllers) {
            NSLog(@"vc = %@", NSStringFromClass([vc class]));
        }
        if (self != self.navigationController.childViewControllers.firstObject) {
            [self.customNavBar wr_setLeftButtonWithNormal:image(@"back_white") highlighted:image(@"back_white")];
        }else{
            
        }
        
    }
    // 设置初始导航栏透明度
    [self wr_setNavBarBackgroundAlpha:0];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.view addSubview:self.customNavBar];
}
/**
 *  懒加载赋值屏幕高
 *
 *  @return 屏幕高
 */
- (CGFloat )screenHight{
    if (_screenHight == 0) {
        _screenHight = [UIScreen mainScreen].bounds.size.height;
    }
    return _screenHight;
}
/**
 *  懒加载赋值屏幕宽
 *
 *  @return 屏幕宽
 */
- (CGFloat )screenWidth{
    if (_screenWidth == 0) {
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return _screenWidth;
}
- (CGFloat )heightStatus{
    if (_heightStatus == 0) {
        _heightStatus = HeightStatus;
    }
    return _heightStatus;
}
- (CGFloat )navBarHeight{
    if (_navBarHeight == 0) {
        _navBarHeight = NavBarHeight;
    }
    return _navBarHeight;
}
- (CGFloat)tabBarHeight{
    if (_tabBarHeight == 0) {
        _tabBarHeight = TabBarHeight;
    }
    return _tabBarHeight;
}
- (WRCustomNavigationBar *)customNavBar
{
    if (_customNavBar == nil) {
        _customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    }
    return _customNavBar;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.view addSubview:self.customNavBar];
    //百度单页面统计
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   
    
    //百度单页面统计
//    [[BaiduMobStat defaultStat] pageviewEndWithName:self.title];
 }



//显示自定义加载框
-(void)showLoadingToastView
{
    [self.loadingToastView showToast];
}
//隐藏加载框
-(void)dismissLoadingToastView
{
    [self.loadingToastView hiddenToast];
    self.loadingToastView = nil;
}

//网络状态通知
- (void) netStatus:(NSNotification *)notification{
    NSLog(@"--网络状态%@" , notification.object);
    switch ([notification.object integerValue]) {
        case WIFI:
            
            break;
        case MOBEL:
            
            break;
        case BASY:
            
            break;
        case NONET:
            
            break;
        default:
            break;
    }
}














//通过rgb创建图片
- (UIImage *)imageWithRGBColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
