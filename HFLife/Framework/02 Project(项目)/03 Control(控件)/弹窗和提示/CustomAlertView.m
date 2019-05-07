//
//  CustomAlertView.m
//  DuDuJR
//
//  Created by 张志超 on 2017/12/21.
//  Copyright © 2017年 张志超. All rights reserved.
//

#import "CustomAlertView.h"

//alertView宽
#define AlertWhit     280

//各个栏目之间的距离
#define CustonSpace    10

@interface CustomAlertView()
//弹窗
@property (nonatomic, retain) UIView *alertView;
//标题
@property (nonatomic, retain) UILabel *titleLabel;
//内容
@property (nonatomic, retain) UILabel *messageLabel;
//确定
@property (nonatomic, retain) UIButton *sureButton;
//取消
@property (nonatomic, retain) UIButton *cancleButton;
//横线
@property (nonatomic, retain) UIView *lineView;
//竖线
@property (nonatomic, retain) UIView *verLineView;
@end

@implementation CustomAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureButton:(NSString *)sureTitle cancaleButton:(NSString *)cancleTitle {
    if (self == [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        
        self.alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AlertWhit, 100)];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 5.0;
        self.alertView.layer.position = self.center;
        
        //标题
        if (title) {
            self.titleLabel = [self GetAdaptiveLabel:CGRectMake(2 * CustonSpace, 2 * CustonSpace, AlertWhit - 4 * CustonSpace, 20) AndTex:title andIsTitle:YES];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.alertView addSubview:self.titleLabel];
            CGFloat titleW = self.titleLabel.bounds.size.width;
            CGFloat titlwH = self.titleLabel.bounds.size.height;
            self.titleLabel.frame = CGRectMake((AlertWhit - titleW) / 2, 2 * CustonSpace, titleW, titlwH);
        }
        
        //内容
        if (message) {
            self.messageLabel = [self GetAdaptiveLabel:CGRectMake(CustonSpace, CGRectGetMaxY(self.titleLabel.frame) + CustonSpace, AlertWhit - 2 * CustonSpace, 20) AndTex:message andIsTitle:NO];
            self.messageLabel.textAlignment = NSTextAlignmentCenter;
            [self.alertView addSubview:self.messageLabel];
            CGFloat msgW = self.messageLabel.bounds.size.width;
            CGFloat msgH = self.messageLabel.bounds.size.height;
            self.messageLabel.frame = self.titleLabel?CGRectMake((AlertWhit - msgW) / 2, CGRectGetMaxY(self.titleLabel.frame) + CustonSpace, msgW, msgH):CGRectMake((AlertWhit - msgW) /2, 2 * CustonSpace, msgW, msgH);
        }
        
        //横线
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = self.messageLabel?CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame) + 2 * CustonSpace, AlertWhit, 1):CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 2 * CustonSpace, AlertWhit, 1);
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:self.lineView];
        
        //两个按钮
        if (cancleTitle && sureTitle) {
            //取消按钮
            self.cancleButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleButton.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), (AlertWhit - 1) / 2, 40);
            [self.cancleButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleButton setTitle:cancleTitle forState:UIControlStateNormal];
//            [self.cancleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.cancleButton.tag = 1;
            [self.cancleButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *canclePath = [UIBezierPath bezierPathWithRoundedRect:self.cancleButton.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *cancleLayer = [[CAShapeLayer alloc] init];
            cancleLayer.frame = self.cancleButton.bounds;
            cancleLayer.path = canclePath.CGPath;
            self.cancleButton.layer.mask = cancleLayer;
            [self.alertView addSubview:self.cancleButton];
            
            //竖线
            self.verLineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.cancleButton.frame), CGRectGetMaxY(self.lineView.frame), 1, 40)];
            self.verLineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
            [self.alertView addSubview:self.verLineView];
            
            //确定按钮
            self.sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureButton.frame = CGRectMake(CGRectGetMaxX(self.verLineView.frame), CGRectGetMaxY(self.lineView.frame), (AlertWhit - 1) / 2, 40);
            [self.sureButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.sureButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureButton setTitle:sureTitle forState:UIControlStateNormal];
//            [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.sureButton.tag = 2;
            [self.sureButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *surePath = [UIBezierPath bezierPathWithRoundedRect:self.sureButton.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *sureLayer = [[CAShapeLayer alloc] init];
            sureLayer.frame = self.sureButton.bounds;
            sureLayer.path = surePath.CGPath;
            self.sureButton.layer.mask = sureLayer;
            [self.alertView addSubview:self.sureButton];
        }
        
        //只有取消按钮
        if (cancleTitle && !sureTitle) {
            self.cancleButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleButton.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertWhit, 40);
            [self.cancleButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleButton setTitle:cancleTitle forState:UIControlStateNormal];
//            [self.cancleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.cancleButton.tag = 1;
            [self.cancleButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *canclePath = [UIBezierPath bezierPathWithRoundedRect:self.cancleButton.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *cancleLayer = [[CAShapeLayer alloc] init];
            cancleLayer.frame = self.cancleButton.bounds;
            cancleLayer.path = canclePath.CGPath;
            self.cancleButton.layer.mask = cancleLayer;
            [self.alertView addSubview:self.cancleButton];
        }
        
        //只有确定按钮
        if (sureTitle && !cancleTitle) {
            self.sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureButton.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertWhit, 40);
            [self.sureButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/25.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.sureButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureButton setTitle:sureTitle forState:UIControlStateNormal];
//            [self.sureButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.sureButton.tag = 2;
            [self.sureButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *surePath = [UIBezierPath bezierPathWithRoundedRect:self.sureButton.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *sureLayer = [[CAShapeLayer alloc] init];
            sureLayer.frame = self.sureButton.bounds;
            sureLayer.path = surePath.CGPath;
            self.sureButton.layer.mask = sureLayer;
            [self.alertView addSubview:self.sureButton];
        }
        
        //计算高度
        CGFloat alertHeight = cancleTitle?CGRectGetMaxY(self.cancleButton.frame):CGRectGetMaxY(self.sureButton.frame);
        self.alertView.frame = CGRectMake(0, 0, AlertWhit, alertHeight);
        self.alertView.layer.position = self.center;
        [self addSubview:self.alertView];
        
    }
    return self;
}

//弹窗显示
- (void)show {
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation {
    self.alertView.layer.position =self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
}

//设置回调 ------ 确定按钮进行回调
- (void)buttonEvent:(UIButton *)button {
    if (button.tag == 2) {
        if (self.resultIndex) {
            self.resultIndex(button.tag);
        }
    }
    [self removeFromSuperview];
}

- (UILabel *) GetAdaptiveLabel:(CGRect)rect AndTex:(NSString *) contentStr andIsTitle:(BOOL)isTitle {
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:rect];
    contentLabel.numberOfLines = 0;
    contentLabel.text = contentStr;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    if (isTitle) {
        contentLabel.font = [UIFont systemFontOfSize:16];
    } else {
        contentLabel.font = [UIFont systemFontOfSize:14];
    }
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
    mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [mParaStyle setLineSpacing:3.0];
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0, [contentStr length])];
    [contentLabel setAttributedText:mAttrStr];
    [contentLabel sizeToFit];
    
    return contentLabel;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
