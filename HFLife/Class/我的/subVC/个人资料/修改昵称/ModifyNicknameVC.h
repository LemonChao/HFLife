//
//  ModifyNicknameVC.h
//  HanPay
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModifyNicknameVC : BaseViewController
@property(nonatomic, copy) NSString *type;//
/**
 修改成功回调
 */
@property (nonatomic,copy)void (^modifiedSuccessfulBlock)(NSString *value);
@end

NS_ASSUME_NONNULL_END
