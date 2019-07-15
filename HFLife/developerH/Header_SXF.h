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




#if DEBUG
    //web地址
    #define baseWebUrlCompunent      @"ceshi-web.hfgld.net"
    //原生地址
    #define baseAppUrl               @"ceshi-ucenter.hfgld.net"
#else
    //web地址
    #define baseWebUrlCompunent      @"web.hfgld.net"
    //原生地址
    #define baseAppUrl               @"ucenter.hfgld.net"
#endif


#define shareBaseUrl    [NSString stringWithFormat:@"%@%@", URL_PROTOCOL, shareUrlCompunent]
#define baseWebUrl      [NSString stringWithFormat:@"%@%@", URL_PROTOCOL, baseWebUrlCompunent]


#define LOCALTEST        0  //1:本地测试 0:线上测试
#if DEBUG//测试线
    #if LOCALTEST//(本地测试)
        #define SXF_WEB_URLl_Str(subUrl)        [NSString stringWithFormat:@"http://192.168.0.109:8080/#/%@", subUrl ? subUrl : @""]
        static NSString *const enterIndex            = @"http://192.168.0.143:1111/#/signingIndex?type=2";//我要入驻（个人中心用）
    #else//(线上测试)
        //(个人中心和首页用)
        #define SXF_WEB_URLl_Str(subUrl)        [NSString stringWithFormat:@"%@/my/#/%@",baseWebUrl,subUrl ? subUrl : @""]
        #define enterIndex                      [NSString stringWithFormat:@"%@/%@",baseWebUrl, entering]//我要入驻（个人中心用）
    #endif
    //测试线通用部分
    #define upgrade                             [NSString stringWithFormat:@"%@/%@", baseWebUrl, upGradeApp]
    #define SXF_LOC_URL_STR(subUrl)             [NSString stringWithFormat:@"%@%@", baseAppUrl,subUrl ? subUrl : @""]
    #define shareUrl                            [NSString stringWithFormat:@"%@%@", shareBaseUrl,sharedRegist]//分享
    //申请列表(web)
    #define OPENSHOPURLLIST                     [NSString stringWithFormat:@"%@%@", shareBaseUrl,applacationList]
#else//线上
//(个人中心和首页用)
    #define SXF_WEB_URLl_Str(subUrl)            [NSString stringWithFormat:@"%@/my/#/%@",baseWebUrl,subUrl ? subUrl : @""]
    #define enterIndex                          [NSString stringWithFormat:@"%@/%@",baseWebUrl, entering]//我要入驻（个人中心用）
    #define upgrade                             [NSString stringWithFormat:@"%@/%@", baseWebUrl, upGradeApp]
    #define SXF_LOC_URL_STR(subUrl)             [NSString stringWithFormat:@"%@%@", baseAppUrl,subUrl ? subUrl : @""]
    #define shareUrl                            [NSString stringWithFormat:@"%@%@", shareBaseUrl,sharedRegist]//分享
    //申请列表(web)
    #define OPENSHOPURLLIST                     [NSString stringWithFormat:@"%@%@", shareBaseUrl,applacationList]
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
static NSString *const balanceMain                = @"balanceMain";
//富权
static NSString *const richRightBalance           = @"richRightBalance";
//可兑换富权
static NSString *const convertible                = @"convertible";
//收货地址
static NSString *const addressList                = @"addressList";
//银行卡
static NSString *const bankCardList               = @"bankCardList";
//分享好友
static NSString *const share                      = @"share";
//我要升级
static NSString *const upgradeMain                = @"upgradeMain";
//我的收藏
static NSString *const myCollection               = @"myCollection";
//我的好友
static NSString *const myFriendsMain              = @"myFriendsMain";
//首页的消息通知
static NSString *const noticeList                 = @"noticeList";
//服务协议
static NSString *const serviceAgreement           = @"serviceAgreement";
//版本说明
static NSString *const versionSpecification       = @"versionSpecification";
//会员卡信息
static NSString *const membershipInformation      = @"membershipInformation";
//收款码介绍
static NSString *const reCodeIntroduction         = @"reCodeIntroduction";
//实名认证
static NSString *const certification              = @"certification";
//更多新闻
static NSString *const headlinesList              = @"headlinesList";

//客服中心
static NSString *servceCenter                     = @"serviceCenterMain";

//首页搜索
static NSString *searchUrl                        = @"homeSearch";

//我要入驻
static NSString *entering                         = @"contract/#/signingIndex?type=2";

//j检查升级接口
static NSString *const upGradeApp                 = @"contract/#/upgrade";

//分享注册接口
static NSString *const sharedRegist               = @"/app_html/registered/registered.html?invite_code=%@";


//申请列表
static NSString *const applacationList            = @"/app_html/enter_shop_model/#/list";


//新闻详情
static NSString *newsListDetaile                  = @"headlinesList/headlinesDetail?news_id=%@";

#endif /* Header_SXF_h */
