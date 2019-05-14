//
//  DiscountCouponCell.h
//  HanPay
//
//  Created by 张海彬 on 2019/1/15.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiscountCouponCell : UITableViewCell

@property (nonatomic,strong)NSString *imageName;
/**
 店铺名字
 */
@property (nonatomic,strong)NSString *merchants;

/**
 距离
 */
@property (nonatomic,strong)NSString *distance;

/**
 标题
 */
@property (nonatomic,strong)NSString *title;

/**
 介绍
 */
@property (nonatomic,strong)NSString *introduce;

/**
 时间
 */
@property (nonatomic,strong)NSString *time;

/**
 现价
 */
@property (nonatomic,strong)NSString *presentPrice;

/**
 原价
 */
@property (nonatomic,strong)NSString *originalPrice;
@end

NS_ASSUME_NONNULL_END
