//
//  segementView.h
//  ttttttttt
//
//  Created by mini on 2017/12/25.
//  Copyright © 2017年 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface segementView : UIView
@property (nonatomic , copy) void(^btnSelecteBlock)(UIButton *selecteBtn);
@property (nonatomic ,strong) UIView *lineView;
//是否有动画时长
@property (nonatomic ,assign) float duration;
@property (nonatomic ,strong) UIScrollView *scrollView;
- (instancetype)initWithFrame:(CGRect)frame withMenuArr:(NSArray *)menuaArr withClassArr:(NSArray <UIViewController *>*)classArr;



@end
