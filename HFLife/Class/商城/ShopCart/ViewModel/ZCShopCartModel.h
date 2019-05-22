//
//  ZCShopCartModel.h
//  HFLife
//
//  Created by zchao on 2019/5/21.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCShopCartGoodsModel : BaseModel

/** 商品在购物车表的id */
@property(nonatomic, copy) NSString *cart_id;
/** 购买者id */
@property(nonatomic, copy) NSString *buyer_id;
/** 店铺id */
@property(nonatomic, copy) NSString *store_id;
/** 店铺名称 */
@property(nonatomic, copy) NSString *store_name;
/** 商品id */
@property(nonatomic, copy) NSString *goods_id;
/** 商品名称 */
@property(nonatomic, copy) NSString *goods_name;
@property(nonatomic, copy) NSString *goods_price;
/** 商品数量 */
@property(nonatomic, copy) NSString *goods_num;
/** 商品图片 */
@property(nonatomic, copy) NSString *goods_image;
/** 库存 */
@property(nonatomic, copy) NSString *goods_storage;
/** 商品总价 */
@property(nonatomic, copy) NSString *goods_total;
/** 商品是否被选中 */
@property(nonatomic, assign, getter=isSelected) BOOL selected;
//@property(nonatomic, copy) NSString *cart_id;
//@property(nonatomic, copy) NSString *cart_id;
//@property(nonatomic, copy) NSString *cart_id;
//@property(nonatomic, copy) NSString *cart_id;
//@property(nonatomic, copy) NSString *cart_id;
//@property(nonatomic, copy) NSString *cart_id;


@end



@interface ZCShopCartModel : BaseModel

@property(nonatomic, copy) NSString *store_id;
@property(nonatomic, copy) NSString *store_name;
@property(nonatomic, copy) NSArray <__kindof ZCShopCartGoodsModel*>*goods;

/** 本区(店铺)是否全选 */
@property(nonatomic, assign,getter=isSelectAll) BOOL selectAll;

@end


/// 猜你喜欢
@interface ZCShopCartLikeModel : BaseModel

@property(nonatomic, copy) NSString *goods_id;
@property(nonatomic, copy) NSString *goods_name;
@property(nonatomic, copy) NSString *goods_price;
@property(nonatomic, copy) NSString *goods_sale_price;
@property(nonatomic, copy) NSString *goods_salenum;
@property(nonatomic, copy) NSString *goods_sale_type;
@property(nonatomic, copy) NSString *goods_marketprice;
@property(nonatomic, copy) NSString *goods_image;
@property(nonatomic, copy) NSString *store_id;

@end


NS_ASSUME_NONNULL_END
