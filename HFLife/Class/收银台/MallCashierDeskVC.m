//
//  MallCashierDeskVC.m
//  HanPay
//
//  Created by mac on 2019/2/20.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "MallCashierDeskVC.h"
#import "UMSPPPayUnifyPayPlugin.h"
#import "HHPayPasswordView.h"

@interface MallCashierDeskVC ()<HHPayPasswordViewDelegate>

/**
 价格Label
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property(nonatomic, strong) UIButton *currentSelectBtn;
/** 邮政银行支付 */
@property (weak, nonatomic) IBOutlet UIButton *postBankButton;
/** 余额s支付按钮 */
@property (weak, nonatomic) IBOutlet UIButton *yeePayButton;

/**
 去支付
 */
@property (weak, nonatomic) IBOutlet UIButton *goPayClick;

@property (nonatomic ,strong) NSString *payType;

@property (nonatomic ,strong) NSTimer *timer;


@end



@implementation MallCashierDeskVC
{
    NSInteger searchNum;//轮询次数
    NSInteger searchMaxTime;
}
- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(fireTimer) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
//        [_timer fire];
    }
    
    return _timer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.currentSelectBtn = self.postBankButton;
//    self.currentSelectBtn.selected = YES;
    [self setupNavigation];
    self.priceLabel.text = [NSString judgeNullReturnString:self.price];
    [self.goPayClick setTitle:MMNSStringFormat(@"银联支付(¥%@)",[NSString judgeNullReturnString:self.price]) forState:(UIControlStateNormal)];
    self.payType = @"";
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkOrderStatus:) name:@"payStatus" object:nil];
    
    
    //初始化轮询次数
    searchMaxTime = 5;//最大5 次
    searchNum = 0;
    // !!!: 默认支付类型
    self.currentSelectBtn = self.yeePayButton;
    self.currentSelectBtn.selected = YES;
    [self.goPayClick setTitle:MMNSStringFormat(@"余额支付(¥%@)",[NSString judgeNullReturnString:self.price]) forState:(UIControlStateNormal)];
}


- (void) checkOrderStatus:(NSNotification *)noti{
    NSLog(@"去轮询-----%@", self.payType);
    if (self.payType.length != 0 && self.payType != @"wxpay_h5") {
        //这里设置 为空控制下次进来 轮询
        self.payType = @"";
        searchNum = 0;
        [self.timer fire];
    }
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    if (self.isFromOrder) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self cancleTimer];
}
- (void)setupNavigation {
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    self.customNavBar.title = @"汉支付收银台";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}

- (IBAction)payStyleAction:(UIButton *)button {
    if (self.currentSelectBtn == button) return;
    
#warning 微信暂时不能选中
    /*
    if (button.tag == 103) {
        [WXZTipView showCenterWithText:@"暂未开通微信支付"];
        return;
    }
    if (button.tag == 102) {
        [WXZTipView showCenterWithText:@"暂未开通支付宝支付"];
        return;
    }
    if (button.tag == 101) {
        [WXZTipView showCenterWithText:@"暂未开通银联支付"];
        return;
    }
     */
    button.selected = !button.selected;
    self.currentSelectBtn.selected = !self.currentSelectBtn.selected;
    
    self.currentSelectBtn = button;
    NSString *str ;
    if (button.tag==101) {
       str = MMNSStringFormat(@"银联支付(¥%@)",[NSString judgeNullReturnString:self.price]);
    }else if (button.tag==102){
        str = MMNSStringFormat(@"支付宝支付(¥%@)",[NSString judgeNullReturnString:self.price]);
    }else if (button.tag==103){
        str = MMNSStringFormat(@"微信支付(¥%@)",[NSString judgeNullReturnString:self.price]);
    }else{
        str = MMNSStringFormat(@"余额支付(¥%@)",[NSString judgeNullReturnString:self.price]);
    }
    [self.goPayClick setTitle:str forState:(UIControlStateNormal)];
}

