//
//  YYB_HF_SearchHeadView.h
//  HFLife
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYB_HF_SearchHeadView : UIView
/** 选择类别事件 */
@property(nonatomic, copy) void (^typeSelect)(void);
/** 点击返回事件 */
@property(nonatomic, copy) void (^backClick)(void);
/** 点击搜索按钮事件 */
@property(nonatomic, copy) void (^searchEdit)(void);
/** 点击编辑搜索内容事件 */
@property(nonatomic, copy) void (^searchClick)(void);
@property(nonatomic, copy) NSString *setTypeStr;
@property(nonatomic, copy) NSString *setSearchStr;

/** 搜索内容 */
@property(nonatomic, strong) UITextField *searchT;
@end

NS_ASSUME_NONNULL_END
