//
//  ZCShopHomeModel.h
//  HFLife
//
//  Created by zchao on 2019/5/14.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCShopHomeBannerModel : BaseModel
//"mobile_banner_id": "2",
//"mobile_banner_image": "http://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/store/mobile/7c48784c7c6e7bbadeaef080ba8e033e.jpg",
//"mobile_banner_desc": "banner1",
//"mobile_banner_url": "",
//"mobile_banner_create_time": "0",
//"mobile_banner_show": "1"

@property(nonatomic, copy) NSString *mobile_banner_id;
@property(nonatomic, copy) NSString *mobile_banner_image;
@property(nonatomic, copy) NSString *mobile_banner_desc;
@property(nonatomic, copy) NSString *mobile_banner_url;

@end

@interface ZCShopHomeLimitModel : BaseModel
//"xianshi_goods_id": "19",
//"xianshi_id": "14",
//"xianshi_name": "限时秒杀",
//"xianshi_title": "",
//"xianshi_explain": "",
//"goods_id": "100101",
//"store_id": "63",
//"goods_name": "美特斯邦威白色短袖t恤男夏季休闲纯色打底衫男潮流纯棉透气衣服",
//"goods_price": "0.10",
//"xianshi_price": "0.01",
//"goods_image": "http://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/store/shop/744837e66a32d5a581fb85e07c551c81.jpg",
//"start_time": "1556261040",
//"end_time": "1558365801",
//"lower_limit": "1",
//"state": "1",
//"xianshi_recommend": "0",
//"gc_id_1": "1"

@property(nonatomic, copy) NSString *xianshi_goods_id;
@property(nonatomic, copy) NSString *goods_image;
@property(nonatomic, copy) NSString *goods_name;
@property(nonatomic, copy) NSString *mobile_banner_id;
@property(nonatomic, copy) NSString *start_time;
@property(nonatomic, copy) NSString *end_time;
@property(nonatomic, copy) NSString *goods_price;
@property(nonatomic, copy) NSString *xianshi_price;


@end

@interface ZCShopNewGoodsModel : BaseModel

//"goods_id": "100103",
//"goods_name": "回力男鞋帆布鞋春季2019新款鞋子韩版百搭休闲潮鞋板鞋男士小白鞋",
//"goods_price": "0.10",
//"goods_fan_price": "0.02",
//"goods_sale_price": "0.10",
//"goods_sale_type": "0",
//"goods_image": "http://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/store/shop/39a17e01629a289a0a9ecd78fa4874b3.jpg"

@property(nonatomic, copy) NSString *goods_id;
@property(nonatomic, copy) NSString *goods_name;
@property(nonatomic, copy) NSString *goods_price;
@property(nonatomic, copy) NSString *goods_fan_price;
@property(nonatomic, copy) NSString *goods_sale_price;
@property(nonatomic, copy) NSString *goods_image;

@end

/// 常规布局cellmodel 非瀑布流
@interface ZCShopNormalCellModel : BaseModel

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSArray *cellDatas;

@property(nonatomic, assign) CGFloat rowHeight;

@end






@interface ZCShopHomeModel : BaseModel

/** 轮播列表 */
@property(nonatomic, copy) NSArray <__kindof ZCShopHomeBannerModel *>*banner_list;
/** 限时抢购 */
@property(nonatomic, copy) NSArray <__kindof ZCShopHomeLimitModel *>*limit_time_goods;
/** 新品推荐 */
@property(nonatomic, copy) NSArray <__kindof ZCShopNewGoodsModel *>*shop_newGoods;
@end

NS_ASSUME_NONNULL_END
