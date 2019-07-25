//
//  SXF_HF_payStepAleryView.h
//  HFLife
//
//  Created by mac on 2019/5/15.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_payStepAleryView : UIView
@property (nonatomic, strong)NSString *payMoneyStr;
+ (SXF_HF_payStepAleryView *)showAlertComplete:(void(^__nullable)(BOOL btnBype))complate password:(void(^)(NSString *pwd))password nowPayWithStyle:(void(^)(NSString *style))nowPayBlock;


- (void) cancleAlertView;
@property (nonatomic, assign)BOOL editingEable;//清空密码框

/**
 0：
 1：
 */
@property (nonatomic, assign)NSInteger payStep;//支付到第几步
//获取到选择的支付方式
@property (nonatomic, strong)void(^payStepCallback)(NSIndexPath *indexP);

/** 1：商户 0：个人二维码 个人二维码只支持余额交易 */
@property(nonatomic, strong) NSString *isBusiness;
@end

NS_ASSUME_NONNULL_END
