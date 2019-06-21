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
#import "InviteVC.h"//分享
/** 用户信息 */
#import "userInfoModel.h"
/** web加载 */
#import "YYB_HF_WKWebVC.h"
/** 数据model */
#import "YYB_HF_nearLifeModel.h"
/** 订单轮循 */
#import "circleCheckOrderManger.h"
/** 设置定位视图 */
#import "YYB_HF_LocalFailAlertV.h"
/************************yourTools************************/

/************************yourTools************************/




/************************subUrl************************/
#define GP_BASEURL  @"http://test.hfgld.net"

#pragma mark - public公用 ---------------------------

//意起缘生 2019/06/13 下午2:51
//http://ceshi-web.hfgld.net/book/#/ 超级账本
//
//意起缘生 2019/06/13 下午2:51
//http://ceshi-web.hfgld.net/contract/#/ 自助签约
//
//意起缘生 2019/06/13 下午2:51
//http://ceshi-web.hfgld.net/life/#/ 附近商家
//
//意起缘生 2019/06/13 下午2:52
//http://ceshi-web.hfgld.net/my/#/ 商学院/生活缴费
//
//意起缘生 2019/06/13 下午2:52
//http://ceshi-web.hfgld.net/mall/#/ 商城
//

#if DEBUG//测试线
#if LOCALTEST//(本地测试)
static NSString *const centerBaceUrl =      @"ucenter.hfgld.net/";//个人中心
static NSString *const kBaseLife =          @"life.hfgld.net/index.php/";//本地生活
static NSString *const kBaseUrlH5 =         @"http://192.168.0.253:";//h5本地测试base

#pragma mark - h5 ---------------------------
/** 选择位置 */
static NSString *const kChoiceCity =        @"8080/#/city";
/** 订单列表 */
static NSString *const kOrderList =         @"10004/#/order";
#pragma mark - h5  服务协议 ---------------------------
/** 服务协议 */
static NSString *const kAppAgreement =      @"http://192.168.0.143:8080/#/appAgreement";

#else        //(线上测试)
static NSString *const centerBaceUrl =      @"ucenter.hfgld.net/";
static NSString *const kBaseLife =          @"life.hfgld.net/index.php/";
static NSString *const kBaseUrlH5 =         @"https://web.hfgld.net/";//h5线上测试base

/** 选择位置 */
static NSString *const kChoiceCity =        @"hotel/#/city";
/** 订单列表 */
static NSString *const kOrderList =         @"life/#/order";
/** 服务协议 */
static NSString *const kAppAgreement =      @"https://web.hfgld.net/mall/#/appAgreement";

#endif

#else//正式线上
static NSString *const centerBaceUrl =      @"ucenter.hfgld.net/";
static NSString *const kBaseLife =          @"life.hfgld.net/index.php/";
static NSString *const kBaseUrlH5 =         @"https://web.hfgld.net/";//h5线上正式base

//h5
/** 选择位置 */
static NSString *const kChoiceCity =        @"hotel/#/city";
/** 订单列表 */
static NSString *const kOrderList =         @"life/#/order";
/** 服务协议 */
static NSString *const kAppAgreement =      @"https://web.hfgld.net/mall/#/appAgreement";
#endif

//个人中心
#define kCenterAdress(parm)                 [NSString stringWithFormat:@"%@%@",centerBaceUrl,parm]
//本地生活
#define kLifeAdress(parm)                   [NSString stringWithFormat:@"%@%@",kBaseLife,parm]
//本地生活h5
#define kH5LocaAdress(parm)                 [NSString stringWithFormat:@"%@%@",kBaseUrlH5,parm]


/** 上传文件/头像 */
static NSString *const kUploadFiles =       @"api/upload/uploadFiles";
/** 发送验证码 */
static NSString *const kSendsms =           @"api/sms/send";


#pragma mark - 登录注册 ---------------------------

