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
/************************yourTools************************/




/************************subUrl************************/
static NSString *const zcTestUrl = @"w=index&t=index";

/************************subUrl************************/

#define shopHost @"ceshi-shop.hfgld.net/"

#define shopUrl(subUrl)    [NSString stringWithFormat:@"%@api/mobile/index.php?%@",shopHost,subUrl]

#define shopCartList        shopUrl(@"w=member_cart&t=cart_list")

#define shopCartTui_Goods   shopUrl(@"w=index&t=get_tui_goods")

#define shopCartHome        shopUrl(@"w=index&t=index")

#define shopCartClassify    shopUrl(@"w=goods_class&t=fenlei")

#define shopCartGussLike    shopUrl(@"w=member_cart&t=guess_like")
#endif /* Header_ZC_h */
