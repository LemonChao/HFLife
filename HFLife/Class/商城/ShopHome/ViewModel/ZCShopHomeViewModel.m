//
//  ZCShopHomeViewModel.m
//  HFLife
//
//  Created by zchao on 2019/5/13.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopHomeViewModel.h"

@interface ZCShopHomeViewModel ()


@end

@implementation ZCShopHomeViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.section = 0;
    }
    return self;
}




- (RACCommand *)shopRefreshCmd {
    if (!_shopRefreshCmd) {
        _shopRefreshCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                [networkingManagerTool requestToServerWithType:POST withSubUrl:@"w=index&t=index" withParameters:@{} withResultBlock:^(BOOL result, id value) {
                    if (result){
                        
                        ZCShopHomeModel *model = [ZCShopHomeModel yy_modelWithDictionary:value[@"data"]];
                        self.bannerArray = model.banner_list.copy;
                       self.dataArray = [self buildDataArrayWithModel:model];
                        
                        [subscriber sendNext:@(1)];
                        
                    }else {
                        [subscriber sendNext:@(0)];
                    }
                    [subscriber sendCompleted];
                }];
                
                return nil;
            }];
        }];
    }
    return _shopRefreshCmd;
}


/** 加载更多cmd */
- (RACCommand *)shopLoadMoreCmd {
    if (!_shopLoadMoreCmd) {
        _shopLoadMoreCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                [networkingManagerTool requestToServerWithType:POST withSubUrl:@"w=index&t=index" withParameters:@{@"page":@"1",@"page_all":@"0"} withResultBlock:^(BOOL result, id value) {
                    if (result){
                        
                    }
                }];

                
                
                return nil;
            }];
        }];
    }
    return _shopLoadMoreCmd;
}


- (NSArray *)buildDataArrayWithModel:(ZCShopHomeModel *)model {
    NSMutableArray *tempArray = [NSMutableArray array];
    NSMutableArray *section0 = [NSMutableArray array];
    NSMutableArray *section1 = [NSMutableArray arrayWithCapacity:6];
    
    if (model.limit_time_goods.count) {
        ZCShopHomeCellModel *cellModel = [[ZCShopHomeCellModel alloc] init];
        cellModel.title = @"限时折扣";
        cellModel.cellDatas = model.limit_time_goods;
        cellModel.rowHeight = ScreenScale(234);
        [section0 addObject:cellModel];
    }
    
    ZCShopHomeCellModel *cellModel = [[ZCShopHomeCellModel alloc] init];
    cellModel.title = @"今日必抢";
    cellModel.cellDatas = [NSArray array];
    cellModel.rowHeight = ScreenScale(374);
    [section0 addObject:cellModel];
    
    if (model.shop_newGoods.count) {
        ZCShopHomeCellModel *cellModel = [[ZCShopHomeCellModel alloc] init];
        cellModel.title = @"新品推荐";
        cellModel.cellDatas = model.shop_newGoods;
        cellModel.rowHeight = ScreenScale(200);
        [section0 addObject:cellModel];
    }
    
    for (int i = 0; i < 6; i++) {
        ZCShopHomeCellModel *cellModel = [[ZCShopHomeCellModel alloc] init];
        cellModel.title = @"专属推荐";
        cellModel.cellDatas = [NSArray array];
        cellModel.rowHeight = ScreenScale(273);
        [section1 addObject:cellModel];
    }
    
    [tempArray addObject:section0];
    [tempArray addObject:section1];
    return tempArray.copy;
    
}



@end
