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
@property (nonatomic, strong)NSString *payMoneyStr;
+ (SXF_HF_payStepAleryView *)showAlertComplete:(void(^__nullable)(BOOL btnBype))complate password:(void(^)(NSString *pwd))password;

- (void) cancleAlertView;
@property (nonatomic, assign)BOOL editingEable;//清空密码框
@end

NS_ASSUME_NONNULL_END
