//
//  BarCodeView.m
//  HFLife
//
//  Created by sxf on 2019/4/12.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "BarCodeView.h"

@implementation BarCodeView
{
    UIView *bgView ;
    UIImageView *barCodeImage;
    UIImage *codeImage;
}
-(instancetype)initImage:(UIImage *)image{
    self = [super init];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH,  SCREEN_HEIGHT);
    if (self) {
        codeImage = image;
        self.backgroundColor = [UIColor whiteColor];
        [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
//            self.layer.transform = CATransform3DMakeRotation(M_PI/2.0, 0, 0, 0);  // 当前view，这句代码可以不要。这是我的需求
//设置statusBar
//            [[UIApplication sharedApplication] setStatusBarOrientation:orientation];
            
                //计算旋转角度
//            float arch;
//            if (orientation == UIInterfaceOrientationLandscapeLeft)
//                arch = -M_PI_2;
//            else if (orientation == UIInterfaceOrientationLandscapeRight)
//                arch = M_PI_2;
//            else
//                arch = 0;
            
                //对navigationController.view 进行强制旋转
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.bounds = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH) ;
        } completion:^(BOOL finished) {
            [self initWithUI];
            
        }];
    }
    return self;
}
- (void)initWithUI{
    
    barCodeImage = [UIImageView new];
//    barCodeImage.backgroundColor = [UIColor yellowColor];
    barCodeImage.image = codeImage;;
    [self addSubview:barCodeImage];
    [barCodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(WidthRatio(1021));
        make.height.mas_equalTo(HeightRatio(320));
//        make.width.mas_equalTo(WidthRatio(<#x#>));
//        make.top.mas_equalTo(self.mas_top).offset(HeightRatio(167));
    }];
    
//    UILabel 
    
    
    
    bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    UIImageView *barCode_icon = [UIImageView new];
    barCode_icon.image = MMGetImage(@"barCode_icon");
    [bgView addSubview:barCode_icon];
    [barCode_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(HeightRatio(138));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.height.mas_equalTo(WidthRatio(106));
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"付款码数字仅用于付钱时向商家出示，为防诈骗，请不要发送给他人";
    titleLabel.font = [UIFont systemFontOfSize:WidthRatio(36)];
    titleLabel.numberOfLines = 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(barCode_icon.mas_bottom).offset(HeightRatio(79));
        make.width.mas_equalTo(WidthRatio(643));
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    
    UIButton *button = [UIButton new];
    button.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(36)];
    [button setTitle:@"知道了" forState:(UIControlStateNormal)];
    button.backgroundColor = HEX_COLOR(0x34BAFF);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [bgView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(HeightRatio(58));
        make.width.mas_equalTo(WidthRatio(417));
        make.height.mas_equalTo(HeightRatio(75));
    }];
}
-(void)buttonClick{
    
    [bgView removeFromSuperview];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
    self.userInteractionEnabled = YES    ;
    [self addGestureRecognizer:tap];
}
#pragma mark 点击手势
-(void)doTap:(UITapGestureRecognizer *)sender{
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
