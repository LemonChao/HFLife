//
//  NSObject+currentController.m
//  HFLife
//
//  Created by mac on 2019/5/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "NSObject+currentController.h"

@implementation NSObject (currentController)
//获取当前页面控制器
- (UIViewController *)getCurrentViewController{
    UIViewController* currentViewController = [self getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    if ([currentViewController isKindOfClass:[BaseViewController class]]) {
        BaseViewController *vc = (BaseViewController *)currentViewController;
        vc.customNavBar.hidden = YES;
    }
    return currentViewController;
}

//获取根控制器
- (UIViewController *)getRootViewController{
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}
/** 跳转登录 */
- (void)loginVC {
    //跳转登录
    
    Class loginClass = NSClassFromString(@"LoginVC");
    id loginVC = [[loginClass alloc] init];
    if (loginVC && ![loginClass isKindOfClass:[self class]]) {
        UIViewController *currentVC = [self getCurrentViewController];
        BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        [currentVC presentViewController:navi animated:YES completion:nil];
    }else{
        
        [CustomPromptBox showTextHud:@"您还未创建登录VC"];
    }
}

@end
