//
//  ZCClassifyViewModel.h
//  HFLife
//
//  Created by zchao on 2019/5/16.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "BaseViewModel.h"
#import "ZCShopClassifyModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZCClassifyViewModel : BaseViewModel

@property(nonatomic, strong) RACCommand *classifyCmd;

@property(nonatomic, copy) NSArray <ZCShopClassifyModel*>*dataArray;


@end

NS_ASSUME_NONNULL_END
