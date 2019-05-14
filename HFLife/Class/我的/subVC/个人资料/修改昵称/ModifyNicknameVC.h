//
//  ModifyNicknameVC.h
//  HanPay
//
//  Created by 张海彬 on 2019/1/18.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModifyNicknameVC : BaseViewController

/**
 修改成功回调
 */
@property (nonatomic,copy)void (^modifiedSuccessfulBlock)(NSString *value);
@end

NS_ASSUME_NONNULL_END
