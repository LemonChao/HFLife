//
//  ZC_HF_CollectionCycleHeader.h
//  HFLife
//
//  Created by zchao on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCShopHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZC_HF_CollectionCycleHeader : UICollectionReusableView

@property(nonatomic, copy) NSArray<__kindof ZCShopHomeBannerModel *> *bannerList;

@property(nonatomic, copy) NSArray <__kindof ZCShopHomeClassModel *>*classList;

@end

@interface ZC_HF_CollectionWordsHeader : UICollectionReusableView

@end


NS_ASSUME_NONNULL_END
