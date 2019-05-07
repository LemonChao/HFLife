//
//  CustomAlertView.h
//  DuDuJR
//
//  Created by 张志超 on 2017/12/21.
//  Copyright © 2017年 张志超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertResult)(NSInteger index);

@interface CustomAlertView : UIView

@property (nonatomic, copy) AlertResult resultIndex;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureButton:(NSString *)sureTitle cancaleButton:(NSString *)cancleTitle;

//展示弹窗
- (void)show;

@end
