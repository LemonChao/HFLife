//
//  SXF_HF_PayVC.m
//  HFLife
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_PayVC.h"
#import "SXF_HF_payStepAleryView.h"
#import "UITextField+RYNumberKeyboard.h"
#import "RYNumberKeyboard.h"
#import "SXF_HF_paySuccessVC.h"
@interface SXF_HF_PayVC ()
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (nonatomic, strong) SXF_HF_payStepAleryView *payView;
@property (weak, nonatomic) IBOutlet UIImageView *payHeaderImageV;


@end

@implementation SXF_HF_PayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"付款";
    
    
    //自定义键盘
    [self customKeyBoard];
    
    
    
}
- (void)customKeyBoard{
    [self.moneyTF becomeFirstResponder];
    self.moneyTF.ry_inputType = RYFloatInputType;
    self.moneyTF.clearButtonMode = UITextFieldViewModeAlways;
    self.moneyTF.textColor = [UIColor blackColor];
    self.moneyTF.textAlignment = NSTextAlignmentLeft;
    self.moneyTF.ry_interval = 3;
    
    
    WEAK(weakSelf);
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    
}



- (IBAction)confirmBtnClick:(UIButton *)sender {
    WEAK(weakSelf);
    if (self.moneyTF.text.length > 0) {
        [self.moneyTF endEditing:YES];
        self.payView = [SXF_HF_payStepAleryView showAlertComplete:^(BOOL btnBype) {
            
        } password:^(NSString * _Nonnull pwd) {
            //密码
            NSLog(@"密码框%@",pwd);
            if (pwd.length == 6) {
                //网络请求
                [weakSelf pay:pwd];
            }
        }];
        self.payView.payMoneyStr = self.moneyTF.text;
    }else{
        [WXZTipView showCenterWithText:@"请输入付款金额"];
    }
    
}
- (void) pay:(NSString *)password{
//    [networkingManagerTool requestToServerWithType:POST withSubUrl:@"url" withParameters:@{} withResultBlock:^(BOOL result, id value) {
//
//    }];
    [MBProgressHUD showHUDAddedTo:self.payView animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUDForView:self.payView animated:YES];
        //支付成功
        SXF_HF_paySuccessVC *payVC = [SXF_HF_paySuccessVC new];
        payVC.payImage = self.payHeaderImageV.image;
        payVC.payName = self.payName;
        payVC.payStatus = YES;
        payVC.payType = @"余额";
        payVC.payMoney = self.moneyTF.text;
        [self.navigationController pushViewController:[SXF_HF_paySuccessVC new] animated:YES];
        [self.payView cancleAlertView];
    });
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //TODO: 页面appear 禁用
    [[IQKeyboardManager sharedManager] setEnable:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //TODO: 页面Disappear 启用
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (IBAction)clearMoneyTF:(UIButton *)sender {
    self.moneyTF.text = @"";
}


@end
