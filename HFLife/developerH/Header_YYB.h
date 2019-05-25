//
//  Header_YYB.h
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#ifndef Header_YYB_h
#define Header_YYB_h
/** 分享 */
#import "ShareProductInfoView.h"
#import "HXEasyCustomShareView.h"
/** 弹窗 */
#import "ZHB_HP_PreventWeChatPopout.h"
/** 网络异常界面 */
#import "UIView+alertView.h"

#import <AFAuthSDK/AFAuthSDK.h>// 支付宝登录
#import "LoginVC.h"

/** 用户信息 */
#import "userInfoModel.h"

/** web加载 */
#import "YYB_HF_WKWebVC.h"

/** 数据model */
#import "YYB_HF_nearLifeModel.h"

/************************yourTools************************/

/************************yourTools************************/




/************************subUrl************************/
#define GP_BASEURL  @"http://test.hfgld.net"

#pragma mark - 登录注册 ---------------------------
static NSString *const yourTestUrl = @"w=index&t=index";


/** 上传头像 */
static NSString *const kUploadFiles = @"api/upload/uploadFiles";
/** 手机注册 */
static NSString *const kRegisterMobile = @"api/member/registerMobile";

/** 手机登录 */
static NSString *const kMobileLogin = @"api/member/mobileLogin";
/** 微信登录 */
static NSString *const kWXLogin = @"api/member/wxLogin";
/** 微信绑定手机号 */
static NSString *const kWxBindmobile =@"api/member/wxBindmobile";
/** 注销登录 */
static NSString *const kLogout = @"api/member/logout";
/** 发送验证码 */
static NSString *const kSendsms = @"api/sms/send";
/** 检查手机号 */
static NSString *const kCheckMobile = @"api/member/checkMobile";
/** 检测邀请码 */
static NSString *const kCheckInviteCode = @"api/member/checkInviteCode";
/** 获取个人基础资料 */
static NSString *const kMemberBaseInfo = @"api/member/memberBaseInfo";
/** 获取个人资料 修改基础资料接口 //修改基础资料会重新生成token 前端需要替换*/
static NSString *const kSaveMemberBase = @"api/member/saveMemberBase";
/** 获取个人详细资料 */
static NSString *const kMemberInfo = @"api/member/memberInfo";

/** 验证当前手机号 */
static NSString *const kCheckMobile_security = @"api/member_security/checkMobile";
/** 验证当前手机号 */
static NSString *const kChangemobile = @"api/member_security/changemobile";
/** 解绑微信 */
static NSString *const kMobileRemoveWx = @"api/member_security/mobileRemoveWx";
/** 绑定微信 */
static NSString *const kMobileBindWx = @"api/member_security/mobileBindWx";
/** 注销协议 */
static NSString *const kGetCloseAgreement = @"api/system/getCloseAgreement";
/** 注销 */
static NSString *const kCloseAccount = @"api/member_security/closeAccount";
/** 设置交易密码 */
static NSString *const kSetPayPassword = @"api/member_security/setPayPassword";

#pragma mark - 本地生活 ---------------------------

/** 首页快捷入口及banner等接口 */
static NSString *const kNearLife = @"/index.php/api/index/index";
/** 首页猜你喜欢接口（未完）*/
static NSString *const kGetIndexRecommendList = @"/index.php/api/index/getIndexRecommendList";




/** 分享数据 */
static NSString *const kGet_invite_info = @"w=user&t=get_invite_info";
/** 综合商家店铺列表 */
static NSString *const kGet_general_shop_list = @"w=general_shop&t=get_general_shop_list";

/************************subUrl************************/





#endif /* Header_YYB_h */
