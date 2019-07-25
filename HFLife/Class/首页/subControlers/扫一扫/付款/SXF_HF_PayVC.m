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
#import "UMSPPPayUnifyPayPlugin.h"



#import "HF_PayHelp.h"
@interface SXF_HF_PayVC ()
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (nonatomic, strong) SXF_HF_payStepAleryView *payView;
@property (weak, nonatomic) IBOutlet UIImageView *payHeaderImageV;
@property (weak, nonatomic) IBOutlet UILabel *payNameLb;
@property (nonatomic, strong)NSString *order_Id;//生成的订单编号
// 扫描的二维码是不是商户
@property(nonatomic, strong) NSString *isBusiness;
@end

@implementation SXF_HF_PayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = self.payType ? @"付款" : @"收款";
    
    self.payNameLb.text = [NSString stringWithFormat:@"付款给%@", self.payName];
    [self.payHeaderImageV sd_setImageWithURL:MY_URL_IMG(self.payHeaderUrl)];
    
    //自定义键盘
    [self customKeyBoard];
    
    if (self.payType) {
        [SXF_HF_AlertView showAlertType:AlertType_save Complete:^(BOOL btnBype) {
            if ([self.payMoney floatValue] == 0) {
                [self.moneyTF becomeFirstResponder];
            }
        }];
    }
}
- (void)customKeyBoard{
    
    self.moneyTF.ry_inputType = RYFloatInputType;
    self.moneyTF.clearButtonMode = UITextFieldViewModeAlways;
    self.moneyTF.textColor = [UIColor blackColor];
    self.moneyTF.textAlignment = NSTextAlignmentLeft;
    self.moneyTF.ry_interval = 20;//不做空格处理
    if (!([self.payMoney floatValue] == 0)) {
        self.moneyTF.text = self.payMoney;
        [self.moneyTF endEditing:YES];
    }

    WEAK(weakSelf);
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    
}



- (IBAction)confirmBtnClick:(UIButton *)sender {
    [self getOrder];
}

- (void)showAlert {
    if (self.payType) {
        if (self.moneyTF.text.length > 0) {
            [self.moneyTF endEditing:YES];
            self.payView = [SXF_HF_payStepAleryView showAlertComplete:^(BOOL btnBype) {
                
            } password:^(NSString * _Nonnull pwd) {
                //密码
                NSLog(@"密码框%@",pwd);
                if (pwd.length == 6) {
                    //去支付
                    [self pay:self.order_Id pwd:pwd];
                }
            } nowPayWithStyle:^(NSString * _Nonnull style) {
                [self.payView cancleAlertView];
                if ([style isEqualToString:@"支付宝"]) {
                    [self thirdPay:self.order_Id payType:@"1"];
                }else if ([style isEqualToString:@"云闪付"]) {
                    [self thirdPay:self.order_Id payType:@"3"];
                }
            }];
            self.payView.payMoneyStr = [self.moneyTF.text stringByReplacingOccurrencesOfString:@"" withString:@""];
            self.payView.isBusiness = self.isBusiness;
        }else{
            [WXZTipView showCenterWithText:@"请输入付款金额"];
        }
    }else{
        //调起收款接口
        [networkingManagerTool requestToServerWithType:POST withSubUrl:@"" withParameters:@{} withResultBlock:^(BOOL result, id value) {
            
        }];
    }
}


//去下单
- (void) getOrder{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *param = @{
                            @"app_type" : @"1",
                            @"bn_num" : self.moneyTF.text,
                            @"code_str" : self.codeStr,
                            };
    [networkingManagerTool requestToServerWithType:POST withSubUrl:SXF_LOC_URL_STR(CreateOrder) withParameters:param withResultBlock:^(BOOL result, id value) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (result && value) {
            self.order_Id = value[@"data"][@"order_id"];
            self.isBusiness = value[@"data"][@"is_business"];
            [self showAlert];
        }else{
            if (value) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else{
                [WXZTipView showCenterWithText:value[@"下单失败"]];
            }
        }
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    });
    
}

