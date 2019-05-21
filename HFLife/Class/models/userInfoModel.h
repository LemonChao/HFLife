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

//@property (nonatomic ,strong) NSNumber *ID;//小哥id
//@property (nonatomic ,copy) NSString *courier_name;//用户名
///*
//    身份验证状态 0：新增 1：已上传身份信息待验证；3：验证通过；4：验证不通过
// */
//@property (nonatomic ,strong) NSNumber *verified_status;


@property (nonatomic ,strong) NSNumber *id;//用户id
@property (nonatomic ,copy) NSString *member_mobile;///用户名
@property (nonatomic ,strong) NSNumber *member_sex;//性别 0保密 1男 2女
@property (nonatomic ,copy) NSString *member_sexName;//性别 0保密 1男 2女

@property (nonatomic ,copy) NSString *member_avatar;//头像
@property (nonatomic ,strong) NSNumber *member_age;//年龄
@property (nonatomic ,copy) NSString *nickname;//昵称
@property (nonatomic ,strong) NSNumber *rz_status;// 实名认证状态 0未认证   1已认证   2审核中   3未通过
@property (nonatomic ,copy) NSString *realname;// //真实姓名
@property (nonatomic ,copy) NSString *rz_statusName;//实名认证状态


@property (nonatomic ,strong) NSString *work_status_msg; //休息中
@property (nonatomic ,strong) NSString *idcard; //休息中
@property (nonatomic ,strong) NSNumber *comment_number;//评论数量
@property (nonatomic ,strong) NSNumber *order_number;//订单数量
@property (nonatomic ,strong) NSString *yinlian_card;//默认绑定银行卡
@end


NS_ASSUME_NONNULL_END
