//
//  touchID_helper.h
//  HFLife
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>
NS_ASSUME_NONNULL_BEGIN

@interface touchID_helper : NSObject
+ (void) showTouchIDshowType:(id)showtype complate:(void (^)(BOOL success, NSError * _Nullable error))result;
@end

NS_ASSUME_NONNULL_END
