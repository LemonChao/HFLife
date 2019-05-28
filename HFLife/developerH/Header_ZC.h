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
#define shopWebHost     @"http://192.168.0.172:8080/"

#define shopUrl(subUrl)    [NSString stringWithFormat:@"%@api/mobile/index.php?%@",shopHost,subUrl]

// 商城-首页-专属推荐
#define shopHomeTui_Goods   shopUrl(@"w=index&t=get_tui_goods")

// 商城-首页-剩余数据(除去猜你喜欢)
#define shopHomeIndex        shopUrl(@"w=index&t=index")

// 商城-分类-分类列表
#define shopClassifyIndex    shopUrl(@"w=goods_class&t=fenlei")

// 商城-购物车-猜你喜欢
#define shopCartGussLike    shopUrl(@"w=member_cart&t=guess_like")

// 商城-购物车-购物车列表
#define shopCartList        shopUrl(@"w=member_cart&t=cart_list")

#endif /* Header_ZC_h */
