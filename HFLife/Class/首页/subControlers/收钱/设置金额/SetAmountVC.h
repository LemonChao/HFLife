//
//  SetAmountVC.h
//  HanPay
//
//  Created by 张海彬 on 2019/1/22.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol  SetAmountDelegate <NSObject>

@optional

/**
 设置金额完成

 @param amount 金额
 */
-(void)SetAmountNumber:(NSString *)amount;
@end

@interface SetAmountVC : BaseViewController

/** 代理 */
@property (nonatomic , weak) id <SetAmountDelegate> amountDelegate;
@end

NS_ASSUME_NONNULL_END
