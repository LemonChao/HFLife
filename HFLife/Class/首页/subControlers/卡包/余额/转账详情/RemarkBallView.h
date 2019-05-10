//
//  RemarkBallView.h
//  HFLife
//
//  Created by sxf on 2019/4/18.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^sureBlock)(NSString *string);
@interface RemarkBallView : UIView

/**
 账单ID
 */
@property (nonatomic, copy)NSString *billID;

/**
 点击确定回调
 */
@property(nonatomic,copy)sureBlock sureClick;

/**
 初始化

 @param backImage 图片名
 @param titleStr 描述
 @param contentStr 内容
 @param titleString 按钮名子
 @param BtnColor 按钮颜色
 @return 对象
 */
-(instancetype) initWithTitleImage:(NSString *)backImage messageTitle:(NSString *)titleStr messageString:(NSString *)contentStr sureBtnTitle:(NSString *)titleString sureBtnColor:(UIColor *)BtnColor;
@end

NS_ASSUME_NONNULL_END
