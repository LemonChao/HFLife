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

/************************yourTools************************/


//y图片拼接


#define URL_IMAGE(url)  [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL, url ? url : @""]]




/************************subUrl************************/
//申请列表(web)
#define OPENSHOPURLLIST @"https://www.hfgld.net/app_html/enter_shop_model/#/list"



//版本信息
static NSString *const appUpDateUrl = @"api/version/getVersion";

//获取版本信息
static NSString *const upDateLocationUrl = @"";

//首页轮播导航接口
static NSString *const HomeNavBanner                            = @"api/index/navBanner";
//首页头条列表
static NSString *const HomeNewsList                             = @"api/index/newsList";
//首页头条详情
static NSString *const HomeNewsDetaile                          = @"api/index/getDetail";

/************************subUrl************************/









#endif /* Header_SXF_h */
