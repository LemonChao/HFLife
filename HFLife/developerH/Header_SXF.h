//
//  Header_SXF.h
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#ifndef Header_SXF_h
#define Header_SXF_h

/************************yourTools************************/
#import "HW3DBannerView.h"
#import "SELUpdateAlert.h"
#import "LYBmOcrManager.h"
#import "SXF_HF_HomePageModel.h"
#import "SXF_HF_MainPageModel.h"
#import "voiceHeaper.h"
#import "touchID_helper.h"
#import "SXF_HF_WKWebViewVC.h"
/************************yourTools************************/


//y图片拼接
#define URL_IMAGE(url)  [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL, url ? url : @""]]
/************************subUrl************************/


#define LOCALTEST        0  //1:本地测试 0:线上测试

#if DEBUG//测试线
    #if LOCALTEST//(本地测试)
        #define SXF_WEB_URLl_Str(subUrl)        [NSString stringWithFormat:@"http://192.168.0.142:8080/#/%@", subUrl ? subUrl : @""]
        static NSString *const enterIndex            = @"http://192.168.0.143:1111/#/signingIndex?type=2";//我要入驻（个人中心用）
    #else//(线上测试)
        //(个人中心和首页用)
        #define SXF_WEB_URLl_Str(subUrl)        [NSString stringWithFormat:@"http://ceshi-web.hfgld.net/my/#/%@", subUrl ? subUrl : @""]
        static NSString *const enterIndex            = @"http://ceshi-web.hfgld.net/contract/#/signingIndex?type=2";//我要入驻（个人中心用）

    #endif
    //测试线通用部分
    static NSString *const upgrade               = @"http://ceshi-web.hfgld.net/contract/#/upgrade";
    #define SXF_LOC_URL_STR(subUrl)        [NSString stringWithFormat:@"ceshi-ucenter.hfgld.net%@", subUrl ? subUrl : @""]
    static NSString *const shareUrl        = @"https://www.hfgld.net/app_html/registered/registered.html?invite_code=%@";//分享
    #define OPENSHOPURLLIST @"https://www.hfgld.net/app_html/enter_shop_model/#/list"//申请列表(web)

#else//线上
    #define SXF_LOC_URL_STR(subUrl)        [NSString stringWithFormat:@"ceshi-ucenter.hfgld.net%@", subUrl ? subUrl : @""]

    #define SXF_WEB_URLl_Str(subUrl)       [NSString stringWithFormat:@"http://ceshi-web.hfgld.net/my/#/%@", subUrl ? subUrl : @""]
    static NSString *const shareUrl                   = @"https://www.hfgld.net/app_html/registered/registered.html?invite_code=%@";//分享
    #define OPENSHOPURLLIST @"https://www.hfgld.net/app_html/enter_shop_model/#/list" //申请列表(web)
    static NSString *const enterIndex            = @"http://192.168.0.143:1111/#/signingIndex?type=2";//我要入驻（个人中心用）
        static NSString *const upgrade               = @"http://ceshi-web.hfgld.net/contract/#/upgrade";
#endif

//版本信息
static NSString *const appUpDateUrl               = @"/api/version/getVersion";

//获取版本说明
static NSString *const VersionContent             = @"/api/version/getVersionContent";

//获取服务协议
static NSString *const ServiceAgreement           = @"/api/system/getServiceAgreement";

//获取版本信息
//上传定位
static NSString *const upDateLocationUrl          = @"api/common/setUserAddress";

//首页轮播导航接口
static NSString *const HomeNavBanner              = @"/api/index/homePage";
//首页头条列表
static NSString *const HomeNewsList               = @"/api/index/newsList";
//首页头条详情
static NSString *const HomeNewsDetaile            = @"/api/index/getDetail";

/**
 获取收款码或付款码（1）
 */
static NSString *const CreateMoneyQrcode          = @"/api/finance/createMoneyQrcode";

/**
 扫描收款码或付款码解析信息（2）
 */
static NSString *const GetQrcodeInfo              = @"/api/finance/getQrcodeInfo";

/**
 扫码付款生成订单（3）
 */
static NSString *const CreateOrder                = @"/api/finance/createOrder";

/**
 订单支付（4）
 */
static NSString *const GoToPay                    = @"/api/finance/goToPay";

/**
 交易详情
 */
static NSString *const TradingDetail              = @"/member_coin/tradingDetail";

/**
 
 */
static NSString *const QrcodeGetMoneyCore         = @"/api/Finance/qrcodeGetMoneyCore";
/************************subUrl************************/


/****************************webSubUrl*******************************/
//余额
static NSString *const balanceMain           = @"balanceMain";
//富权
static NSString *const richRightBalance      = @"richRightBalance";
//可兑换富权
static NSString *const convertible           = @"convertible";
//收货地址
static NSString *const addressList           = @"addressList";
//银行卡
static NSString *const bankCardList          = @"bankCardList";
//分享好友
static NSString *const share                 = @"share";
//我要升级
static NSString *const upgradeMain           = @"upgradeMain";
//我的收藏
static NSString *const myCollection          = @"myCollection";
//我的好友
static NSString *const myFriendsMain         = @"myFriendsMain";
//首页的消息通知
static NSString *const noticeList            = @"noticeList";
//服务协议
static NSString *const serviceAgreement      = @"serviceAgreement";
//版本说明
static NSString *const versionSpecification  = @"versionSpecification";
//会员卡信息
static NSString *const membershipInformation = @"membershipInformation";
//收款码介绍
static NSString *const reCodeIntroduction    = @"reCodeIntroduction";
//实名认证
static NSString *const certification         = @"certification";
//更多新闻
static NSString *const headlinesList         = @"headlinesList";

//客服中心
static NSString *servceCenter                = @"serviceCenterMain";
#endif /* Header_SXF_h */
