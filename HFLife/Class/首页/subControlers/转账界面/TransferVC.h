//
//  TransferVC.h
//  HFLife
//
//  Created by sxf on 2019/3/22.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TransferVC : BaseViewController

@property (nonatomic,strong)NSString *amount;

/**
 用户名字
 */
@property (nonatomic,strong)NSString *userName;

/**头像*/
@property (nonatomic,strong)NSString *uesrImage;

/**收款码信息*/
@property (nonatomic,strong)NSString *code_str;

/**
 是否是付款
 */
@property (nonatomic,assign)BOOL ispayment;

@end

NS_ASSUME_NONNULL_END
