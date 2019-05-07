//
//  JQNetworkAnomaliesVC.m
//  JiuQu
//
//  Created by kk on 2017/5/3.
//  Copyright © 2017年 JiuQuBuy. All rights reserved.
//

#import "sxf_NetworkAnomalies.h"

@interface sxf_NetworkAnomalies ()
@property (nonatomic ,strong) sxf_NetworkAnomalies *networkErrorView;
@end





@implementation sxf_NetworkAnomalies

//创建单利
static sxf_NetworkAnomalies *instance;
+ (instancetype) getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //代码初始化用
//        instance = [[JQNetworkAnomalies alloc] init];
        //xib 初始化用
        instance = XIB(sxf_NetworkAnomalies);
    });
    return instance;
}

- (void)awakeFromNib{
    [super awakeFromNib];

    
}

- (IBAction)errorBtNClick:(UIButton *)sender {
    if (self.errorBlock) {
        self.errorBlock();
    }
}




+ (void)showErrorForView:(UIView *)view ErrorBlock:(void(^)())errorBlock{
    sxf_NetworkAnomalies *errorView = [sxf_NetworkAnomalies getInstance];
    NSLog(@"%p" , errorView);
    errorView.frame = view.frame;//0x137e47460
    [errorView.stateImage setImage:[UIImage imageNamed:@"断网加载"]];
//    errorView.titleLab.text = @"网络异常";
    errorView.netCheckBtn.hidden = NO;
    [view.superview addSubview:errorView];
    errorView.errorBlock = errorBlock;
}

+ (void)removeErrorForView:(UIView *)view{
    //点击加载 释放控制器
    sxf_NetworkAnomalies *networkErrorView = [sxf_NetworkAnomalies getInstance];
    [networkErrorView removeFromSuperview];
}





+ (void)showErrorForWindowErrorBlock:(void(^)())errorBlock{
    sxf_NetworkAnomalies *errorView = [[sxf_NetworkAnomalies alloc] init];
    errorView = XIB(sxf_NetworkAnomalies);
    errorView.frame = [UIScreen mainScreen].bounds;
    [errorView.stateImage setImage:[UIImage imageNamed:@"断网加载"]];
//    errorView.titleLab.text = @"网络异常";
    errorView.netCheckBtn.hidden = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:errorView];
    errorView.errorBlock = errorBlock;
    
}
+ (void)removeErrorForWindow{
    //点击加载 释放控制器
    sxf_NetworkAnomalies *networkErrorView = [sxf_NetworkAnomalies getInstance];
    [networkErrorView removeFromSuperview];
}

- (void) layoutSubviews{
    
    
}









@end
