//
//  ZCShopWebViewController.h
//  HFLife
//
//  Created by zchao on 2019/5/28.
//  Copyright © 2019 luyukeji. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface ZCShopWebViewController : BaseViewController

/**
 是否隐藏返回按钮
 */
@property (nonatomic,assign)BOOL isHidenLeft;
/** 是否从状态栏开始布局 NO:是的 YES：不是*/
@property (nonatomic,assign)BOOL isTop;
/** 直接加载URLString*/
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


/** 顶部间距 */
@property(nonatomic, assign) CGFloat topInset;
/** 底部间距 */
@property(nonatomic, assign) CGFloat bottomInset;
/** h5 页面路径*/
@property(nonatomic, copy) NSString *pathForH5;
/** h5 页面参数*/
@property(nonatomic, copy) NSDictionary *parameters;

- (instancetype)initWithPath:(NSString *)path parameters:(nullable NSDictionary *)parameters;


@end

NS_ASSUME_NONNULL_END
