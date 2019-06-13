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





/************************subUrl************************/

#define shopHost        @"ceshi-shop.hfgld.net/"
//#define shopWebHost     @"http://ceshi-web.hfgld.net/mall/    //域名
//#define shopWebHost     @"http://192.168.0.143:1111/"
#define shopWebHost     @"http://192.168.0.172:8080/"            //小曲
#define shopUrl(subUrl)    [NSString stringWithFormat:@"%@api/mobile/index.php?%@",shopHost,subUrl]

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

// 商城-购物车-删除购物车商品
#define shopCartDelete      shopUrl(@"w=member_cart&t=cart_delall")

// 商城-订单中心-首页
#define shopOrderCenterHome shopUrl(@"w=member_index")

//支付宝轮询订单状态
#define pollingOrderState   shopUrl(@"w=pay_state&t=index")

#endif /* Header_ZC_h */
