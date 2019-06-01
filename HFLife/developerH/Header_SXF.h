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
//申请列表(web)
#define OPENSHOPURLLIST @"https://www.hfgld.net/app_html/enter_shop_model/#/list"



//版本信息
static NSString *const appUpDateUrl                          = @"ceshi-ucenter.hfgld.net/api/version/getVersion";

//获取版本说明
static NSString *const VersionContent                         = @"ceshi-ucenter.hfgld.net/api/version/getVersionContent";

//获取服务协议
static NSString *const ServiceAgreement                       = @"ceshi-ucenter.hfgld.net/api/system/getServiceAgreement";

//获取版本信息
//上传定位
static NSString *const upDateLocationUrl = @"ceshi-life.hfgld.net/index.php/api/common/setUserAddress";

//首页轮播导航接口
static NSString *const HomeNavBanner                            = @"ceshi-ucenter.hfgld.net/api/index/homePage";
//首页头条列表
static NSString *const HomeNewsList                             = @"ceshi-ucenter.hfgld.net/api/index/newsList";
//首页头条详情
static NSString *const HomeNewsDetaile                          = @"ceshi-ucenter.hfgld.net/api/index/getDetail";

/**
 获取收款码或付款码（1）
 */
static NSString *const CreateMoneyQrcode                        = @"ceshi-ucenter.hfgld.net/api/finance/createMoneyQrcode";

/**
 扫描收款码或付款码解析信息（2）
 */
static NSString *const GetQrcodeInfo                            = @"ceshi-ucenter.hfgld.net/api/finance/getQrcodeInfo";

/**
 扫码付款生成订单（3）
 */
static NSString *const CreateOrder                              = @"ceshi-ucenter.hfgld.net/api/finance/createOrder";

/**
 订单支付（4）
 */
static NSString *const GoToPay                              = @"ceshi-ucenter.hfgld.net/api/finance/goToPay";

/************************subUrl************************/



#define SXF_WEB_URLl_Str(subUrl)        [NSString stringWithFormat:@"http://192.168.0.104:8080/%@", subUrl ? subUrl : @""]
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

#endif /* Header_SXF_h */
