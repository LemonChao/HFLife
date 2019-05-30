//
//  SXF_HF_PayVC.h
//  HFLife
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_PayVC : BaseViewController
@property (nonatomic, strong)NSString *payName;
@property (nonatomic, strong)NSString *payHeaderUrl;
@property (nonatomic, strong)NSString *codeStr;//收款码信息
@property (nonatomic, assign)BOOL payType;
@end

NS_ASSUME_NONNULL_END
