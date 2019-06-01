//
//  JMTabBarController.m
//  JMTabBarController
//
//  Created by JM on 2017/12/26.
//  Copyright © 2017年 JM. All rights reserved.
//
// github: https://github.com/JunAILiang
// blog: https://www.ljmvip.cn

#import "JMTabBarController.h"

@interface JMTabBarController ()<JMTabBarDelegate>

@end

@implementation JMTabBarController

- (instancetype)initWithTabBarControllers:(NSArray *)controllers NorImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config:(JMConfig *)config{
    self = [super init];
    self.viewControllers = controllers;
    self.JM_TabBar = [[JMTabBar alloc] initWithFrame:self.tabBar.frame norImageArr:norImageArr SelImageArr:selImageArr TitleArr:titleArr Config:config];
    self.JM_TabBar.myDelegate = self;
    
    [self setValue:self.JM_TabBar forKeyPath:@"tabBar"];

    
    [JMConfig config].tabBarController = self;
    
    //KVO
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    self.JM_TabBar.selectedIndex = 0;
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSInteger selectedIndex = [change[@"new"] integerValue];
    self.JM_TabBar.selectedIndex = selectedIndex;
}

- (void)tabBar:(JMTabBar *)tabBar didSelectIndex:(NSInteger)selectIndex {
    self.selectedIndex = selectIndex;
    
    
    
    /*自定义按钮*/
    /*
    if (self.selectedIndex == 1) {
        [JMConfig config].customBtn.userInteractionEnabled = NO;
        [JMConfig config].customBtn.hidden = YES;
    }else{
        [JMConfig config].customBtn.hidden = NO;
        [JMConfig config].customBtn.userInteractionEnabled = YES;
    }
    */
    
    
}

- (void)dealloc {
    JMLog(@"被销毁了");
    [self removeObserver:self forKeyPath:@"selectedIndex"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.selectedViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.selectedViewController;
}


@end
