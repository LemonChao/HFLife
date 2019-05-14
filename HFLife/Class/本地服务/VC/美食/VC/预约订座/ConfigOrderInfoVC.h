//
//  ConfigOrderInfoVC.h
//  HanPay
//
//  Created by zchao on 2019/2/23.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfigOrderInfoVC : BaseViewController
@property (nonatomic,copy) void (^selectBlock)(NSDictionary *dict);
@end

NS_ASSUME_NONNULL_END
