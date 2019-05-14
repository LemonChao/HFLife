//
//  NearDiscountCouponCell.h
//  HanPay
//
//  Created by 张海彬 on 2019/1/15.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NearDiscountCouponCell : UITableViewCell

/**
 金额
 */
@property (nonatomic,strong)NSString *money;

/**
 标题
 */
@property (nonatomic,strong)NSString *title;

/**
 评分及价格
 */
@property (nonatomic,strong)NSString *evaluatePrice;

/**
 代金券
 */
@property (nonatomic,strong)NSString *voucher;

/**
 距离
 */
@property	 (nonatomic,strong)NSString *distance;

@property (nonatomic,strong)NSString *fan_price;
@end

NS_ASSUME_NONNULL_END
