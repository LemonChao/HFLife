//
//  YYB_HF_LocalFailAlertV.h
//  HFLife
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYB_HF_LocalFailAlertV : UIView
+ (instancetype)shareInstance;
/** 检查定位 */
+ (void)detectionLocationState:(void(^)(int type))authorizedBlock;
- (void)show;
@end

NS_ASSUME_NONNULL_END
