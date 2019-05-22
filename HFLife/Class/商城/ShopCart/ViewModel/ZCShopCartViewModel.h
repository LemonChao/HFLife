//
//  ZCShopCartViewModel.h
//  HFLife
//
//  Created by zchao on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "BaseViewModel.h"
#import "ZCShopCartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCShopCartViewModel : BaseViewModel

/** 购物车列表数据 */
@property(nonatomic, strong) RACCommand *cartCmd;

/** 购物车删除 单个，批量 */
@property(nonatomic, strong) RACCommand *deleteCmd;

/** 猜你喜欢数据 */
@property(nonatomic, strong) RACCommand *gussLikeCmd;

/** 购物车数据 */
@property(nonatomic, copy) NSArray <__kindof ZCShopCartModel*>*cartArray;

/** 底部猜你喜欢数据 */
@property(nonatomic, copy) NSArray <__kindof ZCShopCartLikeModel*>*likeArray;


/** 购物车商品总数 */
@property(nonatomic, strong) NSNumber *totalCount;

/** 选中商品的总价 */
@property(nonatomic, copy) NSNumber *totalPrice;

/** 选中商品的总个数 */
@property(nonatomic, strong) NSNumber *selectCount;

/** 选中商品的购物车Ids 多个数据 , 拼接*/
@property(nonatomic, copy) NSString *selectedCartIds;

/** 是否全部选中购物车商品 */
@property(nonatomic, strong, getter=isSelectAll) NSNumber *selectAll;


@end

NS_ASSUME_NONNULL_END
