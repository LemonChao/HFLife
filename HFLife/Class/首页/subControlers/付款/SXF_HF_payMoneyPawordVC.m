//
//  SXF_HF_payMoneyPawordVC.m
//  HFLife
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_payMoneyPawordVC.h"
#import "SXF_HF_Password.h"
#import "SXF_HF_paySuccessVC.h"
#import "YYB_HF_setDealPassWordVC.h"
@interface SXF_HF_payMoneyPawordVC ()
@property (nonatomic, strong)UILabel *moneyLb;
@property (nonatomic, strong)UILabel *monetTitleLb;
@property (nonatomic, strong)UILabel *passwordLb;
@property (nonatomic, strong)UILabel *alertTitleLb;
@property (nonatomic, strong)SXF_HF_Password *passwordInputView;
@end

@implementation SXF_HF_payMoneyPawordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"向商家付款";
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.moneyLb = [UILabel new];
    self.passwordLb = [UILabel new];
    self.monetTitleLb = [UILabel new];
    self.alertTitleLb = [UILabel new];
    self.passwordInputView = [[SXF_HF_Password alloc] initWithFrame:CGRectMake(ScreenScale(12), ScreenScale(201) + self.navBarHeight, SCREEN_WIDTH - ScreenScale(24), ScreenScale(49))];
    [self.view addSubview:self.passwordInputView];
    [self.view addSubview:self.moneyLb];
    [self.view addSubview:self.monetTitleLb];
    [self.view addSubview:self.alertTitleLb];
    [self.view addSubview:self.passwordLb];
    
    self.monetTitleLb.setText(@"￥").setFontSize(18).setTextColor(color0C0B0B);
    self.moneyLb.setFontSize(32).setTextColor(color0C0B0B).setText(@"999");
    self.passwordLb.setFontSize(18).setTextColor(color0C0B0B).setText(@"请输入支付密码");
    self.alertTitleLb.setFontSize(14).setTextColor(colorCA1400).setText(@"忘记密码？找回并完成支付");
    WEAK(weakSelf);
    self.passwordInputView.keyBoardCallback = ^(NSString *contentStr) {
        NSLog(@"密码 %@", contentStr);
        if (contentStr.length == 6) {
            [weakSelf checkPsd:contentStr];
        }
    };
    self.passwordInputView.editingEable = NO;
    
    [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(10);
        make.top.mas_equalTo(self.view.mas_top).offset(ScreenScale(45) + self.navBarHeight);
        make.height.mas_equalTo(ScreenScale(24));
    }];
    [self.monetTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenScale(10));
        make.bottom.mas_equalTo(self.moneyLb.mas_bottom);
        make.right.mas_equalTo(self.moneyLb.mas_left);
        make.height.mas_equalTo(ScreenScale(13));
    }];
    
    [self.passwordLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moneyLb.mas_bottom).offset(ScreenScale(75));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(ScreenScale(17));
    }];
    
    [self.alertTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordInputView.mas_bottom).offset(ScreenScale(24));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(ScreenScale(14));
    }];
    
    
   
    
}

- (void) checkPsd:(NSString *)pswd{
    NSLog(@"密码框%@",pswd);
   
    if (![pswd isEqualToString:@"123456"]) {
        [SXF_HF_AlertView showAlertType:AlertType_Pay Complete:^(BOOL btnBype) {
            if (btnBype) {
                //重新输入
                self.passwordInputView.editingEable = NO;
            }else{
                //找回密码
                [self.navigationController pushViewController:[YYB_HF_setDealPassWordVC new] animated:YES];
                self.passwordInputView.editingEable = YES;
            }
        }];
    }else{
        //网络请求
        [self pay:pswd];
    }
}


- (void) pay:(NSString *)password{
    //    [networkingManagerTool requestToServerWithType:POST withSubUrl:@"url" withParameters:@{} withResultBlock:^(BOOL result, id value) {
    //
    //    }];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //支付成功
        SXF_HF_paySuccessVC *payVC = [SXF_HF_paySuccessVC new];
//        payVC.payImage = self.payHeaderImageV.image;
        payVC.payName = @"小可爱";
        payVC.payStatus = NO;
        payVC.payType = @"余额";
        payVC.payMoney = [self.moneyLb.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        [self.navigationController pushViewController:payVC animated:YES];
    });
    
}
@end
