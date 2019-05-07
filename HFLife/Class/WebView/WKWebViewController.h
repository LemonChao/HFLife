//
//  WKWebViewController.h
//  WKWebViewMessageHandlerDemo
//
//  Created by reborn on 16/9/12.
//  Copyright © 2016年 reborn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface WKWebViewController : BaseViewController

/**
 是否隐藏返回按钮
 */
@property (nonatomic,assign)BOOL isHidenLeft;
/** 是否从状态栏开始布局 NO:是的 YES：不是*/
@property (nonatomic,assign)BOOL isTop;
/** 直接加载URL*/
@property (nonatomic,copy)NSString *urlString;
/**拼接的URL参数*/
@property (nonatomic,copy)NSString *jointParameter;
/**文件名*/
@property (nonatomic,copy)NSString *fileName;
/**导航隐藏*/
@property (nonatomic,assign)BOOL isNavigationHidden;
/** 标题 */
@property (nonatomic,copy)NSString *webTitle;
@property (nonatomic,strong)UIColor *titleColor;
/**
 刷新webview
 */
-(void)refreshWebView;
@end
