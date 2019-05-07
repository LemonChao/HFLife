//
//  GCTViewController.h
//  GCT
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
//#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController : BaseViewController
/** 标题*/
@property (nonatomic,strong)NSString *titleVC;
/** 本地HTML资源 fileName：文件名 folderName：文件夹名 url:地址（网络）*/
@property (nonatomic,strong)NSDictionary *localHTMLResources;
/** 类型*/
@property (nonatomic,strong)NSString *type;

@end
