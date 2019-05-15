//
//  SXF_HF_payStepAleryView.h
//  HFLife
//
//  Created by mac on 2019/5/15.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_payStepAleryView : UIView
+ (void)showAlertComplete:(void(^__nullable)(BOOL btnBype))complate;
@end

NS_ASSUME_NONNULL_END
