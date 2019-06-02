//
//  ZCShopCartTableHeaderFooter.h
//  HFLife
//
//  Created by zchao on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCShopCartViewModel.h"

NS_ASSUME_NONNULL_BEGIN
/// tableHeader
@interface ZCShopCartTableHeaderView : UIView

@property(nonatomic, copy) NSString *title;

@end

// 空空如也header
@interface ZCShopCartEmptyHeaderView : UIView

@end

/// tableFooter
@interface ZCShopCartTableFooterView : UIView

@property(nonatomic, copy) NSArray *dataArray;

@property(nonatomic, strong) ZCShopCartViewModel *viewModel;
@end


// payResultVC headerView
@interface ZCShopCartPayResultHeaderView : UIView

@end


NS_ASSUME_NONNULL_END
