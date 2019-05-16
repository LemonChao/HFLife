//
//  ZCClassifyViewModel.m
//  HFLife
//
//  Created by zchao on 2019/5/16.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCClassifyViewModel.h"

@implementation ZCClassifyViewModel

- (RACCommand *)classifyCmd {
    if (!_classifyCmd) {
        _classifyCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                [networkingManagerTool requestToServerWithType:POST withSubUrl:@"w=goods_class&t=fenlei" withParameters:@{} withResultBlock:^(BOOL result, id value) {
                    if (result) {
                        
                        self.dataArray = [NSArray yy_modelArrayWithClass:[ZCShopClassifyModel class] json:value[@"data"]];
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
    return _classifyCmd;
}


@end
