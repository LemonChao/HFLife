//
//  ZHB_HP_PreventWeChatPopout.h
//  HFLife
//
//  Created by sxf on 2019/5/8.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHB_HP_PreventWeChatPopout;


@protocol WeChatPopoutDelegate <NSObject>

@optional

/**
 选中第几个
 
 @param actionSheet <#actionSheet description#>
 @param buttonIndex <#buttonIndex description#>
 */
- (void)actionSheet:(ZHB_HP_PreventWeChatPopout *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

/**
 即将消失
 
 @param actionSheet <#actionSheet description#>
 @param buttonIndex <#buttonIndex description#>
 */
- (void)actionSheet:(ZHB_HP_PreventWeChatPopout *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;

/**
 已经消失
 
 @param actionSheet <#actionSheet description#>
 @param buttonIndex <#buttonIndex description#>
 */
- (void)actionSheet:(ZHB_HP_PreventWeChatPopout *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;


@end
NS_ASSUME_NONNULL_BEGIN
typedef void(^WeChatPopoutViewBlock)(NSInteger index);

@interface ZHB_HP_PreventWeChatPopout : UIView
/**
 操作按钮个数
 */
@property (nonatomic, assign, readonly) NSInteger numberOfButtons;

/**
 取消按钮
 */
@property (nonatomic, assign, readonly) NSInteger cancelButtonIndex;

/**
 <#Description#>
 */
@property (nonatomic, assign, readonly) NSInteger destructiveButtonIndex;

/**
 声明代理
 */
@property (nonatomic, weak) id<WeChatPopoutDelegate>actionSheetViewDelegate;

/**
 操作block
 */
@property (nonatomic, copy) WeChatPopoutViewBlock acitonSheetBlock;

/**
 <#Description#>
 
 @param id <#id description#>
 @return <#return value description#>
 */
#pragma mark - methods

/**
 初始化 代理方法调用
 
 @param title 标题
 @param delegate 代理
 @param cancelButtonTitle 取消按钮的标题
 @param destructiveButtonTitle 红色按钮的标题
 @param otherButtonTitles 其他按钮的标题，最后以nil结尾 类似 @"aaa",@"2222",@"333",nil 这样
 @return <#return value description#>
 */
- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id<WeChatPopoutDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles;

/**
 初始化   block方式调用
 
 @param title 提示语
 @param cancelButtonTitle 取消按钮
 @param destructiveButtonTitle 确定按钮
 @param otherButtons 其他操作 可以为nil
 @param actionSheetBlock 操作事件block
 @return <#return value description#>
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtons
             actionSheetBlock:(WeChatPopoutViewBlock)actionSheetBlock;

/**
 显示
 */
- (void)show;

/**
 点击操作按钮
 
 @param buttonIndex <#buttonIndex description#>
 @return <#return value description#>
 */
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;
@end

NS_ASSUME_NONNULL_END