/** 手机注册 */
static NSString *const kRegisterMobile =    @"api/member/registerMobile";
/** 手机登录 */
static NSString *const kMobileLogin =       @"api/member/mobileLogin";
/** 微信登录 */
static NSString *const kWXLogin =           @"api/member/wxLogin";
/** 获取支付宝authString */
static NSString *const kAlipayOauth =       @"api/member/alipayOauth";
/** 支付宝登录 */
static NSString *const kAlipayLogin =       @"api/member/alipayLogin";

/** 微信绑定手机号 */
static NSString *const kWxBindmobile =      @"api/member/wxBindmobile";
/** 支付宝绑定手机号 */
static NSString *const kAlipayBindmobile =  @"api/member/alipayBindmobile";
/** 注销登录 */
static NSString *const kLogout =            @"api/member/logout";
/** 检查手机号 */
static NSString *const kCheckMobile =       @"api/member/checkMobile";
/** 检测邀请码 */
static NSString *const kCheckInviteCode =   @"api/member/checkInviteCode";

/** 获取个人资料 修改基础资料接口 //修改基础资料会重新生成token 前端需要替换*/
static NSString *const kSaveMemberBase =    @"api/member/saveMemberBase";
/** 获取个人详细资料 */
static NSString *const kMemberInfo =        @"api/member/memberInfo";
/** 验证当前手机号 */
static NSString *const kCheckMobile_security = @"api/member_security/checkMobile";
/** 修改手机号 */
static NSString *const kChangemobile =      @"api/member_security/changemobile";
/** 解绑微信 */
static NSString *const kMobileRemoveWx =    @"api/member_security/mobileRemoveWx";
/** 绑定微信 */
static NSString *const kMobileBindWx =      @"api/member_security/mobileBindWx";
/** 解绑支付宝 */
static NSString *const kMobileRemoveAlipay = @"api/member_security/mobileRemoveAlipay";
/** 绑定支付宝 */
static NSString *const kMobileBindAlipay =  @"api/member_security/mobileBindAlipay";
/** 注销协议 */
static NSString *const kGetCloseAgreement = @"api/system/getCloseAgreement";
/** 注销/冻结账号 */
static NSString *const kCloseAccount =      @"api/member_security/closeAccount";
/** 设置交易密码 */
static NSString *const kSetPayPassword =    @"api/member_security/setPayPassword";

#pragma mark - 本地生活 ---------------------------

/** 首页快捷入口及banner等接口 */
static NSString *const kNearLife =                      @"api/index/index";
/** 首页猜你喜欢接口（未完）*/
static NSString *const kGetIndexRecommendList =         @"api/index/getIndexRecommendList";

/** 查询订单是否支付成功 */
static NSString *const kGetOrderPayResult =              @"api/foodorder/getOrderPayResult";

/** 美食搜索 */
static NSString *const kGetSearchFoodList =             @"api/food/getSearchFoodList";
/** 酒店搜索 */
static NSString *const kGetSearchHotelList =            @"api/hotel/getHotelSearchList";
/** 获取热搜关键词 */
static NSString *const kGetHotSearchList =              @"api/common/getHotSearchList";
/** 分享数据 */
//static NSString *const kGet_invite_info = @"w=user&t=get_invite_info";
/** 综合商家店铺列表 */
//static NSString *const kGet_general_shop_list = @"w=general_shop&t=get_general_shop_list";

/************************subUrl************************/

#pragma mark - h5Url ---------------------------
#pragma mark - h5个人中心 ---------------------------

/** 收货地址 */
//static NSString *const kH5addressList =     @"http://192.168.0.105:8080/addressList";
///** 添加银行卡 */
//static NSString *const kH5bankCardList =    @"http://192.168.0.105:8080/bankCardList";
///** 我的收藏 */
//static NSString *const kH5myCollection =    @"http://192.168.0.105:8080/myCollection";

#endif /* Header_YYB_h */
