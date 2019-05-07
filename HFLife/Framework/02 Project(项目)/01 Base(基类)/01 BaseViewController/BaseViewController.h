//
//  ParentViewController.h
//  DuDuJR
//
//  Created by sxf on 2017/11/7.
//  Copyright © 2017年 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRCustomNavigationBar.h"
#import "WRNavigationBar.h"
@interface BaseViewController : UIViewController
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;

/**
 数据参数
 */
@property (nonatomic,assign)id dataParameter;
/**
 *  屏幕高
 */
@property(nonatomic,assign)CGFloat screenHight;

/**
 *  屏幕宽
 */
@property(nonatomic,assign)CGFloat screenWidth;
/**
 *  状态栏高
 */
@property(nonatomic,assign)CGFloat heightStatus;

/**
 *  导航栏高
 */
@property(nonatomic,assign)CGFloat navBarHeight;
/**
 *  底部tab高
 */
@property(nonatomic,assign)CGFloat tabBarHeight;




- (void)setupNavBar;
//2.2.3 显示自定义加载框
-(void)showLoadingToastView;
-(void)dismissLoadingToastView;

@end
