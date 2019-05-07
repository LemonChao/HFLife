//
//  BaseManage.h
//  HanPay
//
//  Created by mac on 2019/1/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SuccessBlock)(id request);
@interface BaseManage : NSObject
+(instancetype)sharedInstance;
@property (nonatomic,strong)UIViewController *superVC;
@end

NS_ASSUME_NONNULL_END
