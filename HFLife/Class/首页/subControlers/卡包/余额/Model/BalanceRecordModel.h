//
//  BalanceRecordModel.h
//  HanPay
//
//  Created by 张海彬 on 2019/4/18.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BalanceRecordModel : BaseModel

/**
 记录ID
 */
@property (nonatomic,copy)NSString *idStr;

/**
 转账对象ID
 */
@property (nonatomic,copy)NSString *otherid;

/**
 是否是增加
 */
@property (nonatomic,copy)NSString *is_add;

/**
 金额
 */
@property (nonatomic,copy)NSString *real_num;

/**
 时间
 */
@property (nonatomic,copy)NSString *createdate;

/**
 状态说明
 */
@property (nonatomic,copy)NSString *status;

/**
 分类
 */
@property (nonatomic,copy)NSString *log_class;

/**
 账单交易类型及对象
 */
@property (nonatomic,copy)NSString *other_account;

/**
 头像或银行图标
 */
@property (nonatomic,copy)NSString *icon;

/**
 账单类型
 */
@property (nonatomic,copy)NSString *log_type;

/**
 跳转视图名字
 */
@property (nonatomic,copy)NSString *vcName;
@end

NS_ASSUME_NONNULL_END
