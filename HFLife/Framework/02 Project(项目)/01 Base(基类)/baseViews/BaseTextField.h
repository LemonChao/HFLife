//
//  BaseTextField.h
//  GDP
//
//  Created by mac on 2018/8/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,TextFieldType)
{
    /** 手机输入框*/
    TextFieldPhoneType,
    /** 密码输入框*/
    TextFieldPassType,
    /** 交易密码输入框*/
    TextFieldPayPassType,
    /** 数量输入框*/
    TextFieldNumberType,
    /** 空入框*/
    TextFieldNullType
};
@interface BaseTextField : UITextField
/** 输入框的类型*/
@property (nonatomic,assign)TextFieldType textFieldType;
@end