- (IBAction)goPayButtonClick:(id)sender {
    
    if (!self.currentSelectBtn) {
        return [WXZTipView showCenterWithText:@"请选择支付类型"];
    }
    NSString *type;
    if (self.currentSelectBtn.tag==101) {
        type = @"yinlian_pay";
    }else if (self.currentSelectBtn.tag==102){
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]]) {
            [WXZTipView showCenterWithText:@"手机暂未安装支付软件"];
            return ;
        }
        type = @"alipay";
    }else if (self.currentSelectBtn.tag==103){
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]){
            [WXZTipView showCenterWithText:@"手机暂未安装微信"];
            return;
        }
       type = @"wxpay_h5";
    }else {
        // !!!: 余额支付类型设置
        
        
        if ([[userInfoModel sharedUser].set_pass integerValue] == 0) {
            
        } else {
           return [WXZTipView showCenterWithText:@"请先设置交易密码"];
        }
        
        if (![[userInfoModel sharedUser] chect_rz_status]) {
            [WXZTipView showCenterWithText:[userInfoModel sharedUser].rz_statusName];
        }
       
        
        type = @"yee_pay";
        self.payType = type;
        HHPayPasswordView *payPasswordView = [[HHPayPasswordView alloc] init];
        payPasswordView.delegate = self;
        [payPasswordView showInView:self.view];

        return;
    }
    self.payType = type;
    NSDictionary *dict ;
    if (self.id_type) {
        dict = @{@"id":self.orderID,@"payment_code":type,@"id_type":@"1"};
    }else{
        dict = @{@"id":self.orderID,@"payment_code":type};
    }
    [self getOrderPayContent:dict];
}

- (void)getOrderPayContent:(NSDictionary *)dict {
    
    
    [networkingManagerTool requestToServerWithType:POST withSubUrl:@"" withParameters:@{} withResultBlock:^(BOOL result, id value) {
        if ([self.payType isEqualToString:@"yee_pay"]) {
            // !!!:余额支付完成
            [self.navigationController.viewControllers[0].navigationController pushViewController:[[NSClassFromString(@"MyOrderVC") alloc]init] animated:YES];
            self.isFromOrder = YES;
            return;
        }
        
        
        NSDictionary *dict = value[@"data"];
        //            LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"温馨提示" message:@"订单支付成功？" cancelBtnTitle:@"支付失败" otherBtnTitle:@"支付成功" clickIndexBlock:^(NSInteger clickIndex) {
        //                if(clickIndex == 1){
        //                    [self.navigationController popToRootViewControllerAnimated:YES];
        //                }else{
        //                    [self.navigationController popToRootViewControllerAnimated:YES];
        //                }
        //            }];
        //            alert.animationStyle=LXASAnimationTopShake;
        //            [alert showLXAlertView];
        if (![NSString isNOTNull:[NSString judgeNullReturnString:dict[@"pullPayInfo"]]]) {
            if (self.currentSelectBtn.tag==101){
                NSString *payDataJsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict[@"pullPayInfo"] options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
                [UMSPPPayUnifyPayPlugin cloudPayWithURLSchemes:@"unifyPayHanPay" payData:payDataJsonStr viewController:self callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
                    if ([resultCode isEqualToString:@"1003"]) {
                        [WXZTipView showCenterWithText:resultInfo];
                    }else if ([resultCode isEqualToString:@"1000"]){
                        [WXZTipView showCenterWithText:@"付款已取消"];
                    }
                    NSLog(@"=====%@",[NSString stringWithFormat:@"resultCode = %@\nresultInfo = %@", resultCode, resultInfo]);
                }];
            }else if ([self.payType isEqualToString:@"alipay"]){//支付宝
                NSString *payDataJsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict[@"pullPayInfo"] options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
                [UMSPPPayUnifyPayPlugin payWithPayChannel:CHANNEL_ALIPAY payData:payDataJsonStr callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
                    if ([resultCode isEqualToString:@"1003"]) {
                        NSLog(@"%@",[NSString stringWithFormat:@"resultCode = %@\nresultInfo = %@", resultCode, resultInfo]);
                    }
                }];
            }else if ([self.payType isEqualToString:@"wxpay_h5"]){
                NSString *payDataJsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict[@"pullPayInfo"] options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
                
                //添加通知监听
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxPayCallback:) name:@"wxPay" object:nil];
                if ([UMSPPPayUnifyPayPlugin registerApp:dict[@"pullPayInfo"][@"appid"]]) {
                    [UMSPPPayUnifyPayPlugin payWithPayChannel:CHANNEL_WEIXIN payData:payDataJsonStr callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
                        if ([resultCode isEqualToString:@"1003"]) {
                            NSLog(@"%@",[NSString stringWithFormat:@"resultCode = %@\nresultInfo = %@", resultCode, resultInfo]);
                        }
                    }];
                }
            }
            
            
            else {//余额支付
                
            }
        }else{
            [WXZTipView showCenterWithText:@"支付信息失败"];
        }
        
    }];
}

