//
//  withdrawAlertView.h
//  HFLife
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface withdrawAlertView : UIView
+ (void) showAlert:(NSArray *)dataSource complace:(void(^)(bankListModel *bankModel))callback bottomBtn:(void(^)(void))bottomBtnCallBack;
@end

NS_ASSUME_NONNULL_END
