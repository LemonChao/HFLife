//
//  FoodClassifyCell.h
//  HanPay
//
//  Created by 张海彬 on 2019/1/11.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "nearPageModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol  FoodClassifyDelegate <NSObject>

@optional
/**
 点击栏目分类
 
 @param indexPath 点击位置
 @param dataModel 数据源
 */
-(void)clickColumnClassificationIndexPath:(NSIndexPath *)indexPath dataModel:(id)dataModel;
@end
@interface FoodClassifyCell : UITableViewCell
/** 代理 */
@property (nonatomic , weak) id <FoodClassifyDelegate> delegate;
//@property (nonatomic,strong)nearHotelModel *dataModel;
@end

NS_ASSUME_NONNULL_END
