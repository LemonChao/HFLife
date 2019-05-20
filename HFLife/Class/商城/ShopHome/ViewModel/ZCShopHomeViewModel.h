//
//  ZCShopHomeViewModel.h
//  HFLife
//
//  Created by zchao on 2019/5/13.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCShopHomeModel.h"
#import "ZCExclusiveRecommendModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCShopHomeViewModel : BaseViewModel

/// 首页刷新，两个接口
@property(nonatomic, strong) RACCommand *shopRefreshCmd;

/// 加载更多
@property(nonatomic, strong) RACCommand *shopLoadMoreCmd;

//@property(nonatomic, strong) ZCShopHomeModel *homeModel;

/** 列表数据 */
@property(nonatomic, copy) NSArray <__kindof NSArray *>*dataArray;

/** 轮播数据 */
@property(nonatomic, copy) NSArray <__kindof ZCShopHomeBannerModel*>*bannerArray;
/** 分类数据 */
@property(nonatomic, copy) NSArray <__kindof ZCShopHomeClassModel*>*classArray;


@end

NS_ASSUME_NONNULL_END
