//
//  SXF_HF_LoginAlertView.m
//  mytest
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SXF_HF_AlertView.h"

@interface SXF_HF_AlertView ()
@property (nonatomic, strong)UILabel *titleLb;
@property (nonatomic, strong)UILabel *msgLb;
@property (nonatomic, strong)UIButton *sureBtn;
@property (nonatomic, strong)UIButton *cancleBtn;
@property (nonatomic, strong)void(^clickBtn)(BOOL btnType);
@end



@implementation SXF_HF_AlertView

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
    self.msgLb.numberOfLines = 0;
    self.sureBtn.titleLabel.font = self.cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
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


- (void)setAlertType:(HF_AlertType)alertType{
    _alertType = alertType;
    //更改字体样式
    switch (alertType) {
        case AlertType_login:{
            
        }
        break;
        case AlertType_save:{
            
        }
        break;
        default:
            break;
    }
    //配置字体样式
    [self configerAlert];
    //更新布局
    [self layoutSubviews];
}

- (void)configerAlert{
    switch (self.alertType) {
        case AlertType_login:{
            
            
            self.titleLb.text = @"是否登录";
            self.msgLb.text = @"此功能需登录才可使用，是否登录？";
            [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
            [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        }
        break;
        case AlertType_save:{
            self.titleLb.text = @"安全提示";
            self.msgLb.text = @"付款后资金将直接进入对方账户，无法退款。为保证安全，请核实对方身份后支付。";
            [self.msgLb setLabelWithLineSpace:6.0];
            [self.sureBtn setTitle:@"知道了" forState:UIControlStateNormal];
            [self.sureBtn setTitleColor:HEX_COLOR(0xCA1400) forState:UIControlStateNormal];
        }
            break;
        case AlertType_Pay:{
            self.msgLb.text = @"支付密码不正确。";
            [self.sureBtn setTitle:@"重新输入" forState:UIControlStateNormal];
            [self.cancleBtn setTitle:@"找回并完成支付" forState:UIControlStateNormal];
            [self.sureBtn setTitleColor:HEX_COLOR(0xCA1400) forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    
    [self layoutIfNeeded];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    switch (self.alertType) {
        case AlertType_login:
            [self layoutLogInType];
            break;
         case AlertType_save:
            [self layoutSaveType];
            break;
        case AlertType_Pay:
            [self layoutPayType];
            break;
        default:
            break;
    }
}


/**
  安全提示
 */
- (void)layoutSaveType{
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(20));
        make.top.mas_equalTo(self).offset(ScreenScale(20));
        make.height.mas_equalTo(ScreenScale(17));
    }];
    
    [self.msgLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(ScreenScale(20));
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-20));
        make.left.mas_equalTo(self.titleLb.mas_left);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.msgLb.mas_bottom).offset(ScreenScale(52));
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-20));
        make.bottom.mas_equalTo(self.mas_bottom).offset(ScreenScale(-20));
        
    }];
}

/**
 登录提醒
 */
- (void) layoutLogInType{
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
    
    [self layoutIfNeeded];
}



/**
 支付提示
 */
- (void)layoutPayType{
    [self.msgLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(20));
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(33));
        make.height.mas_equalTo(ScreenScale(13));
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-20));
        make.bottom.mas_equalTo(self.mas_bottom).offset(ScreenScale(-21));
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.sureBtn.mas_left).offset(ScreenScale(-24));
        make.centerY.mas_equalTo(self.sureBtn.mas_centerY);
    }];
    
}


+ (void) showAlertType:(HF_AlertType)alertType Complete:(void(^__nullable)(BOOL btnBype))complate{
    
    UIWindow *kwin = [UIApplication sharedApplication].keyWindow;
    if (!kwin) {
        kwin =  [UIApplication sharedApplication].windows.lastObject;
    }
    
    UIView *bgView = [[UIView alloc] initWithFrame:kwin.bounds];
    bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [kwin addSubview:bgView];
    SXF_HF_AlertView *alertView = [[SXF_HF_AlertView alloc] init];
    
    [kwin addSubview:alertView];
    alertView.backgroundColor = [UIColor redColor];
    alertView.layer.cornerRadius = 5;
    alertView.layer.masksToBounds = YES;
    alertView.backgroundColor = [UIColor whiteColor];
    switch (alertType) {
        case AlertType_login:{
            alertView.frame = CGRectMake(0, 0, ScreenScale(325), ScreenScale(150));
        }
        break;
        case AlertType_save:{
//            alertView.frame = CGRectMake(0, 0, ScreenScale(287), ScreenScale(207));
            
            [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(kwin.mas_left).offset(ScreenScale(44));
                make.right.mas_equalTo(kwin.mas_right).offset(ScreenScale(-44));
                make.centerY.mas_equalTo(kwin.mas_centerY);
                make.centerX.mas_equalTo(kwin.mas_centerX);
            }];
            
            
            
        }
        break;
        case AlertType_Pay:{
            alertView.frame = CGRectMake(0, 0, ScreenScale(287), ScreenScale(120));
        }
            break;
        default:
            break;
    }
    
    alertView.alertType = alertType;
    [alertView layoutIfNeeded];
    alertView.center = bgView.center;
    alertView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.2 animations:^{
        bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        alertView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        }];
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
                    if (weakAlert.alertType == AlertType_login) {
                        if (btnType) {
                            //跳转登录
                            
                            Class loginClass = NSClassFromString(@"LoginVC");
                            id loginVC = [[loginClass alloc] init];
                            if (loginVC) {
                                UIViewController *currentVC = [self getCurrentViewController];
                                BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
                                [currentVC presentViewController:navi animated:YES completion:nil];
                            }else{
                                
                                [CustomPromptBox showTextHud:@"您还未创建登录VC"];
                            }
                        }
                    }
                }
                [weakAlert removeFromSuperview];
                [bgView removeFromSuperview];
            }];
        }];
        
    };
}








@end
