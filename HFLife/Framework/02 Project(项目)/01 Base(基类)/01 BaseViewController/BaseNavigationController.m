//
//  TFCNavigationController.m
//  TFC
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏
//    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    setBtn.frame = CGRectMake(0, 0, 10, 19);
//    [setBtn setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
//    [setBtn addTarget:self action:@selector(popToBack) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:setBtn];
//    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationBarHidden = YES;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if (@available(iOS 11.0, *)) {
        self.navigationBar.prefersLargeTitles = YES;
    }
}

- (void)popToBack
{
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}
//Interface的方向是否会跟随设备方向自动旋转，如果返回NO,后两个方法不会再调用
-(BOOL)shouldAutorotate{
    return NO;
}
@end
