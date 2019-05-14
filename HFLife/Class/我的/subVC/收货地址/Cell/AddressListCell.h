//
//  AddressListCell.h
//  HanPay
//
//  Created by mac on 2019/1/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface AddressListCell : UITableViewCell

/**
 姓名
 */
@property (nonatomic,copy)NSString *userName;

/**
 地址
 */
@property (nonatomic,copy)NSString *address;

/**
 手机号
 */
@property (nonatomic,copy)NSString *phone;

/**
 是否是默认
 */
@property (nonatomic,assign)BOOL isDefault;

@property (nonatomic,strong) AddressModel *dataModel;

@property (nonatomic,copy) void (^editorBlock)(void);
@end

NS_ASSUME_NONNULL_END
