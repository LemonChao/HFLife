//
//  FoodPreferentialCell.h
//  HanPay
//
//  Created by 张海彬 on 2019/1/12.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  FoodPreferentialDelegate <NSObject>

@optional

/**
 点击优惠的商品
 
 @param dataModel 数据
 */
-(void)clickRecommendedGoodsDataModel:(id)dataModel;
@end
@interface FoodPreferentialCell : UITableViewCell
/** 代理 */
@property (nonatomic , weak) id <FoodPreferentialDelegate> delegate;
@property (nonatomic,strong)id dataModel;
@end

NS_ASSUME_NONNULL_END
