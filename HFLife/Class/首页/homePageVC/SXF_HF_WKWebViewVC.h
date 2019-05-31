//
//  SXF_HF_WKWebViewVC.h
//  HFLife
//
//  Created by mac on 2019/5/31.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_WKWebViewVC : BaseViewController
/** 直接加载URL*/
@property (nonatomic,copy)NSString *urlString;

/** 标题 */
@property (nonatomic,copy)NSString *webTitle;

@end

NS_ASSUME_NONNULL_END
