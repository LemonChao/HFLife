//
//  NSObject+currentController.h
//  HFLife
//
//  Created by mac on 2019/5/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (currentController)

/**
  获取当前控制器（实例方法）

 @return <#return value description#>
 */
- (UIViewController *)getCurrentViewController;
/**
 获取当前控制器（类方法）
 
 @return <#return value description#>
 */
+ (UIViewController *)getCurrentViewController;

/**
 跳转登录
 */
- (void)loginVC;
@end

NS_ASSUME_NONNULL_END
