//
//  WithdrawItemView.h
//  HanPay
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawItemView : UIView
@property (nonatomic, strong)void(^selectedAtIndex)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
