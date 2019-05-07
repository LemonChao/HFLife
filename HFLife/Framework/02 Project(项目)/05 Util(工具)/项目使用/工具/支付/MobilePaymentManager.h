//
//  MobilePaymentManager.h
//  healthManagement
//
//  Created by MATRIX on 15/11/20.
//  Copyright © 2015年 renqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
//#import "BaseViewModel.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AlipayPaymentNetApi.h"
#import "WeChatPayNetApi.h"
//#import "MMHttpRequest.h"
/**
 *  微信支付完成通知
 */
#define WECHAT_PAY_FINISH_NOTIFICATION  @"WECHAT_PAY_FINISH_NOTIFICATION"

#define WECHAT_RESP_CODE   @"wechatResponseCode"

enum  UPPayErrCode {
   	UPPaySuccess           = 0,    /**< 成功    */
    UPPayErrCodeCommon     = -1,   /**< 普通错误类型    */
    UPPayErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
};

/**
 *  移动支付管理
 */
@interface MobilePaymentManager : NSObject<WXApiDelegate>

@property (nonatomic, copy) void(^wechatPayFinish)(int respCode);

+ (MobilePaymentManager *)sharedManager;

/**
 微信支付

 @param dataDict 订单数据，包括订单ID
 @param payFinish 微信支付完成操作
 */
- (void)wechatPayWithParams:(NSDictionary *)dataDict
                     finish:(void (^)(int))payFinish;



/**
 支付宝支付

 @param dataDict 订单数据，包括订单ID
 @param payFinish 微信支付完成操作
 */
- (void)AlipayPaycompleteParams:(NSMutableDictionary *)dataDict
                      payFinish:(void (^)(int))payFinish;


/**
 银联支付

 @param tn 交易流水号，商户后台向银联后台提交订单信息后，由银联后台生成并下发给商户后台的交易凭证
 @param payFinish 银联支付的回调
 */
-(void)UPPaySartPay:(NSString*)tn payFinish:(void (^)(int))payFinish;

/**
 回调URL

 @param url 地址
 @return 回调
 */
-(BOOL)handleOpenURL:(NSURL *)url;
@end
