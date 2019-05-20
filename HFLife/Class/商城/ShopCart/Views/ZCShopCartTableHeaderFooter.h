//
//  ZCShopCartTableHeaderFooter.h
//  HFLife
//
//  Created by zchao on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// tableHeader
@interface ZCShopCartTableHeaderView : UIView

@end

// 空空如也header
@interface ZCShopCartEmptyHeaderView : UIView

@end

/// tableFooter
@interface ZCShopCartTableFooterView : UIView

@property(nonatomic, copy) NSArray *dataArray;


@end





NS_ASSUME_NONNULL_END
