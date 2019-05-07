//
//  myTagBtnView.h
//  SQButtonTagView
//
//  Created by mini on 2018/2/23.
//  Copyright © 2018年 yangsq. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol myTagBtnViewDelegate <NSObject>
- (void)selectResultDelegate:(NSArray *)resultArr;
@end
@interface myTagBtnView : UIView
@property (nonatomic, assign) BOOL selectType;//yes多选， no 单选
- (instancetype)initWithFrame:(CGRect)frame withTitleArr:(NSArray *)titleArr withType:(BOOL)btnType;
//block回调值
@property (nonatomic, strong) void(^selectResultBlock)(NSArray *resultArr);
//代理回调值
@property (nonatomic, weak) id <myTagBtnViewDelegate>tagBtnDelegate;
@end
