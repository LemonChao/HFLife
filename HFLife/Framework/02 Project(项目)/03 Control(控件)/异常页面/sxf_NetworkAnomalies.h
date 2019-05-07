//
//  JQNetworkAnomaliesVC.h
//  JiuQu
//
//  Created by kk on 2017/5/3.
//  Copyright © 2017年 JiuQuBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sxf_NetworkAnomalies : UIView

@property (nonatomic ,copy) void (^errorBlock)();;
/**
 状态图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *stateImage;

/**
 标题图片
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLab;


//检查网络
@property (weak, nonatomic) IBOutlet UIButton *netCheckBtn;

//刷新页面
@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;



+ (void)showErrorForView:(UIView *)view ErrorBlock:(void(^)())errorBlock;
+ (void)showErrorForWindow:(UIView *)view ErrorBlock:(void(^)())errorBlock;
//移除fromeView
+ (void)removeErrorForView:(UIView *)view;
@end
