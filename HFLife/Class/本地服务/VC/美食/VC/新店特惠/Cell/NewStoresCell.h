//
//  NewStoresCell.h
//  HanPay
//
//  Created by 张海彬 on 2019/1/15.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewStoresCell : UITableViewCell
/**
 图片名
 */
@property (nonatomic,strong)NSString *imageName;

/**
 标题
 */
@property (nonatomic,strong)NSString *titleString;

/**
 多少颗星
 */
@property (nonatomic,assign)NSInteger starCount;

/**
 星级
 */
@property (nonatomic,assign)NSInteger star_level;

/**
 地址
 */
@property (nonatomic,strong)NSString *address;

/**
 优惠情况
 */
@property (nonatomic,strong)NSString *preferential;

/**
 售价 ¥25/人 类似这样的值
 */
@property (nonatomic,strong)NSString *price;

/**
 人气
 */
@property (nonatomic,strong)NSString *opularity;

/**
 距离
 */
@property (nonatomic,strong)NSString *distance;




/**
 数据源
 */
@property (nonatomic, strong)NSDictionary *dataSource;

@end

NS_ASSUME_NONNULL_END
