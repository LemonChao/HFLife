//
//  baseCollectionView.h
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface baseCollectionView : UICollectionView
@property (nonatomic ,copy) void (^refreshHeaderBlock)(void);//下啦
@property (nonatomic ,copy) void (^refreshFooterBlock)(void);//上啦
@property (nonatomic ,copy) void (^complateBlock)(void);//无更多数据block
@property (nonatomic ,assign) NSInteger page;

@property (nonatomic ,strong) MJRefreshFooter *footer;
@property (nonatomic, strong) MJRefreshGifHeader *header;

@property (nonatomic ,assign) BOOL activityGifHeader;//是否激活 动画刷新 默认yes
@property (nonatomic ,strong) NSString *gifSourceName;//动画图片名字

- (void) endRefreshData;
@end

NS_ASSUME_NONNULL_END
