//
//  YYB_HF_LocalHeadView.h
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYB_HF_LocalHeadView : UIView
/** 选择地址事件 */
@property(nonatomic, copy) void (^addressSelect)(void);
/** 点击头像事件 */
@property(nonatomic, copy) void (^userHeadClick)(void);
/** 点击订单事件 */
@property(nonatomic, copy) void (^orderIconClick)(void);
/** 点击搜索事件 */
@property(nonatomic, copy) void (^searchIconClick)(void);
@property(nonatomic, strong) UIImage *setHeadImage;
@property(nonatomic, copy) NSString *setLocalStr;
@property(nonatomic, copy) NSString *setSearchStr;
@property(nonatomic, strong) NSNumber *is_notice;//提醒
@end

NS_ASSUME_NONNULL_END
