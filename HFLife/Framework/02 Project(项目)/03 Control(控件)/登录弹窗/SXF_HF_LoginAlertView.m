//
//  SXF_HF_LoginAlertView.m
//  mytest
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SXF_HF_LoginAlertView.h"

@interface SXF_HF_LoginAlertView ()
@property (nonatomic, strong)UILabel *titleLb;
@property (nonatomic, strong)UILabel *msgLb;
@property (nonatomic, strong)UIButton *sureBtn;
@property (nonatomic, strong)UIButton *cancleBtn;
@property (nonatomic, strong)void(^clickBtn)(BOOL btnType);
@end



@implementation SXF_HF_LoginAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    self.titleLb      = [UILabel new];
    self.msgLb        = [UILabel new];
    self.sureBtn      = [UIButton new];
    self.cancleBtn    = [UIButton new];
    
    [self addSubview:self.titleLb];
    [self addSubview:self.msgLb];
    [self addSubview:self.sureBtn];
    [self addSubview:self.cancleBtn];
    
    self.titleLb.font = self.msgLb.font = [UIFont systemFontOfSize:18];
    self.msgLb.font = FONT(14);
    self.msgLb.textColor = HEX_COLOR(0x0C0B0B);
    
    self.sureBtn.titleLabel.font = self.cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    self.titleLb.text = @"是否登录";
    self.msgLb.text = @"此功能需登录才可使用，是否登录？";
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [self.sureBtn setTitleColor:HEX_COLOR(0xCA1400) forState:UIControlStateNormal];
    [self.cancleBtn setTitleColor:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [self.sureBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancleBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)clickBtn:(UIButton *)sender{
    if (sender == self.sureBtn) {
        !self.clickBtn ? : self.clickBtn(YES);
    }else{
        !self.clickBtn ? : self.clickBtn(NO);
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(16));
        make.top.mas_equalTo(self).offset(ScreenScale(31));
        make.height.mas_equalTo(ScreenScale(17));
    }];
    
    [self.msgLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(ScreenScale(15));
        make.left.mas_equalTo(self.titleLb.mas_left);
        make.height.mas_equalTo(ScreenScale(14));
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-16));
        make.bottom.mas_equalTo(self.mas_bottom).offset(ScreenScale(-31));
        
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.sureBtn.mas_left).offset(ScreenScale(-25));
        make.centerY.mas_equalTo(self.sureBtn.mas_centerY);
        
    }];
    
    
}




+ (void) showLoginAlertComplete:(void(^__nullable)(BOOL btnBype))complate{
    
    UIWindow *kwin = [UIApplication sharedApplication].keyWindow;
    if (!kwin) {
        kwin =  [UIApplication sharedApplication].windows.lastObject;
    }
    
    UIView *bgView = [[UIView alloc] initWithFrame:kwin.bounds];
    bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [kwin addSubview:bgView];
    SXF_HF_LoginAlertView *alertView = [[SXF_HF_LoginAlertView alloc] init];
    alertView.frame = CGRectMake(0, 0, 325, 150);
    [kwin addSubview:alertView];
    alertView.layer.cornerRadius = 5;
    alertView.layer.masksToBounds = YES;
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    alertView.center = bgView.center;
    
    
    
    
    
    
    
    
    [UIView animateWithDuration:0.2 animations:^{
        bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    
    __weak typeof(alertView)weakAlert = alertView;
    alertView.clickBtn = ^(BOOL btnType) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [UIView animateWithDuration:0.2 animations:^{
                
                weakAlert.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
                weakAlert.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:^(BOOL finished) {
                if (complate) {
                    complate(btnType);
                }
                [weakAlert removeFromSuperview];
                [bgView removeFromSuperview];
            }];
        }];
        
    };
}








@end
