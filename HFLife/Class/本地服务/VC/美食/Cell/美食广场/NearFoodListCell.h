//
//  NearFoodListCell.h
//  HanPay
//
//  Created by 张海彬 on 2019/1/14.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NearFoodListCell : UITableViewCell
/**
 图片名
 */
@property (nonatomic,strong)NSString *imageName;

/**
 标题
 */
@property (nonatomic,strong)NSString *titleString;


/**
 销售情况 类型这样的->月售207
 */
@property (nonatomic,strong)NSString *salesString;


/**
 优惠情况（字符串数组）
 */
@property (nonatomic,strong)NSArray <NSString*>*preferentialArray;

/**
 起送费
 */
@property (nonatomic,strong)NSString *upToSend;

/**
 配送费
 */
@property (nonatomic,strong)NSString *distributionMoney;

/**
 星级
 */
@property (nonatomic,assign)NSInteger star_level;

/**
 人气
 */
@property (nonatomic,strong)NSString *sentiment;

/**
 时间距离
 */
@property (nonatomic,strong)NSString *timeDistance;

/**
 附近
 */
@property (nonatomic,strong)NSString *near;

/**
 数据源
 */
@property (nonatomic,strong)NSDictionary *dataDict;
@end

NS_ASSUME_NONNULL_END
