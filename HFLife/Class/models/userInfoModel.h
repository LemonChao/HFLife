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

//获取用户信息
+ (void) getUserInfo;

//@property (nonatomic ,strong) NSNumber *ID;//小哥id
//@property (nonatomic ,copy) NSString *courier_name;//用户名
///*
//    身份验证状态 0：新增 1：已上传身份信息待验证；3：验证通过；4：验证不通过
// */
//@property (nonatomic ,strong) NSNumber *verified_status;


@property (nonatomic ,strong) NSNumber *id;//用户id
@property (nonatomic ,copy) NSString *member_mobile;///用户名
@property (nonatomic ,strong) NSNumber *member_sex;//性别 0保密 1男 2女
@property (nonatomic ,copy) NSString *member_sexName;//性别 0保密 1男 2女(!!获取member_sex名称

@property (nonatomic ,copy) NSString *member_avatar;//头像
@property (nonatomic ,strong) NSNumber *member_age;//年龄
@property (nonatomic ,copy) NSString *nickname;//昵称
@property (nonatomic ,strong) NSNumber *rz_status;// 实名认证状态 0未认证   1已认证   2审核中   3未通过
@property (nonatomic ,copy) NSString *realname;// //真实姓名
@property (nonatomic ,copy) NSString *rz_statusName;//实名认证状态(!!获取rz_status名称

@property (nonatomic ,copy) NSString *invite_code;//邀请码
@property (nonatomic ,strong) NSNumber *level_id;//等级ID
@property (nonatomic ,copy) NSString *level_name;//等级名称
//"level_name": "VIP1",//等级名称
//"i_agent_level": 0,//代理等级
//"i_agent_name": "云南" //代理区域
//"i_agent_id": 0, //代理省市区id
//"static_coin": 0, //富权数量
//"dynamic_shop": 0,//富宝数量
//"dynamic_dh": 0, //可兑换钱包
@property (nonatomic ,strong) NSNumber *i_agent_level;//代理等级
@property (nonatomic ,strong) NSNumber *i_agent_id;//代理省市区id
@property (nonatomic ,copy) NSString *static_coin;//富权数量
@property (nonatomic ,copy) NSString *i_agent_name;//代理区域
@property (nonatomic ,copy) NSString *dynamic_shop;//富宝数量
@property (nonatomic ,copy) NSString *dynamic_dh;//可兑换钱包
@property (nonatomic ,strong) NSNumber *yesterday_turnover;//昨日营业额
@property (nonatomic ,strong) NSNumber *yesterday_benefit;//昨日让利

@property (nonatomic ,copy,nullable)  NSString  *weixin_unionid;//微信id
@property (nonatomic ,copy,nullable) NSString *alipay_unionid;//支付宝id


@property (nonatomic, strong)UIImage *userHeaderImage;//用户头像


@end
//@interface MemberInfoModel : BaseModel
//@property (nonatomic ,strong) NSNumber *id;//用户id
//@property (nonatomic ,copy) NSString *member_mobile;///用户名
//@property (nonatomic ,strong) NSNumber *member_sex;//性别 0保密 1男 2女
//@property (nonatomic ,copy) NSString *member_sexName;//性别 0保密 1男 2女(!!获取member_sex名称
//@property (nonatomic ,copy) NSString *member_avatar;//头像
//@property (nonatomic ,strong) NSNumber *member_age;//年龄
//@property (nonatomic ,copy) NSString *nickname;//昵称
//@property (nonatomic ,strong) NSNumber *rz_status;// 实名认证状态 0未认证   1已认证   2审核中   3未通过
//@property (nonatomic ,copy) NSString *realname;// //真实姓名
//@property (nonatomic ,copy) NSString *rz_statusName;//实名认证状态(!!获取rz_status名称
//@property (nonatomic ,copy) NSString *invite_code;//邀请码
//@property (nonatomic ,strong) NSNumber *level_id;//等级ID
//@property (nonatomic ,copy) NSString *level_name;//等级名称
//
//@end




NS_ASSUME_NONNULL_END
