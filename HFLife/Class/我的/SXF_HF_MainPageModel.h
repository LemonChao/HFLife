//
//  SXF_HF_MainPageModel.h
//  HFLife
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_MainPageModel : BaseModel

@end



@interface AddressModel : BaseModel

/**
 地址ID
 */
@property (nonatomic,strong)NSString *address_id;

/**
 名字
 */
@property (nonatomic,strong)NSString *true_name;

/**
 区ID
 */
@property (nonatomic,strong)NSString *area_id;

/**
 地区
 */
@property (nonatomic,strong)NSString *area_info;

/**
 详细地址
 */
@property (nonatomic,strong)NSString *address;

/**
 手机号
 */
@property (nonatomic,strong)NSString *mob_phone;

/**
 是否默认
 */
@property (nonatomic,strong)NSString *is_default;

/**
 城市ID
 */
@property (nonatomic ,copy) NSString *city_id;

/**
 省ID
 */
@property (nonatomic ,copy) NSString *province_id;
@end

//好友列表model
@interface friengListModel : BaseModel
@property (nonatomic, strong)NSNumber *ID;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *addtime;
@property (nonatomic, strong)NSString *img;
@property (nonatomic, strong)NSDictionary *level_info;
@property (nonatomic, strong)NSString *buy_all_money;
@property (nonatomic, strong)NSString *added_coin;
@property (nonatomic, strong)NSString *member_time;
@end


@interface  MyCollectionModel : BaseModel
//{
//    "log_id": "3",                        //收藏id
//    "fav_id": "100012",                    //商品id
//    "fav_time": "2019-01-30 16:37:46",    //收藏时间
//    "store_id": "1",                    //店铺id
//    "store_name": "汉富",                    //店铺名称
//    "goods_name": "女鞋平底鞋 蓝色 38",    //商品名称
//    "goods_image": "http://hf2.kim/system/upfiles/shop/store/goods/1/1_06009656186419023.png",
//    "log_price": "200.00"            //价格
//}
@property (nonatomic,copy)NSString *log_id;
@property (nonatomic,copy)NSString *fav_id;
@property (nonatomic,copy)NSString *fav_time;
@property (nonatomic,copy)NSString *store_id;
@property (nonatomic,copy)NSString *store_name;
@property (nonatomic,copy)NSString *goods_name;
@property (nonatomic,copy)NSString *goods_image;
@property (nonatomic,copy)NSString *log_price;

@end
@interface  MyCollectionShopModel : BaseModel

// !!!: 商家收藏
//{
//    "collect_id": "6",            //收藏id
//    "shop_id": "3",                //店铺id
//    "collect_type": "1",        //1 美食 2酒店 3待完善
//    "shop_name": "蛋蛋的灌饼",    //店铺名称
//    "photo": "http://hf2.win/system/upfiles/shop/store/06016620269565215.jpg",        //店铺头像
//    "explain": "二七广场商圈 面包甜点"
//}
@property (nonatomic,copy)NSString *collect_id;
@property (nonatomic,copy)NSString *shop_id;
@property (nonatomic,copy)NSString *collect_type;
@property (nonatomic,copy)NSString *shop_name;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,copy)NSString *explain;

@end




NS_ASSUME_NONNULL_END
