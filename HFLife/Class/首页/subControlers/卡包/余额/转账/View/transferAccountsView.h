//
//  transferAccountsView.h
//  HanPay
//
//  Created by 张海彬 on 2019/4/16.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface transferAccountsView : UIView
/**
 转账点击
 */
@property (nonatomic,copy) void (^transferAccountsClick)(NSString *money,NSString *remark);

@property (nonatomic,strong) NSDictionary *userDict;
@end

NS_ASSUME_NONNULL_END
