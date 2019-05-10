//
//  balanceRecoardView.h
//  HanPay
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BalanceRecordModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface balanceRecoardView : UIView
@property (nonatomic,strong)UIViewController *superVC;
@property (nonatomic,strong) NSArray <BalanceRecordModel *>* dataSourceArray;
@end

NS_ASSUME_NONNULL_END
