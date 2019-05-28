//
//  ZCShopHomeViewModel.m
//  HFLife
//
//  Created by zchao on 2019/5/13.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopHomeViewModel.h"
@interface ZCShopHomeViewModel ()

@property(nonatomic, copy) NSArray *restDataArray;

@end

@implementation ZCShopHomeViewModel

- (RACCommand *)shopRefreshCmd {
    if (!_shopRefreshCmd) {
        @weakify(self);
        _shopRefreshCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal combineLatest:@[[self restSignal],[self exclusizeSignal]] reduce:^id _Nonnull(NSArray *section0, NSArray *section1){
                @strongify(self);
                if (section0.count && section1.count) {
                    self.dataArray = @[section0,section1];
                    return @(1);
                }
                return @(0);
            }];
        }];
    }
    return _shopRefreshCmd;
}


/** 加载更多cmd */
- (RACCommand *)shopLoadMoreCmd {
    if (!_shopLoadMoreCmd) {
        @weakify(self);
        _shopLoadMoreCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSString *_Nullable page) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [networkingManagerTool requestToServerWithType:POST withSubUrl:shopCartTui_Goods withParameters:@{@"page":page,@"page_all":@"0"} withResultBlock:^(BOOL result, id value) {
                    @strongify(self);
                    NSMutableArray *originArray = [NSMutableArray arrayWithArray:self.dataArray[1]];
                    if (result){
                        
                        NSArray *tempArray = [NSArray yy_modelArrayWithClass:[ZCExclusiveRecommendModel class] json:value[@"data"]];
                        [self exclusizeEnumerateObjects:tempArray];
                        [originArray addObjectsFromArray:tempArray];
                        if (!self.restDataArray) {
                            self.restDataArray = [NSArray array];
                        }
                        self.totalPage = [value[@"total_page"] unsignedIntegerValue];
                        self.dataArray = @[self.restDataArray,originArray];
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
    return _shopLoadMoreCmd;
}

/** 专属推荐signal --刷新用*/
- (RACSignal *)exclusizeSignal {
    RACSignal *exclusiveSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [networkingManagerTool requestToServerWithType:POST withSubUrl:shopCartTui_Goods withParameters:@{@"page":@"1",@"page_all":@"0"} withResultBlock:^(BOOL result, id value) {
            NSArray *section1;
            if (result){
                section1 = [NSArray yy_modelArrayWithClass:[ZCExclusiveRecommendModel class] json:value[@"data"]];
                [self exclusizeEnumerateObjects:section1];
            }
            self.totalPage = [value[@"total_page"] unsignedIntegerValue];
            [subscriber sendNext:section1];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    
    return exclusiveSignal;
}

/** 剩余数据signal */
- (RACSignal *)restSignal {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [networkingManagerTool requestToServerWithType:POST withSubUrl:shopCartHome withParameters:@{} withResultBlock:^(BOOL result, id value) {
            @strongify(self);
            if (result){
                
                ZCShopHomeModel *model = [ZCShopHomeModel yy_modelWithDictionary:value[@"data"]];
                self.bannerArray = model.banner_list.copy;
                self.classArray = model.class_list.copy;
                self.restDataArray = [self buildDataArrayWithModel:model];
            }
            [subscriber sendNext:self.restDataArray];

            [subscriber sendCompleted];
        }];
        
        return nil;
    }];
}


- (NSArray *)buildDataArrayWithModel:(ZCShopHomeModel *)model {
    NSMutableArray *section0 = [NSMutableArray array];
    
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
        [model.shop_newGoods enumerateObjectsUsingBlock:^(__kindof ZCShopNewGoodsModel * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *string = [NSString stringWithFormat:@"￥%@ 起",item.goods_price];
            NSMutableAttributedString *mAttstring = [[NSMutableAttributedString alloc] initWithString:string];
            [mAttstring addAttributes:@{NSFontAttributeName:MediumFont(12),NSForegroundColorAttributeName:GeneralRedColor} range:NSMakeRange(0, string.length)];
            [mAttstring addAttribute:NSFontAttributeName value:MediumFont(18) range:[string rangeOfString:item.goods_price]];
            item.attPrice = mAttstring;
        }];
        cellModel.cellDatas = model.shop_newGoods;
        cellModel.rowHeight = ScreenScale(290);
        [section0 addObject:cellModel];
    }
    
    return section0.copy;
}

/** 处理专属推荐数据 */
- (NSArray *)exclusizeEnumerateObjects:(NSArray <__kindof ZCExclusiveRecommendModel*>*)objects {
    
    [objects enumerateObjectsUsingBlock:^(ZCExclusiveRecommendModel *_Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat cellWith = (SCREEN_WIDTH-ScreenScale(33))/2;//(contentWidthOfSection - spacing)/columnOfSection
        item.viewHeight = item.height / item.width * cellWith;
        NSString *string = [NSString stringWithFormat:@"￥%@ 起",item.goods_price];
        NSMutableAttributedString *mAttstring = [[NSMutableAttributedString alloc] initWithString:string];
        [mAttstring addAttributes:@{NSFontAttributeName:MediumFont(12),NSForegroundColorAttributeName:GeneralRedColor} range:NSMakeRange(0, string.length)];
        [mAttstring addAttribute:NSFontAttributeName value:MediumFont(18) range:[string rangeOfString:item.goods_price]];
        item.attPrice = mAttstring.mutableCopy;
    }];
    
    return objects;
}

@end
