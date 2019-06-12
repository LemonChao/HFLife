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
/************************yourTools************************/

/************************yourTools************************/




/************************subUrl************************/
#define GP_BASEURL  @"http://test.hfgld.net"

#pragma mark - public公用 ---------------------------
/** 上传文件/头像 */
static NSString *const kUploadFiles =       @"ceshi-ucenter.hfgld.net/api/upload/uploadFiles";
/** 发送验证码 */
static NSString *const kSendsms =           @"ceshi-ucenter.hfgld.net/api/sms/send";


#pragma mark - 登录注册 ---------------------------
//@"ceshi-ucenter.hfgld.net/";登录个人中心域名
#define centerBaceUrl                       @"ceshi-ucenter.hfgld.net"

/** 手机注册 */
static NSString *const kRegisterMobile =    @"ceshi-ucenter.hfgld.net/api/member/registerMobile";
/** 手机登录 */
static NSString *const kMobileLogin =       @"ceshi-ucenter.hfgld.net/api/member/mobileLogin";
/** 微信登录 */
static NSString *const kWXLogin =           @"ceshi-ucenter.hfgld.net/api/member/wxLogin";
/** 获取支付宝authString */
static NSString *const kAlipayOauth =       @"ceshi-ucenter.hfgld.net/api/member/alipayOauth";
/** 支付宝登录 */
static NSString *const kAlipayLogin =       @"ceshi-ucenter.hfgld.net/api/member/alipayLogin";

/** 微信绑定手机号 */
static NSString *const kWxBindmobile =      @"ceshi-ucenter.hfgld.net/api/member/wxBindmobile";
/** 支付宝绑定手机号 */
static NSString *const kAlipayBindmobile =  @"ceshi-ucenter.hfgld.net/api/member/alipayBindmobile";
/** 注销登录 */
static NSString *const kLogout =            @"ceshi-ucenter.hfgld.net/api/member/logout";
/** 检查手机号 */
static NSString *const kCheckMobile =       @"ceshi-ucenter.hfgld.net/api/member/checkMobile";
/** 检测邀请码 */
static NSString *const kCheckInviteCode =   @"ceshi-ucenter.hfgld.net/api/member/checkInviteCode";


/** 获取个人基础资料 */
static NSString *const kMemberBaseInfo =    @"ceshi-ucenter.hfgld.net/api/member/memberBaseInfo";
/** 获取个人资料 修改基础资料接口 //修改基础资料会重新生成token 前端需要替换*/
static NSString *const kSaveMemberBase =    @"ceshi-ucenter.hfgld.net/api/member/saveMemberBase";
/** 获取个人详细资料 */
static NSString *const kMemberInfo =        @"ceshi-ucenter.hfgld.net/api/member/memberInfo";
/** 验证当前手机号 */
static NSString *const kCheckMobile_security = @"ceshi-ucenter.hfgld.net/api/member_security/checkMobile";
/** 修改手机号 */
static NSString *const kChangemobile =      @"ceshi-ucenter.hfgld.net/api/member_security/changemobile";
/** 解绑微信 */
static NSString *const kMobileRemoveWx =    @"ceshi-ucenter.hfgld.net/api/member_security/mobileRemoveWx";
/** 绑定微信 */
static NSString *const kMobileBindWx =      @"ceshi-ucenter.hfgld.net/api/member_security/mobileBindWx";
/** 解绑支付宝 */
static NSString *const kMobileRemoveAlipay = @"ceshi-ucenter.hfgld.net/api/member_security/mobileRemoveAlipay";
/** 绑定支付宝 */
static NSString *const kMobileBindAlipay =  @"ceshi-ucenter.hfgld.net/api/member_security/mobileBindAlipay";
/** 注销协议 */
static NSString *const kGetCloseAgreement = @"ceshi-ucenter.hfgld.net/api/system/getCloseAgreement";
/** 注销/冻结账号 */
static NSString *const kCloseAccount =      @"ceshi-ucenter.hfgld.net/api/member_security/closeAccount";
/** 设置交易密码 */
static NSString *const kSetPayPassword =    @"ceshi-ucenter.hfgld.net/api/member_security/setPayPassword";

#pragma mark - 本地生活 ---------------------------
//ceshi-life.hfgld.net/本地域名

/** 首页快捷入口及banner等接口 */
static NSString *const kNearLife =          @"ceshi-life.hfgld.net/index.php/api/index/index";
/** 首页猜你喜欢接口（未完）*/
static NSString *const kGetIndexRecommendList = @"ceshi-life.hfgld.net/index.php/api/index/getIndexRecommendList";

/** 查询订单是否支付成功 */
static NSString *const kGetOrderPayResult = @"ceshi-life.hfgld.net/index.php/api/foodorder/getOrderPayResult";

/** 美食搜索 */
static NSString *const kGetSearchFoodList = @"ceshi-life.hfgld.net/index.php/api/food/getSearchFoodList";
/** 酒店搜索 */
static NSString *const kGetSearchHotelList = @"ceshi-life.hfgld.net/index.php/api/hotel/getHotelSearchList";
/** 获取热搜关键词 */
static NSString *const kGetHotSearchList = @"ceshi-life.hfgld.net/index.php/api/common/getHotSearchList";
/** 分享数据 */
//static NSString *const kGet_invite_info = @"w=user&t=get_invite_info";
/** 综合商家店铺列表 */
//static NSString *const kGet_general_shop_list = @"w=general_shop&t=get_general_shop_list";

/************************subUrl************************/

#pragma mark - h5Url ---------------------------
#pragma mark - h5个人中心 ---------------------------
/** 收货地址 */
static NSString *const kH5addressList =     @"http://192.168.0.105:8080/addressList";
/** 添加银行卡 */
static NSString *const kH5bankCardList =    @"http://192.168.0.105:8080/bankCardList";
/** 我的收藏 */
static NSString *const kH5myCollection =    @"http://192.168.0.105:8080/myCollection";

#pragma mark - h5本地 ---------------------------
/** 选择位置 */
static NSString *const kChoiceCity =        @"http://192.168.0.122:8080/#/city";
// !!!: ==============   后面使用接口返回的url    ==================
///** 商家入驻 */
//static NSString *const kEnter =             @"http://192.168.0.122:10004/#/enter-index/";
///** 美食 */
//static NSString *const kMeiFood =           @"http://192.168.0.122:10004/#/food-index/";
///** 酒店住宿 */
//static NSString *const kHotelAccommodation = @"http://192.168.0.122:8080/#/";
/** 订单列表 */
static NSString *const kOrderList =         @"http://192.168.0.122:10004/#/order";


#pragma mark - h5  服务协议 ---------------------------

/** 服务协议 */
static NSString *const kAppAgreement =        @"http://192.168.0.143:8080/#/appAgreement";
#endif /* Header_YYB_h */
