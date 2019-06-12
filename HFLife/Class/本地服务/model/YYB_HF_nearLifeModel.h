//
//  YYB_HF_nearLifeModel.h
//  HFLife
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class EntranceDetail;

/**
 附近生活商家、banner数据
 */
@interface YYB_HF_nearLifeModel : BaseModel
//"city_now": "郑州",  //当前城市
//"is_notice": 0,  //是否有消息提醒
////快捷入口
//"entrance": [
//             {
//                 "name": "商家入驻",  //名称
//                 "icon": "https://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/locallife/admin/0f5bd26bc57dc12851ce8e61ee472320.png",  //图标
//                 "url": ""   //链接
//             }]


@property(nonatomic, copy) NSString *city_now;
//@property(nonatomic, strong) NSNumber *is_notice;
@property(nonatomic, strong) NSArray<EntranceDetail*> *entrance;
////banner图
//"banner": [
//           "http://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/locallife/admin/7cb2b6a9bc572736876194418001ee3f.png"]
@property(nonatomic, strong) NSArray *banner;


@end

/**
 分类商家项
 */
@interface EntranceDetail : BaseModel
//{
//    "name": "商家入驻",  //名称
//    "icon": "https://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/locallife/admin/0f5bd26bc57dc12851ce8e61ee472320.png",  //图标
//    "url": ""   //链接
//}

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *icon;
@property(nonatomic, copy) NSString *url;

@end

/**
 猜你喜欢
 */
@interface GuessLikeModel : BaseModel
/** 店铺id */
@property(nonatomic, strong) NSNumber *id;
/** 详情图（为空时返回空对象） */
@property(nonatomic, strong) NSArray *detail_photo;
/** 距离（km）） */
@property(nonatomic, copy) NSString *distance;
/** 返利 */
@property(nonatomic, copy) NSString *fan_price;
/** 经纬度 */
@property(nonatomic, copy) NSString *lat;
@property(nonatomic, copy) NSString *lng;
/** 原价 */
@property(nonatomic, copy) NSString *original_price;
/** 简介 */
@property(nonatomic, copy) NSString *product_intro;
/** 产品名称 */
@property(nonatomic, copy) NSString *product_name;
/** 预览图 */
@property(nonatomic, copy) NSString *product_photo;
/** 售价 */
@property(nonatomic, copy) NSString *product_price;
/** 店铺类型 1：美食套餐 2：酒店 3：综合商家 */
@property(nonatomic, copy) NSNumber *product_type;
/** 店铺id */
@property(nonatomic, copy) NSNumber *store_id;
/** 店铺名称 */
@property(nonatomic, copy) NSString *store_name;
/** 跳转地址 */
@property(nonatomic, copy) NSString *url;

@end

/**
 酒店搜索
 */
@interface SearchHotelList : BaseModel

//{
//    "id": 3,   //酒店id
//    "logo_image": "http://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/food/611269fafaaa2921027b980c4526c4b8.jpg",    //logo图
//    "hotel_name": "如家酒店（郑州CBD会展中心店）",    //酒店名称
//    "hotel_address": "商务内环路与通泰路交叉口往东20米新浦大厦",   //酒店地址
//    "evaluate_num": 0,    //评价人数
//    "evaluate_star": 3,   //评分
//    "consume_min": 100,   //最低消费
//    "distance": 4.74    //距离（km）,
//    "type": 2
//}

@property(nonatomic, strong) NSNumber *ID;
@property(nonatomic, copy) NSString *logo_image;
@property(nonatomic, copy) NSString *hotel_name;
@property(nonatomic, copy) NSString *hotel_address;
/** 评价人数 */
@property(nonatomic, strong) NSNumber *evaluate_num;
/** 评分 */
@property(nonatomic, strong) NSNumber *evaluate_star;
/** 最低消费 */
@property(nonatomic, strong) NSNumber *consume_min;
@property(nonatomic, strong) NSNumber *distance;
@property(nonatomic, strong) NSNumber *type;
@property(nonatomic, copy) NSString *url;

@end

/**
 美食搜索
 */
@interface SearchFoodList : BaseModel

//{
//    "id": 1,
//    "food_name": "个人美食店铺 test",
//    "score_star": 3,
//    "consume_avg": 60,
//    "logo_image": "http://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/locallife/admin/eec4236b95f3abace045babf97ae0ef9.jpg",
//    "distance": 1.71,
//    "coupon": "100元代金券",
//    "detail_list": "披萨（8寸）,披萨（10寸）,雪碧",
//    "type": 1  //搜索类型 1：美食 2：酒店
//}

@property(nonatomic, strong) NSNumber *ID;
@property(nonatomic, copy) NSString *food_name;
/** 评分 */
@property(nonatomic, strong) NSNumber *score_star;
/** 人均消费 */
@property(nonatomic, strong) NSNumber *consume_avg;
@property(nonatomic, copy) NSString *logo_image;
@property(nonatomic, strong) NSNumber *distance;
/** 代金券 */
@property(nonatomic, copy) NSString *coupon;

@property(nonatomic, copy) NSString *detail_list;
@property(nonatomic, strong) NSNumber *type;
@property(nonatomic, copy) NSString *url;

@end


NS_ASSUME_NONNULL_END
