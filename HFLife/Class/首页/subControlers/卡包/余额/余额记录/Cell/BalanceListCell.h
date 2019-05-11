//
//  BalanceListCell.h
//  HFLife
//
//  Created by sxf on 2019/4/16.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BalanceListCell : UITableViewCell

/**
 记录类型（生活日用，其他）
 */
@property (nonatomic,copy) NSString *typeString;


/**
 图片
 */
@property (nonatomic,copy) NSString *iconImage;

/**
 标题
 */
@property (nonatomic,copy) NSString *title;

/**
 支付时间
 */
@property (nonatomic,copy) NSString *timer;

/**
 金额
 */
@property (nonatomic,copy) NSString *price;

/**
 订单支付状态
 */
@property (nonatomic,copy) NSString *payType;

/**
 交易是否关闭
 */
@property (nonatomic,assign) BOOL isPayclose;
@end

NS_ASSUME_NONNULL_END
