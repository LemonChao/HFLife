//
//  TFCNetApiMacro.h
//  TFC
//
//  Created by mac on 2018/6/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#ifndef TFCNetApiMacro_h
#define TFCNetApiMacro_h





#ifdef DEBUG




//#define GP_BASEURL  @"https://hzf2-mall.zhongchangjy.com"
//#define GDP_BASEURL @"https://hzf2-mall.zhongchangjy.com/api/app/index.php"
//#define GDP_IMAGEBASEURL @"https://hzf2-mall.zhongchangjy.com/api/mobile/index.php"
//#define GDP_UpdateToken @""
//
////开店URL
//#define OPENSHOPURL @"https://hzf2-mall.zhongchangjy.com/app_html/enter_shop_model/#/enter"
////申请列表
//#define OPENSHOPURLLIST @"https://hzf2-mall.zhongchangjy.com/app_html/enter_shop_model/#/list"
////VR 的 URL
//#define VRURL @"https://hzf2-mall.zhongchangjy.com/app_html/vr_shop/#/VRmall"
////线上商城
//#define OnlineMall @"https://hzf2-mall.zhongchangjy.com/mobile/"



//#define GP_BASEURL  @"https://www.hfgld.net"
//#define GDP_BASEURL @"https://www.hfgld.net/api/app/index.php"
//#define GDP_IMAGEBASEURL @"https://www.hfgld.net/api/mobile/index.php"
//#define TFC_BASEIMAGEURL @"https://appt.tfp.kim"
//#define GDP_UpdateToken @""
////开店URL
////#define OPENSHOPURL @"https://www.hfgld.net/app_html/enter_shop_model/#/enter"
//#define OPENSHOPURL @"http://192.168.0.118:8080/#/enter"
////申请列表
//#define OPENSHOPURLLIST @"https://www.hfgld.net/app_html/enter_shop_model/#/list"
////VR 的 URL
//#define VRURL @"https://www.hfgld.net/app_html/vr_shop/#/VRmall"
////线上商城
//#define OnlineMall @"http://www.hfgld.net/mobile/"

// !!!:线上测试地址
#define GP_BASEURL  @"http://test.hfgld.net"
#define GDP_BASEURL @"http://test.hfgld.net/api/app/index.php"
#define GDP_IMAGEBASEURL @"http://test.hfgld.net/api/mobile/index.php"
#define TFC_BASEIMAGEURL @"https://appt.tfp.kim"
#define GDP_UpdateToken @""
//开店URL
#define OPENSHOPURL @"http://test.hfgld.net/app_html/enter_shop_model/#/enter"
//申请列表
#define OPENSHOPURLLIST @"http://test.hfgld.net/app_html/enter_shop_model/#/list"
//VR 的 URL
#define VRURL @"http://test.hfgld.net/app_html/vr_shop/#/VRmall"
//线上商城
#define OnlineMall @"http://test.hfgld.net/mobile/"



#else
#define GP_BASEURL  @"https://www.hfgld.net"
#define GDP_BASEURL @"https://www.hfgld.net/api/app/index.php"
#define GDP_IMAGEBASEURL @"https://www.hfgld.net/api/mobile/index.php"
#define TFC_BASEIMAGEURL @"https://appt.tfp.kim"
#define GDP_UpdateToken @""
//开店URL
#define OPENSHOPURL @"https://www.hfgld.net/app_html/enter_shop_model/#/enter"
//申请列表
#define OPENSHOPURLLIST @"https://www.hfgld.net/app_html/enter_shop_model/#/list"
//VR 的 URL
#define VRURL @"https://www.hfgld.net/app_html/vr_shop/#/VRmall"
//线上商城
#define OnlineMall @"http://www.hfgld.net/mobile/"






#endif


#endif /* TFCNetApiMacro_h */
