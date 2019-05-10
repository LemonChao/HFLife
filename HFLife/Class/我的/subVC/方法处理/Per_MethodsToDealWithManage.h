//
//  Per_MethodsToDealWithManage.h
//  HanPay
//
//  Created by 张海彬 on 2019/1/19.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseManage.h"
//VC
#import "CertificatePhoto.h"
//#import "ReviewResultsVC.h"
NS_ASSUME_NONNULL_BEGIN


@interface Per_MethodsToDealWithManage : BaseManage

/**
 获取个人资料

 @param successBlock 是否成功
 */
-(void)getPersonalData:(SuccessBlock)successBlock;

/**
 修改头像

 @param headImage 头像
 */
-(void)updateHeadImageView:(UIImage *)headImage;


/**
 获取收款方式

 @param successBlock 回调
 */
-(void)getPaymentMethodsList:(SuccessBlock)successBlock;


/**
 绑定收款方式

 @param parameter 参数
 @param Success 回调
 */
-(void)bindBankCardPayWayParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success;


/**
 解除绑定

 @param parameter 参数
 @param Success 回调
 */
-(void)removeBindCollectionWayParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success;


/**
 获取地址列表

 @param Success 回调
 */
-(void)getAddressListSuccessBlock:(SuccessBlock)Success;

/**
 添加地址

 @param parameter 参数
 @param Success 回调
 */
-(void)addAddressParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success;

/**
 修改地址

 @param parameter 参数
 @param Success 回调
 */
-(void)editorAddressParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success;

/**
 删除地址

 @param parameter 参数
 @param Success 回调
 */
-(void)deleteAddressParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success;


/**
 获取收藏数据

 @param Success 回调
 */
-(void)getMyCollectioSuccessBlock:(SuccessBlock)Success;

/**
 实名认证
 第一步：填写基本信息
 @param dict 身份信息字典
 */
-(void)identityInformationCompletiondict:(NSDictionary *)dict;

/**
 身份证拍照验证

 @param dict 存放照片的字典
 */
-(void)idCardPhotographVerify:(NSDictionary *)dict  requestEnd:(void (^)(void))requestEnd;

/**
 修改登录密码

 @param parameter 参数
 @param Success 回调
 */
-(void)ModifyLoginPasswordParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success;

/**
 修改手机号

 @param parameter 参数
 @param Success 回调
 */
-(void)ModifyBindPhoneParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success;
-(void)ModifyBindPhoneNotHeadTokenParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success;// !!!: 第三方不带head token

/**
 身份信息确认

 @param parameter 参数
 */
-(void)identityInformationConfirmParameter:(NSDictionary *)parameter;
/**
 修改支付密码

 @param parameter 参数
 @param Success 回调
 */
-(void)ModifyPayPasswordParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success;
@end

NS_ASSUME_NONNULL_END