//微信支付回调
//微信支付回调
- (void)wxPayCallback:(NSNotification *)noti{
     NSLog(@"%@", noti.userInfo);
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if ([noti.userInfo[@"type"] isEqualToString:@"-2"]) {
            [WXZTipView showBottomWithText:@"您已取消微信支付" duration:2];
        }else if([noti.userInfo[@"type"] isEqualToString:@"0"]){
            [WXZTipView showBottomWithText:@"支付成功！" duration:1.5];
        }else{
            [WXZTipView showBottomWithText:@"支付失败！" duration:1.5];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    //释放通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"wxPay" object:nil];
}

- (void) searchOrder{
    
    [self cancleTimer];
    NSString *orderType = @"";
    if (!self.isHotel) {
        if (self.id_type) {
            orderType = @"3";
        }else{
            orderType = @"2";
        }
    }else{
        orderType = @"1";
    }
    
    [self cancleTimer];
    NSDictionary *param = @{
                            @"id" : self.orderID ? self.orderID : @"",
                            @"order_type" : orderType ? orderType : @"",
                            @"id_type" : @(self.isNowPay),
                            };
    
    [networkingManagerTool requestToServerWithType:POST withSubUrl:@"" withParameters:param withResultBlock:^(BOOL result, id value) {
        NSDictionary *dict = value[@"data"];
        if ([dict[@"status"] integerValue] == 1) {
            if ([dict isKindOfClass:[NSDictionary class]] && dict[@"pay_success"] != nil && dict[@"pay_success"] != [NSNull class]) {
                //结束轮询
                [self cancleTimer];
                if ([dict[@"pay_success"] integerValue] == 1) {
                    [WXZTipView showCenterWithText:@"支付成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                    //                        [self showAlert];
                }else{
                    [WXZTipView showCenterWithText:@"请查看订单"];
                    //                        [self showAlert];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                [WXZTipView showCenterWithText:@"订单查询失败"];
                //继续轮询
                [self.timer fire];
            }
        }else{
            [WXZTipView showCenterWithText:@"订单查询失败"];
            //继续轮询
            [self.timer fire];
        }
    }];
}




- (void) fireTimer{
    NSLog(@"fier");
    //说明跳了支付
    if (searchNum >= searchMaxTime) {
        [self cancleTimer];
        [self showAlert];
    }else{
        [self searchOrder];
    }
    searchNum ++;
}



- (void) cancleTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)removeFromParentViewController{
    [super removeFromParentViewController];
}

- (void)dealloc{
    NSLog(@"dealloc");
}


- (void) showAlert{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"订单信息查询失败!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
   
    [alertVC addAction:cancleAction];
    [alertVC addAction:confirmAction];
    
    
    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
    
    
}

#pragma mark - HHPayPasswordViewDelegate
- (void)passwordView:(HHPayPasswordView *)passwordView didFinishInputPayPassword:(NSString *)password{
    NSDictionary *dict ;
    if (self.id_type) {
        dict = @{@"id":self.orderID,@"payment_code":self.payType,@"id_type":@"1",@"pay_passwd":password};
    }else{
        dict = @{@"id":self.orderID,@"payment_code":self.payType,@"pay_passwd":password};
    }
    [self getOrderPayContent:dict];
    
}
- (void)forgetPayPassword{
    
}



@end

