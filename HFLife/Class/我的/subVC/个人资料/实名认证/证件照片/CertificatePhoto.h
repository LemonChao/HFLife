//
//  CertificatePhoto.h
//  HanPay
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CertificatePhoto : BaseViewController
/**
 0:大陆居民身份证 ， 3:港澳台身份证
 */
@property (nonatomic , strong)NSString *type;
@end

NS_ASSUME_NONNULL_END
