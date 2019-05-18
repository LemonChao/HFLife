//
//  SXF_HF_leftRightAlert.h
//  HFLife
//
//  Created by mac on 2019/5/18.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_leftRightAlert : UIView
@property (nonatomic, copy)void(^clickAlertBtn)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
