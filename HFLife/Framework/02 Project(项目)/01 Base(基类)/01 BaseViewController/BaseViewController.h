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

@property (nonatomic, assign)NSInteger limitCount;//限制输入框小数点h后的位数
@property (nonatomic, assign)BOOL firstType;//手位数字是否可以为0


- (void)setupNavBar;
//2.2.3 显示自定义加载框
-(void)showLoadingToastView;
-(void)dismissLoadingToastView;




/**
 版本更新
 */
-(void)VersionBounced;

/**
 请求是否更新
 */
-(void)versionUpdateRequest;



/** 计算手续费*/
-(NSString *)computingCharge:(NSString *)percentage amount:(NSString *)amount;

/** 交易密码处理*/
-(BOOL)TransactionPasswordProcessing;
/**
 *  限制UITextField输入小数点后几位（在- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string 方法里调用）
 */
-(BOOL)limiTtextFled:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;


/**
 计算cell高度

 @return <#return value description#>
 */
- (CGFloat)cellContentViewWith;

@end
