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







NS_ASSUME_NONNULL_END
