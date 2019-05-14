//
//  LDDKeyboardView.h
//  ICBCKeyboard
//
//  Created by Ringo on 2017/5/12.
//  Copyright © 2017年 Ringo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LDDKeyboardBtnClickBlock)(UIButton*button);


@class LDDKeyboardView;

@protocol LDDKeyboardViewDelegate <NSObject>

-(void)clickKeyboardButton:(UIButton*)button;

@end


@interface LDDKeyboardView : UIView
/**键盘按钮点击block*/
@property(nonatomic,copy) LDDKeyboardBtnClickBlock clickBlock;

/**键盘按钮点击代理*/
@property (nonatomic,weak)  id <LDDKeyboardViewDelegate>delegate;

/**inputAccessoryView*/
@property (weak, nonatomic) IBOutlet UIView *accessoryView;

/**inputView*/
@property (weak, nonatomic) IBOutlet UIView *inputView;

/**字符键盘*/
@property (weak, nonatomic) IBOutlet UIView *charView;

/**当前选中按钮*/
@property(nonatomic,strong) UIButton *selectedBtn;

/**字符键盘左边约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

typedef NS_ENUM(NSUInteger,LDDButtonType) {
    LDDButtonTypeNumber=100,  //数字键盘类型按钮
    LDDButtonTypeChar,        //字符键盘类型按钮
    LDDButtonTypeSign,        //符合键盘类型按钮
    LDDButtonTypeDelete,      //删除按钮
    LDDButtonTypeLogin,       //登录按钮
    LDDButtonTypeShift,       //大小写切换按钮
    LDDButtonTypeSpace,       //空格按钮
};


-(void)lowercaseString;


/**通过xib方式加载View*/
+(instancetype)loadKeyboardFromNib;



@end
