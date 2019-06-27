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
@property(nonatomic, copy) void (^choiceCity)(NSString *city);
@property(nonatomic, strong) UIViewController *supVC;
// 上传城市
+ (void)uploadBackLocation:(NSString *)city sucess:(void (^)())sucess;
@property(nonatomic, assign) NSInteger showTimes;//只显示2次
@end

NS_ASSUME_NONNULL_END
