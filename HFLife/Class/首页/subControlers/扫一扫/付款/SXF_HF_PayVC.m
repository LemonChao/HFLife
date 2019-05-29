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
#import "YYB_HF_setDealPassWordVC.h"
@interface SXF_HF_PayVC ()
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (nonatomic, strong) SXF_HF_payStepAleryView *payView;
@property (weak, nonatomic) IBOutlet UIImageView *payHeaderImageV;
@property (weak, nonatomic) IBOutlet UILabel *payNameLb;
@property (nonatomic, strong)NSString *order_Id;//生成的订单编号
@end

@implementation SXF_HF_PayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"付款";
    
    self.payNameLb.text = [NSString stringWithFormat:@"付款给%@", self.payName];
    [self.payHeaderImageV sd_setImageWithURL:MY_URL_IMG(self.payHeaderUrl)];
    
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
                
                if (![pwd isEqualToString:@"123456"]) {
                    [SXF_HF_AlertView showAlertType:AlertType_Pay Complete:^(BOOL btnBype) {
                        if (btnBype) {
                            //重新输入
                            self.payView.editingEable = NO;
                        }else{
                            //找回密码
                            [self.navigationController pushViewController:[YYB_HF_setDealPassWordVC new] animated:YES];
                            [self.payView cancleAlertView];
                        }
                    }];
                }else{
                    //网络请求
                    [weakSelf getOrder:pwd];
                }
            }
        }];
        self.payView.payMoneyStr = [self.moneyTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }else{
        [WXZTipView showCenterWithText:@"请输入付款金额"];
    }
    
}
//去下单
- (void) getOrder:(NSString *)password{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *param = @{
                            @"app_type" : @"1",
                            @"bn_num" : self.moneyTF.text,
                            @"code_str" : self.codeStr,
                            };
    [networkingManagerTool requestToServerWithType:POST withSubUrl:CreateOrder withParameters:param withResultBlock:^(BOOL result, id value) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (result && value) {
            NSString *orderIdStr = value[@"data"][@"order_id"];
            self.order_Id = orderIdStr;
            [WXZTipView showCenterWithText:value[@"msg"]];
            //去支付
            [self pay:self.order_Id pwd:password];
        }else{
            [WXZTipView showCenterWithText:value[@"下单失败"]];
        }
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        
    });
    
}

- (void) pay:(NSString *)orderId pwd:(NSString *)password{
    NSDictionary *param = @{
                            @"order_id" :orderId ? orderId : @"",
                            @"paypassword" : password,
                            };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:GoToPay withParameters:param withResultBlock:^(BOOL result, id value) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (result && value) {
            
            [WXZTipView showCenterWithText:value[@"msg"]];
            
            //支付成功
            SXF_HF_paySuccessVC *payVC = [SXF_HF_paySuccessVC new];
            payVC.payImage = self.payHeaderImageV.image;
            payVC.payName = self.payName;
            payVC.payStatus = YES;
            payVC.payType = @"余额";
            payVC.payMoney = [self.moneyTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            [self.navigationController pushViewController:payVC animated:YES];
            [self.payView cancleAlertView];
        }
    }];
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
