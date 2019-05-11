//
//  SXF_HF_LoginAlertView.h
//  mytest
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HF_AlertType) {
    AlertType_login,
    AlertType_save,//安全提示,
};


NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_LoginAlertView : UIView
@property (nonatomic, assign)HF_AlertType alertType;
+ (void) showLoginAlertType:(HF_AlertType) alertType Complete:(void(^__nullable)(BOOL btnBype))complate;
@end

NS_ASSUME_NONNULL_END
