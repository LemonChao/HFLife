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

/************************yourTools************************/

/************************yourTools************************/




/************************subUrl************************/
#define GP_BASEURL  @"http://test.hfgld.net"

static NSString *const yourTestUrl = @"w=index&t=index";
/** 手机注册 */
static NSString *const kRegisterMobile = @"member/registerMobile";

/** 手机登录 */
static NSString *const kMobileLogin = @"member/mobileLogin";
/** 微信登录 */
static NSString *const kWXLogin = @"member/wxLogin";
/** 注销登录 */
static NSString *const kLogout = @"member/logout";
/** 发送验证码 */
static NSString *const kSendsms = @"sms/send";
/** 检查手机号 */
static NSString *const kCheckMobile = @"member/checkMobile";
/** 检测邀请码 */
static NSString *const kCheckInviteCode = @"member/checkInviteCode";



/** 分享数据 */
static NSString *const kGet_invite_info = @"w=user&t=get_invite_info";
/** 综合商家店铺列表 */
static NSString *const kGet_general_shop_list = @"w=general_shop&t=get_general_shop_list";

/************************subUrl************************/





#endif /* Header_YYB_h */
