//
//  WBProgressHUD+WBPCreate.h
//  HFLife
//
//  Created by mac on 2019/1/30.
//  Copyright © 2019年 mac. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "WBProgressHUD.h"
#import "WBLoadingHUD.h"
@interface WBPCreate : NSObject<UIGestureRecognizerDelegate>
+(instancetype)sharedInstance;
-(void)showWBProgress;
-(void)hideAnimated;
@end


