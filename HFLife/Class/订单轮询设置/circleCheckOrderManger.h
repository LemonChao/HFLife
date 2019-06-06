//
//  circleCheckOrderManger.h
//  HanPay
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface circleCheckOrderManger : NSObject
/** 轮询查询结果 */
@property(nonatomic, copy) void (^searchOrderBlock)(NSDictionary *orderInfo);
/** 查询订单字典 */
@property(nonatomic, copy ,nullable)NSDictionary *orderSearchInfoDic;
+ (instancetype) sharedInstence;
- (instancetype) searchOrderWithOrderId:(NSString *)orderID isHotel:(NSString *)isHotel idType:(NSString *)idType isNowPay:(BOOL)nowPay;
/** 开始查询 */
- (void)checkOrderStatus;
//移除定时器 防止循环引用
- (void) cancleTimer;




@end

NS_ASSUME_NONNULL_END
