//
//  userModel.h
//  DeliveryOrder
//
//  Created by mac on 2019/3/20.
//  Copyright © 2019 LeYuWangLuo. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

//存储数据
#define USER_MODEL_DATA                     @"USER_MODEL_DATA"

@interface userInfoModel : BaseModel

//单例
+(instancetype)sharedUser;
//单例的销毁
+(void)attempDealloc;
@property (nonatomic ,strong) NSNumber *ID;//小哥id
@property (nonatomic ,copy) NSString *courier_name;//用户名
/*
    身份验证状态 0：新增 1：已上传身份信息待验证；3：验证通过；4：验证不通过
 */
@property (nonatomic ,strong) NSNumber *verified_status;
@property (nonatomic ,strong) NSNumber *courier_status;//账户状态 1：启用中；0：已冻结
@property (nonatomic ,copy) NSString *courier_phone;//骑手手机号
@property (nonatomic ,strong) NSString *courier_img;//骑手头像
@property (nonatomic ,strong) NSNumber *account_amount;//骑手账户金额
@property (nonatomic ,strong) NSString *token;//登录token(使用持久化的token)
@property (nonatomic ,strong) NSNumber *work_status;//工作状态 0：休息中 1：工作中
@property (nonatomic ,strong) NSString *courier_status_msg;// "启用中",
@property (nonatomic ,strong) NSString *verified_status_msg;// "已上传身份信息待验证",
@property (nonatomic ,strong) NSString *work_status_msg; //休息中
@property (nonatomic ,strong) NSString *idcard; //休息中
@property (nonatomic ,strong) NSNumber *comment_number;//评论数量
@property (nonatomic ,strong) NSNumber *order_number;//订单数量
@property (nonatomic ,strong) NSString *yinlian_card;//默认绑定银行卡
@end

NS_ASSUME_NONNULL_END
