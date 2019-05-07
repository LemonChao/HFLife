//
//  ZHFAddTitleAddressView.h
//  ZHFJDAddressOC
//
//  Created by 张海峰 on 2017/12/18.
//  Copyright © 2017年 张海峰. All rights reserved.
// 这是一个自定义仿京东地址选择器。OC版本，（保证集成成功，有不懂的地方可加QQ：991150443 进行讨论。）
// Swift版本地址：https://github.com/FighterLightning/ZHFJDAddress.git
/*该demo的使用须知:
 1.下载该demo。把Address文件拖进项目（里面有一个View（主要），四个model（一个网络，剩下省市区））
 2.pod 'AFNetworking'//网络请求
 pod 'YYModel' //字典转模型
 3.把以下代码添加进自己的控制器方可使用,注意顺序，网络请求看ZHFAddTitleAddressView.m头部注释根据需求进行修改
 4.如果感觉有帮助，不要吝啬你的星星哦！
 该demo地址：https://github.com/FighterLightning/ZHFJDAddressOC.git
 */

#import <UIKit/UIKit.h>
@protocol  ZHFAddTitleAddressViewDelegate <NSObject>
@optional
-(void)cancelBtnClick:(NSString *)titleAddress titleID:(NSString *)titleID;
-(void)cancelBtnClick:(NSString *)titleAddress titleIDs:(NSArray *)titleIDs;
@end
@interface ZHFAddTitleAddressView : UIView
/**
 代理
 */
@property(nonatomic,assign)id<ZHFAddTitleAddressViewDelegate>delegate1;

@property(nonatomic,assign)NSInteger userID;
/**
 默认的高度
 */
@property(nonatomic,assign)NSUInteger defaultHeight;

/**
 标题高
 */
@property(nonatomic,assign)CGFloat titleScrollViewH;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)UIView *addAddressView;


/**
 初始化

 @return 返回Viw
 */
-(UIView *)initAddressView;

/**
 展示
 */
-(void)addAnimate;

-(void)setDefaultValuesTitles:(NSArray *)titles TitleIDMarr:(NSArray *)titleIDMarr;
@end
