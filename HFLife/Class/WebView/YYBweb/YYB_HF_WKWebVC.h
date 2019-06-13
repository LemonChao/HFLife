//
//  YYB_HF_WKWebVC.h
//  HFLife
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 luyukeji. All rights reserved.
//
#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface YYB_HF_WKWebVC : BaseViewController

/**
 选择城市
 */
@property(nonatomic, copy) void (^choiceCity)(NSString *city);


/** 直接加载URL*/
@property (nonatomic,copy)NSString *urlString;

/**拼接的URL参数*/
@property (nonatomic,copy)NSString *jointParameter;

/**文件名*/
@property (nonatomic,copy)NSString *fileName;
/**文件夹名*/
@property (nonatomic,copy)NSString *folderName;

/**
 刷新webview
 */
-(void)refreshWebView;
@end

NS_ASSUME_NONNULL_END
