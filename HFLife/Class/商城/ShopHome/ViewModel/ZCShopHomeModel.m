//
//  ZCShopHomeModel.m
//  HFLife
//
//  Created by zchao on 2019/5/14.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopHomeModel.h"
@implementation ZCShopHomeBannerModel
//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"good_list":@"mobile_banner_id"};
//}


@end

@implementation ZCShopHomeLimitModel



@end

@implementation ZCShopNewGoodsModel


@end



@implementation ZCShopHomeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"shop_newGoods":@"new_goods"};
}


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"banner_list":[ZCShopHomeBannerModel class],
             @"limit_time_goods":[ZCShopHomeLimitModel class],
             @"shop_newGoods":[ZCShopNewGoodsModel class]
             };
}



@end
