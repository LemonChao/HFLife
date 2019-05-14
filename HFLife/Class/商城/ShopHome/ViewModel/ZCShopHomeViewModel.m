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
                        
                        ZCShopHomeModel *model = [ZCShopHomeModel yy_modelWithDictionary:value];
                        self.homeModel = model;
                        
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






@end
