//
//  ZCShopHomeViewModel.h
//  HFLife
//
//  Created by zchao on 2019/5/13.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCShopHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCShopHomeViewModel : BaseViewModel

/// 首页刷新，两个接口
@property(nonatomic, strong) RACCommand *shopRefreshCmd;

/// 加载更多
@property(nonatomic, strong) RACCommand *shopLoadMoreCmd;

@property(nonatomic, strong) ZCShopHomeModel *homeModel;

@property(nonatomic, assign) NSUInteger section;


@end

NS_ASSUME_NONNULL_END
