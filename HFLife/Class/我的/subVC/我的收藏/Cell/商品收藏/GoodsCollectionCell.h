//
//  GoodsCollectionCell.h
//  HanPay
//
//  Created by mac on 2019/1/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsCollectionCell : UITableViewCell
+ (instancetype)GoodsCollectionCellWithTableView:(UITableView *)tableView;
/** 标题*/
@property (nonatomic,copy)NSString *titleString;

/** 收藏人数*/
@property (nonatomic,copy)NSString *number;

/** 价钱*/
@property (nonatomic,copy)NSString *price;
/** 商品图片*/
@property (nonatomic,copy)NSString *img;
@end

NS_ASSUME_NONNULL_END
