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

- (RACCommand *)shopHomeCmd {
    if (!_shopHomeCmd) {
        _shopHomeCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                [networkingManagerTool requestToServerWithType:POST withSubUrl:@"w=index&t=index" withParameters:@{} withResultBlock:^(BOOL result, id value) {
                    if (result){
                        
                    }
                }];

                
                
                return nil;
            }];
        }];
    }
    return _shopHomeCmd;
}



@end
