//
//  SXF_HF_HomePageVM.h
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXF_HF_HomePageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_HomePageVM : NSObject
@property (nonatomic, strong)UIViewController *vc;
@property (nonatomic, strong)SXF_HF_HomePageView *collectionView;

- (void) getBannerData;

- (void) getNewsListData:(NSInteger)page;

- (void) clickActivityBtn:(NSString *)btnUrl;

/**
 更新位置
 */
- (void)upDataLocation;


/**
 点击分区头
 */
- (void)clickHeaderBtn:(NSInteger) index;

/**
    点击分区cell
 */
- (void)clickCellItem:(NSIndexPath *)indexPath value:(id)value;


/**
 开启定时器
 */
- (void)fireTimer;
/**
 释放定时器
 */
- (void)cancleTimer;
@end

NS_ASSUME_NONNULL_END
