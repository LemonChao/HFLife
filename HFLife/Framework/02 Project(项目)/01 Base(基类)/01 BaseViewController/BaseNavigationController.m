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
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBarHidden = YES;
    self.navigationBar.hidden = YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

// statusBar 样式转交给子类自己控制
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

// statusBar hidden转交给子类自己控制
- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}




@end
