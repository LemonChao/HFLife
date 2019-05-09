//
//  SXF_HF_LoginAlertView.h
//  mytest
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_LoginAlertView : UIView
+ (void) showLoginAlertComplete:(void(^__nullable)(BOOL btnBype))complate;
@end

NS_ASSUME_NONNULL_END
