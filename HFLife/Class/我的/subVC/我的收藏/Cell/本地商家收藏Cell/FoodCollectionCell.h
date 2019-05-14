//
//  FoodCollectionCell.h
//  HanPay
//
//  Created by mac on 2019/1/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FoodCollectionCell : UITableViewCell
+ (instancetype)FoodCollectionCellWithTableView:(UITableView *)tableView;
/** 标题*/
@property (nonatomic,copy)NSString *titleString;
/**
 星级
 */
@property (nonatomic,assign)NSInteger star_level;

/** 地址*/
@property (nonatomic,copy)NSString *address;
/** 距离*/
@property (nonatomic,copy)NSString *distance;
/** 店铺图片*/
@property (nonatomic,copy)NSString *img;
@end

NS_ASSUME_NONNULL_END
