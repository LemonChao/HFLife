//
//  YYB_HF_destroyFailView.h
//  HFLife
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYB_HF_destroyFailView : UIView
@property(nonatomic, copy) void (^sureBlock)(void);
@property(nonatomic, copy) NSString *tipMsg;//
@end

NS_ASSUME_NONNULL_END
