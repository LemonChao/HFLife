//
//  Header_ZC.h
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#ifndef Header_ZC_h
#define Header_ZC_h




/************************yourTools************************/
#import "UIView+BadgeValue.h"
#import "UITool.h"
#import <YYModel/YYModel.h>
#import "ZCShopWebViewController.h"





#if DEBUG//测试线

#if LOCALTEST //(本地测试)
#define shopHost        @"shop.hfgld.net"                  //后台接口域名
#define shopWebHost     @"https://web.hfgld.net"           //web域名

#else //(线上测试)
#define shopHost        @"ceshi-shop.hfgld.net"                  //后台接口域名
#define shopWebHost     @"https://ceshi-web.hfgld.net"           //web域名
#endif

#else//正式线上
#define shopHost        @"shop.hfgld.net"                  //后台接口域名
#define shopWebHost     @"https://web.hfgld.net"           //web域名
#endif


/************************subUrl************************/

#define shopUrl(subUrl)    [NSString stringWithFormat:@"%@/api/mobile/index.php?%@",shopHost,subUrl]

// 商城-首页-专属推荐
#define shopHomeTui_Goods   shopUrl(@"w=index&t=get_tui_goods")

// 商城-首页-剩余数据(除去专属推荐)
#define shopHomeIndex        shopUrl(@"w=index&t=index")

// 商城-分类-分类列表
#define shopClassifyIndex    shopUrl(@"w=goods_class&t=fenlei")

// 商城-购物车-猜你喜欢
#define shopCartGussLike    shopUrl(@"w=member_cart&t=guess_like")

// 商城-购物车-购物车列表
#define shopCartList        shopUrl(@"w=member_cart&t=cart_list")

// 商城-购物车-修改购物车数量
#define shopCartQuantity    shopUrl(@"w=member_cart&t=cart_edit_quantity")

// 商城-购物车-删除购物车商品
#define shopCartDelete      shopUrl(@"w=member_cart&t=cart_delall")

// 商城-购物车-添加到购物车
#define shopCartAdd         shopUrl(@"w=member_cart&t=cart_add")

// 商城-订单中心-首页
#define shopOrderCenterHome shopUrl(@"w=member_index")

//支付宝轮询订单状态
#define pollingOrderState   shopUrl(@"w=pay_state&t=index")

#endif /* Header_ZC_h */
