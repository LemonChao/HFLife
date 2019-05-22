//
//  YYB_HF_SexChoiceView.h
//  HFLife
//
//  Created by mac on 2019/5/21.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYB_HF_SexChoiceView : UIView

/**
 当前的性别 男/女
 */
@property(nonatomic, copy) NSString *sex;

@property(nonatomic, copy) void (^selectSexBlock)(NSString *gender);

- (void)show;
@end

NS_ASSUME_NONNULL_END
