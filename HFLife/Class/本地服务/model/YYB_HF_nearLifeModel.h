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
@property(nonatomic, strong) NSNumber *is_notice;
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

@end





NS_ASSUME_NONNULL_END
