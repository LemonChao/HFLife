//
//  MallCashierDeskVC.h
//  HanPay
//
//  Created by mac on 2019/2/20.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MallCashierDeskVC : BaseViewController

/**
 订单ID
 */
@property (nonatomic,strong)NSString *orderID;

/**
 价钱
 */
@property (nonatomic,strong)NSString *price;

/**
 是否是酒店
 */
@property (nonatomic,assign)BOOL isHotel;

@property (nonatomic,assign)BOOL id_type;

@property (nonatomic ,assign) BOOL isNowPay;
/** 订单返回 */
@property (nonatomic ,assign) BOOL isFromOrder;

@end

NS_ASSUME_NONNULL_END
