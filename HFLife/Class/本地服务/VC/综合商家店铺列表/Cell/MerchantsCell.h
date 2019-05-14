//
//  MerchantsCell.h
//  HanPay
//
//  Created by 张海彬 on 2019/4/19.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MerchantsCell : UITableViewCell

/**
 图片路径
 */
@property (nonatomic,strong)NSString *iconString;

/**
 标题
 */
@property (nonatomic,strong)NSString *titleString;

/**
 距离
 */
@property (nonatomic,strong)NSString *distance;

/**
 位置
 */
@property (nonatomic,strong)NSString *location;

/**
 让利
 */
@property (nonatomic,strong)NSString *benefit;

/**
 星级
 */
@property (nonatomic,assign)NSInteger star_level;
@end

NS_ASSUME_NONNULL_END
