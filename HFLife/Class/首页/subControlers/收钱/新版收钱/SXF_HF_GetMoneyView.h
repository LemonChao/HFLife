//
//  SXF_HF_GetMoneyView.h
//  HFLife
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_GetMoneyView : UIView
@property (nonatomic, strong)void(^tabBtnCallback)(NSInteger index);

/**
 

 @param code <#code description#>
 @param isCustom 是否是自己设置的付款金额
 */
- (void)setDataForView:(id)code type:(BOOL)isCustom;
@end

NS_ASSUME_NONNULL_END
