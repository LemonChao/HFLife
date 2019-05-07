//
//  UserCache.h
//  MedicalMall
//
//  Created by mac on 2018/3/24.
//

#import <Foundation/Foundation.h>

@interface UserCache : NSObject

/**
 存用户密码

 @param pass 密码
 */
+(void)setUserPass:(NSString *)pass;

/**
 获取用户密码

 @return 获取的密码
 */
+(id)getUserPass;


/**
 存用户手机号

 @param phone 手机号
 */
+(void)setUserPhone:(NSString *)phone;

/**
 获取用户手机号

 @return 用户手机号
 */
+(id)getUserPhone;


/**
 存用户ID

 @param userID 用户ID
 */
+(void)setUserId:(NSString *)userID;

/**
 获取用户ID

 @return 用户ID
 */
+(id)getUserId;

/**
 存用户真实姓名

 @param realName 用户真实姓名
 */
+(void)setUserRealName:(NSString *)realName;

/**
  获取用户真实姓名

 @return  用户真实姓名
 */
+(id)getUserRealName;
/**
 存用户身份证号
 
 @param idCard 用户身份证号
 */
+(void)setUserIdCard:(NSString *)idCard;
/**
 获取用户身份证号
 
 @return  用户身份证号
 */
+(id)getUserIdCard;

/**
 存用户昵称
 
 @param nickName 用户昵称
 */
+(void)setUserNickName:(NSString *)nickName;

/**
 获取用户昵称
 
 @return  用户昵称
 */
+(id)getUserNickName;

/**
 存用户名

 @param userName 用户名
 */
+(void)setUserName:(NSString *)userName;

/**
 获取用户名

 @return 用户名
 */
+(id)getUserName;
/**
 存用户性别

 @param sex 用户性别
 */
+(void)setUserSex:(NSString *)sex;

/**
 获取用户性别

 @return 用户性别
 */
+(id)getUserSex;

/**
  存用户是否实名

 @param XinXi  用户是否实名
 */
+(void)setUserXinXi:(NSString *)XinXi;

/**
 获取用户是否实名

 @return 用户是否实名
 */
+(BOOL)getUserXinXi;

/**
 获取用户是否实名的状态

 @return 状态
 */
+(NSString *)getUserXinXiCode;
/**
 获取用户实名状态

 @return 状态
 */
+(NSString *)getUserXinXiTitle;
/**
 存用户头像

 @param userPic 用户头像
 */
+(void)setUserPic:(NSString *)userPic;

/**
 获取用户头像

 @return 用户头像
 */
+(id)getUserPic;

/**
 邀请码

 @param invite_code <#invite_code description#>
 */
+(void)setUserInviteCode:(NSString *)invite_code;

/**
 等级信息

 @param level_info <#level_info description#>
 @param tradePassword <#tradePassword description#>
 */
+(void)setUserLevelInfo:(NSString *)level_info;

/**
 获取用户邀请码

 @return <#return value description#>
 */
+(id)getUserInviteCode;

/**
 获取用户等级

 @return <#return value description#>
 */
+(id)getUserLevelInfo;
/**
 存是否设置用户交易密码(0:未设置 1:设置)
 
 @param tradePassword 用户头像
 */
+(void)setUserTradePassword:(NSString *)tradePassword;

/**
 获取是否设置用户交易密码(0:未设置 1:设置)
 
 @return 用户交易密码
 */
+(BOOL)getUserTradePassword;




/**
 存用户是否设置密码(0:未设置 1:设置)

 @param Password 设置密码状态
 */
+(void)setUserPassword:(NSString *)Password;

/**
 获取用户是否设置密码(0:未设置 1:设置)
 
 @return 用户交易密码
 */
+(BOOL)getUserPasswordStatus;


/**
 保存审核状态

 @param reviewStatus 审核状态
 */
+(void)setReviewStatus:(NSString *)reviewStatus;

/**
 获取审核状态说明
 */
+(NSString *)getReviewStatusString;
/**
 获取审核状态
 */
+(NSString *)getReviewStatus;
/**
 保存用户地址
 */
+(void)setUserAddress:(NSString *)address;
/**
 获取用户地址
 */
+(NSString *)getUserAddress;
/**
 保存可用资产

 @param availableCapital 可用资产
 */
+(void)setUsreAvailableCapital:(NSString *)availableCapital;

/**
 获取可用资产

 @return 返回资产
 */
+(NSString *)getUsreAvailableCapital;
/**
 保存token值
 
 @param token token值
 */
+(void)setUserToken:(NSString *)token;

/**
 获取token值
 */
+(NSString *)getUserToken;

/**
 保存实名认证填写的名字

 @param name 名字
 */
+(void)setSaveRealNameWriteName:(NSString *)name;

/**
 获取实名认证填写的名字

 @return 名字
 */
+(NSString *)getSaveRealNameWriteName;


/**
 保存实名认证填写的身份证号

 @param idCare 身份证号
 */
+(void)setSaveRealNameWriteIDCare:(NSString *)idCare;


/**
 获取实名认证填写的身份证号

 @return 身份证号
 */
+(NSString *)getSaveRealNameWriteIDCare;

/**
 保存实名认证获取的正面照

 @param positiveImage 正面照
 */
+(void)setSaveRealNamePositiveImage:(UIImage *)positiveImage;

/**
 获取实名认证填写保存的正面照

 @return 正面照
 */
+(UIImage *)getSaveRealNamePositiveImage;


/**
 保存实名认证获取的反面照

 @param negativeImage 反面照
 */
+(void)setSaveRealNameNegativeImage:(UIImage *)negativeImage;


/**
 获取实名认证填写保存的反面照

 @return 反面照
 */
+(UIImage *)getSaveRealNameNegativeImage;

/**
 除手机号和密码其余值置空
 */
+(void)valueEmpty;

/**
用户密码赋值为nil
 */
+(void)UserPassEmpty;
@end



























