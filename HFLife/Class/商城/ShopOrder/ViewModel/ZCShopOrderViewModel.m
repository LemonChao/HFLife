
//
//  ZCShopOrderViewModel.m
//  HFLife
//
//  Created by zchao on 2019/5/31.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopOrderViewModel.h"

@implementation ZCShopOrderViewModel

- (RACCommand *)orderCenterCmd {
    if (!_orderCenterCmd) {
        @weakify(self);
        _orderCenterCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [networkingManagerTool requestToServerWithType:POST withSubUrl:shopOrderCenterHome withParameters:@{} withResultBlock:^(BOOL result, id value) {
                    @strongify(self);
                    if (result) {
                        
                        self.model = [ZCShopOrderModel yy_modelWithDictionary:value[@"data"]];
                        
                        [subscriber sendCompleted];
                    }else {
                        [subscriber sendError:nil];
                    }
                }];
                return nil;
            }];
        }];
    }
    return _orderCenterCmd;
}



@end



@implementation ZCShopOrderModel



@end




