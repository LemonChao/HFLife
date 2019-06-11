//
//  HF_PayHelp.h
//  HFLife
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HF_PayHelp : NSObject
+ (void)goWXPay:(NSString *)wxCode;
@end

NS_ASSUME_NONNULL_END
