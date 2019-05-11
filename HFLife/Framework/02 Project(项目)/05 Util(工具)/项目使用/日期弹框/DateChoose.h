//
//  DateChoose.h
//  HFLife
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateChoose : UIView

/**
 选择回调（date：时间  isToday：是否是今天）
 */
@property (nonatomic, copy) void (^selectDate) (NSString *date , BOOL isToday);

@end

NS_ASSUME_NONNULL_END
