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




/************************subUrl************************/

//存储token
static NSString *const USER_TOKEN              = @"userToken";
//存储登录状态
static NSString *const LOGIN_STATES            = @"loginStates";



//申请列表(web)
#define OPENSHOPURLLIST @"https://www.hfgld.net/app_html/enter_shop_model/#/list"



static NSString *const appUpDateUrl = @"";
static NSString *const upDateLocationUrl = @"";

//首页轮播导航接口
static NSString *const HomeNavBanner  =@"api/index/navBanner";

static NSString *const shopUrl = @"w=index&t=index";

/************************subUrl************************/









#endif /* Header_SXF_h */