// 余额支付
- (void) pay:(NSString *)orderId pwd:(NSString *)password{
    NSDictionary *param = @{
                            @"order_id" :orderId ? orderId : @"",
                            @"paypassword" : password,
                            };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:SXF_LOC_URL_STR(GoToPay) withParameters:param withResultBlock:^(BOOL result, id value) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (result && value) {
            //支付成功
            [self jumpToPayResultVC:YES];
            [self.payView cancleAlertView];
            
            //语音播报
        }else{
            [SXF_HF_AlertView showAlertType:AlertType_Pay Complete:^(BOOL btnBype) {
                if (btnBype) {
                    //重新输入
                    self.payView.editingEable = NO;
                }else{
                    //找回密码
                    YYB_HF_setDealPassWordVC *passVC = [YYB_HF_setDealPassWordVC new];
                    passVC.isLocal = YES;
                    [self.navigationController pushViewController:passVC animated:YES];
                    [self.payView cancleAlertView];
                }
            }];
        }
    }];
}

// 第三方支付 1支付宝、2微信、3银联(云闪付) （微信的不能用去掉了）
- (void)thirdPay:(NSString *)orderId payType:(NSString *)payType {
    NSDictionary *paramDic = @{@"order_id":orderId ? orderId : @"",
                               @"payType":payType};
    [networkingManagerTool requestToServerWithType:POST withSubUrl:SXF_LOC_URL_STR(ThirdPay) withParameters:paramDic withResultBlock:^(BOOL result, id value) {
        if (result && value) { //请求成功
            NSDictionary *payInfo = value[@"data"][@"pullPayInfo"];
            if (DictIsEmpty(payInfo)) {
                [WXZTipView showBottomWithText:@"支付参数错误"];
                return;
            }
            
            NSString *payDataJsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:payInfo options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
            
            __weak typeof(self) weak_self = self;
            if (payType.integerValue == 1) {
                //开启轮询订单
                [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
                    [[WBPCreate sharedInstance] showWBProgress];
                    [weak_self pollingOrderResult:weak_self.order_Id];
                }];

                [UMSPPPayUnifyPayPlugin payWithPayChannel:CHANNEL_ALIPAY payData:payDataJsonStr callbackBlock:^(NSString *resultCode, NSString *resultInfo) {}];

            }else if (payType.integerValue == 3) {
                
                [UMSPPPayUnifyPayPlugin cloudPayWithURLSchemes:@"unifyPayHanPay" payData:payDataJsonStr viewController:self callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
                    [weak_self handlePayResultL:resultCode info:resultInfo];
                }];
            }
        }
    }];
    
    
}

// 支付宝支付结果轮询
- (void)pollingOrderResult:(NSString *)orderId {
    static NSInteger pollingCount = 0;
    @weakify(self);
    [networkingManagerTool requestToServerWithType:POST withSubUrl:SXF_LOC_URL_STR(pollingPayState) withParameters:@{@"order_id":orderId} withResultBlock:^(BOOL result, id value) {
        @strongify(self);
        NSLog(@"count:%ld", pollingCount);
        if (result || pollingCount >= 4) {
            pollingCount = 0;
            [[WBPCreate sharedInstance] hideAnimated];
            [self_weak_ jumpToPayResultVC:result];
            
        }else {
            pollingCount++;
            [self performSelector:@selector(pollingOrderResult:) withObject:orderId afterDelay:2.f];
        }
    }];
}

/**
 处理支付结果
 0000 支付成功
 1000 用户取消支付
 1001 参数错误
 1002 网络连接错误
 1003 支付客户端未安装
 2001 订单处理中，支付结果未知(有可能已经支付成功)，请通过后台接口查询订单状态
 2002 订单号重复
 2003 订单支付失败
 9999 其他支付错误
 */
-(void)handlePayResultL:(NSString *)resultCode info:(NSString *)resultInfo {
    if ([resultCode isEqualToString:@"1003"]) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [WXZTipView showBottomWithText:@"客户端未安装" duration:1.5];
        }];
        return;
    }

    [self jumpToPayResultVC:[resultCode isEqualToString:@"0000"]];
}


// 跳转支付结果界面
- (void)jumpToPayResultVC:(BOOL)result {
    SXF_HF_paySuccessVC *payVC = [SXF_HF_paySuccessVC new];
    payVC.payImage = self.payHeaderImageV.image;
    payVC.payName = self.payName;
    payVC.payStatus = result;
    payVC.payType = @"余额";
    payVC.payMoney = [self.moneyTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self.navigationController pushViewController:payVC animated:YES];
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
