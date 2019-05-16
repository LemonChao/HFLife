//
//  ZCShopClassifyModel.m
//  HFLife
//
//  Created by zchao on 2019/5/16.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopClassifyModel.h"

@implementation ZCShopClassifyListChildModel


@end


@implementation ZCShopClassifyListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"gc_id":@[@"brand_id",@"gc_id"],
             @"gc_name":@[@"brand_name",@"gc_name"]};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"child":[ZCShopClassifyListModel class]};
}
@end

@implementation ZCShopClassifyModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"class_list":[ZCShopClassifyListModel class]};
}

@end
