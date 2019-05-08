//
//  NearColumnCell.h
//  HanPay
//
//  Created by 张海彬 on 2019/1/8.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  NearColumnDelegate <NSObject>

@optional


/**点击banner 广告位*/




/**
 点击活动图

 @param dataModel 数据源
 */
-(void)clickActivityDataModel:(id)dataModel;
/**
 点击栏目分类

 @param indexPath 点击位置
 @param dataModel 数据源
 */
-(void)clickColumnClassificationIndexPath:(NSIndexPath *)indexPath dataModel:(id)dataModel;
- (void) selectedBannerImageIndex:(NSInteger)index Url:(NSString *)url;
@end
@interface NearColumnCell : UITableViewCell
/** 代理 */
@property (nonatomic , weak) id <NearColumnDelegate> delegate;
@property (nonatomic,strong) id dataModel;
//@property (nonatomic, strong)NSArray <bannerModel *>*bannerListModel;
@end

NS_ASSUME_NONNULL_END
