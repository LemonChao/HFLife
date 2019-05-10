//
//  PaymentMethodsCell.h
//  HanPay
//
//  Created by 张海彬 on 2019/1/19.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, PaymentMethodsType) {
	/** 没有类别*/
    HotelReservationNone=0,
	/** 支付宝*/
    PaymentMethodsAlipay=1,
    /** 微信*/
    PaymentMethodsWeChat=2,
    /** 邮政储蓄*/
    PaymentMethodsPSBC=3,
    /** 农业银行*/
    PaymentMethodsABC=4,
    /** 中国建设银行*/
    PaymentMethodsCCB=5,
    /** 工商银行*/
    PaymentMethodsICBC=6,
    /** 中国银行*/
    PaymentMethodsBOC=7,
    /** 中国民生银行*/
    PaymentMethodsCMBC=8,
    /** 招商银行*/
    PaymentMethodsCMB=9,
    /** 中国光大银行 */
    PaymentMethodsCEB=10,
    /** 广东发展银行*/
    PaymentMethodsGDB=11,
    /** 上海浦东发展银行*/
    PaymentMethodsSPDB=12,
    /** 交通银行*/
    PaymentMethodsCOMM=13
};
@interface PaymentMethodsCell : UITableViewCell

@property (nonatomic,copy)void (^unbundlingClick) (id dataModel);

@property (nonatomic,strong) id dataModel;

/**
 账号
 */
@property (nonatomic,copy)NSString *account;

/**
 收款类型（哪个银行）
 */
@property (nonatomic,assign)PaymentMethodsType gatheringType;

@end

NS_ASSUME_NONNULL_END
