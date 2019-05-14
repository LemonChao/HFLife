//
//  AddAddressVC.h
//  HanPay
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddAddressVC : BaseViewController
/** 是否是编辑 */
//@property (nonatomic,assign) BOOL isEditor;
/** 地址model */
@property (nonatomic,strong) AddressModel *dataModel;
@end

NS_ASSUME_NONNULL_END
