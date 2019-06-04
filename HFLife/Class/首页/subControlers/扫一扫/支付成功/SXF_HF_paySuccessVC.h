//
//  SXF_HF_paySuccessVC.h
//  HFLife
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_paySuccessVC : BaseViewController
@property (nonatomic, strong)NSString *payName;//收款人名字
@property (nonatomic, strong)UIImage *payImage;//收款人头像
@property (nonatomic, strong)NSString *payMoney;//支付金额
@property (nonatomic, assign)BOOL payStatus;//成功、失败
@property (nonatomic, strong)NSString *payType;
@property (nonatomic, strong)NSString *webUrlStr;//跳转链接
@property (nonatomic, strong)NSString *imageUrlStr;//推广图片地址
@end

NS_ASSUME_NONNULL_END
