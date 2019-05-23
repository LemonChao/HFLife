//
//  ZCShopCartViewModel.m
//  HFLife
//
//  Created by zchao on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopCartViewModel.h"

@interface ZCShopCartViewModel ()

@property(nonatomic, strong) RACSignal *cartSignal;

@end

@implementation ZCShopCartViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.totalPrice = self.selectAll = self.selectCount = self.totalCount = @(0);

        @weakify(self);
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:cartValueChangedNotification object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(NSNotification * _Nullable notif) {
            @strongify(self);

            if ([notif.object isEqualToString:@"refreshNetCart"]) { //购物车刷新事件
                [self.cartCmd execute:nil];
            }
            
            if ([notif.object isEqualToString:@"selectAction"]) { //商品选中事件
                //重新复制一份，改变指针地址，触发VC里的KVO
                [self indexsForSelectGoods];
                self.cartArray = self.cartArray.copy;
            }
        }];
        
    }
    return self;
}

- (RACSignal *)cartSignal {
    if (!_cartSignal) {
        @weakify(self);
        _cartSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [networkingManagerTool requestToServerWithType:POST withSubUrl:@"w=member_cart&t=cart_list" withParameters:@{} withResultBlock:^(BOOL result, id value) {
                @strongify(self);
                if (result) {
                    NSArray *tempArray = [NSArray yy_modelArrayWithClass:[ZCShopCartModel class] json:value[@"data"]];
                    NSInteger countNum = 0;
                    for (ZCShopCartModel *item in tempArray) {
                        countNum += item.goods.count;
                    }
                    self.totalCount = [NSNumber numberWithInteger:countNum];
                    self.selectAll = [NSNumber numberWithBool:NO];
                    self.cartArray = tempArray;
                    [subscriber sendCompleted];
                }else {
                    self.cartArray = @[];
                    [subscriber sendCompleted];
                }
            }];
            return nil;
        }];
    }
    
    return _cartSignal;
}


- (RACCommand *)cartCmd {
    if (!_cartCmd) {
        @weakify(self);
        _cartCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            return self.cartSignal;
        }];
    }
    return _cartCmd;
}


- (RACCommand *)deleteCmd {
    if (!_deleteCmd) {
        @weakify(self);
        _deleteCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [networkingManagerTool requestToServerWithType:POST withSubUrl:@"w=member_cart&t=cart_delall" withParameters:@{@"cart_ids":self.selectedCartIds} withResultBlock:^(BOOL result, id value) {
                    @strongify(self);
                    if (result) {
                        
                        [self.cartCmd execute:nil];
                    }else {
                        
                    }
                    
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _deleteCmd;
}

/** 猜你喜欢接口 */
- (RACCommand *)gussLikeCmd {
    if (!_gussLikeCmd) {
        @weakify(self);
        _gussLikeCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            RACSignal *likeSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                [networkingManagerTool requestToServerWithType:POST withSubUrl:@"w=member_cart&t=guess_like" withParameters:@{} withResultBlock:^(BOOL result, id value) {
                    @strongify(self);
                    if (result) {
                        self.likeArray = [NSArray yy_modelArrayWithClass:[ZCShopCartLikeModel class] json:value[@"data"]];
                        
                        [subscriber sendNext:@(1)];
                        [subscriber sendCompleted];
                    }else {
                        
                        [subscriber sendError:nil];
                    }
                }];
                
                return nil;
            }];
            
            return [self.cartSignal concat:likeSignal];
        }];
    }
    return _gussLikeCmd;
}

/**
 获取被选中的 indexPath,更新全选，分区选中状态
 
 @return return indexPath
 */
- (nullable NSArray<NSIndexPath *>*)indexsForSelectGoods {
    NSMutableArray *selectedArray = [NSMutableArray array];
    NSMutableArray *cartIds = [NSMutableArray array];
    NSMutableArray *goodIds = [NSMutableArray array];
    __block BOOL selectAll = YES;
    __block NSInteger selectNum = 0;
    __block CGFloat totalPrice = 0.f;
    [self.cartArray enumerateObjectsUsingBlock:^(__kindof ZCShopCartModel * _Nonnull model, NSUInteger section, BOOL * _Nonnull stop) {
        
        __block BOOL sectionSelect = YES;
        NSMutableArray <ZCShopCartGoodsModel *> *shopList = model.goods.mutableCopy;
        /// 遍历分区内cell
        [shopList enumerateObjectsUsingBlock:^(ZCShopCartGoodsModel * _Nonnull goodsModel, NSUInteger row, BOOL * _Nonnull stop) {
            
            if (goodsModel.isSelected) {
                selectNum++;
                totalPrice += goodsModel.goods_price.floatValue * goodsModel.goods_num.integerValue;
                NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:section];
                [selectedArray addObject:index];
                [goodIds addObject:goodsModel.goods_id];
                [cartIds addObject:goodsModel.cart_id];
            }else {
                sectionSelect = NO;
            }
        }];
        //更新区头选择状态
        model.selectAll = sectionSelect;
        
        if (model.isSelectAll == NO) {
            //更新全部选择状态
            selectAll = NO;
        }

    }];
    
    self.selectedCartIds = [cartIds componentsJoinedByString:@","];
    self.selectAll = [NSNumber numberWithBool:selectAll];
    self.totalPrice = [NSNumber numberWithFloat:totalPrice];
    self.selectCount = [NSNumber numberWithInteger:selectNum];
    return selectedArray;
}



@end
