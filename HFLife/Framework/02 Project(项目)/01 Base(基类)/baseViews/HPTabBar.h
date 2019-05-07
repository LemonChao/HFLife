//
//  HPTabBar.h
//  HanPay
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HPTabBar : UITabBar
@property (nonatomic,copy) void(^didClickPublishBtn)(void);

/**
 恢复点击状态，YES：点击状态 NO：非点击状态
 */
@property (nonatomic,assign) BOOL restoreClick;
@end

NS_ASSUME_NONNULL_END
