//
//  SetTradePassword.m
//  HanPay
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "SetTradePassword.h"
#import "LDDKeyboardView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
//#import "HP_GetVerificationCodeNetApi.h"
#import "RSAEncryptor.h"
#import "Per_MethodsToDealWithManage.h"
@interface SetTradePassword ()
{
    LDDKeyboardView *customkeyB;
}
/** 手机号 */
@property (nonatomic,strong) UITextField *phoneTextField;
/** 验证码 */
@property (nonatomic,strong) UITextField *codeTextField;
/** 交易密码*/
@property (nonatomic,strong) UITextField *tradingPawTextField;
/** 确认交易密码*/
@property (nonatomic,strong) UITextField *affirm_tradingPawTextField;
@end

@implementation SetTradePassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWithUI];
    [self setupNavBar];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    IQKeyboardManager *keyboardManager =  [IQKeyboardManager sharedManager];
//    keyboardManager.enable = NO;
//    keyboardManager.enableAutoToolbar = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    IQKeyboardManager *keyboardManager =  [IQKeyboardManager sharedManager];
//    keyboardManager.enable = YES;
//    keyboardManager.enableAutoToolbar = YES;
}
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
//    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"设置交易密码";
    self.customNavBar.backgroundColor = RGBA(136, 53, 230, 1);//[UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    
}
-(void)initWithUI{
//    customkeyB = [LDDKeyboardView loadKeyboardFromNib];
//    customkeyB.frame = CGRectMake(0, 0, SCREEN_WIDTH, 260);
//    customkeyB.delegate = self;
    
    self.phoneTextField = [self getTextFieldPlaceholder:@"" isCode:NO Title:@"手机号码"];
    self.phoneTextField.userInteractionEnabled = NO;
    self.phoneTextField.text = [[UserCache getUserPhone] EncodeTel];
    [self.view addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight);
        make.height.mas_equalTo(HeightRatio(90));
    }];
    
    self.codeTextField = [self getTextFieldPlaceholder:@"请填写获取的验证码" isCode:YES Title:@"验证码"];
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.top.mas_equalTo(self.phoneTextField.mas_bottom);
        make.height.mas_equalTo(HeightRatio(90));
    }];
    
    self.tradingPawTextField = [self getTextFieldPlaceholder:@"请输入交易密码" isCode:NO Title:@"交易密码"];
    self.tradingPawTextField.secureTextEntry = YES;
    self.tradingPawTextField.keyboardType = UIKeyboardTypeNumberPad;
//    self.tradingPawTextField.inputView =  customkeyB.inputView;
//    self.tradingPawTextField.inputAccessoryView = customkeyB.accessoryView;
    [self.view addSubview:self.tradingPawTextField];
    [self.tradingPawTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.top.mas_equalTo(self.codeTextField.mas_bottom);
        make.height.mas_equalTo(HeightRatio(90));
    }];

    self.affirm_tradingPawTextField = [self getTextFieldPlaceholder:@"请确认交易密码" isCode:NO Title:@"确认密码"];
    self.affirm_tradingPawTextField.secureTextEntry = YES;
    self.affirm_tradingPawTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.affirm_tradingPawTextField];
    [self.affirm_tradingPawTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.top.mas_equalTo(self.tradingPawTextField.mas_bottom);
        make.height.mas_equalTo(HeightRatio(90));
    }];
//
    UILabel *label = [UILabel new];
    label.text = @"请注意！交易密码不能与登录密码相同";
    label.textColor = HEX_COLOR(0x999999);
    label.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(27));
        make.top.mas_equalTo(self.affirm_tradingPawTextField.mas_bottom).offset(HeightRatio(123));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
//
    UIButton *button = [[UIButton alloc]init];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.top.mas_equalTo(label.mas_bottom).offset(HeightRatio(30));
        make.height.mas_equalTo(HeightRatio(88));
    }];
        // 0.1秒后获取frame
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0,  SCREEN_WIDTH-WidthRatio(20)-WidthRatio(20), HeightRatio(88));
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.38),@(0.6),@(0.8),@(1.0)];//渐变点

        [gradientLayer setColors:@[(id)[HEX_COLOR(0x9f22ff) CGColor],(id)[HEX_COLOR(0x9323ff) CGColor],(id)HEX_COLOR(0x7f23ff).CGColor]];//渐变数组
        [button.layer addSublayer:gradientLayer];
        MMViewBorderRadius(button, WidthRatio(10), 0, [UIColor clearColor]);
        [button setTitle:@"完成" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    });
}
-(void)buttonClick{
    if ([NSString isNOTNull:self.codeTextField.text]) {
        [WXZTipView showCenterWithText:@"请输入验证码"];
        return;
    }
    if (![self.tradingPawTextField.text isPayPassword]) {
        [WXZTipView showCenterWithText:@"请输入6位纯数字的交易密码"];
        return;
    }
    if (![self.tradingPawTextField.text isEqualToString:self.affirm_tradingPawTextField.text]) {
        [WXZTipView showCenterWithText:@"两次输入的密码不一致"];
        return;
    }
    NSString *encryptStr = [RSAEncryptor encryptString:self.tradingPawTextField.text publicKey:ENCRYPTIONPUBLICKEY];
    
    NSLog(@"加密前:%@", self.tradingPawTextField.text);
    NSLog(@"加密后:%@", encryptStr);
//    NSLog(@"解密后:%@", [RSAEncryptor decryptString:encryptStr privateKey:@"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANNtnpw0f0+B0XrRpAq94vPcVNqXLMdDBunrTXLvtLOYYdfcXk2hVRlt0rtQx2gIsrgUHOJN7BgP0Na8AStdmj0EW4j3psCinzB+XVWRnLIdNzOfE0kUZJB38HvT8TEyAwGkTCQAB3JSoiMh1UaHUVAr/hpzBLf1hfBtL4iUew9JAgMBAAECgYA1tGeQmAkqofga8XtwuxEWDoaDS9k0+EKeUoXGxzqoT/GyiihuIafjILFhoUA1ndf/yCQaG973sbTDhtfpMwqFNQq13+JAownslTjWgr7Hwf7qplYW92R7CU0v7wFfjqm1t/2FKU9JkHfaHfb7qqESMIbO/VMjER9o4tEx58uXDQJBAO0O4lnWDVjr1gN02cqvxPOtTY6DgFbQDeaAZF8obb6XqvCqGW/AVms3Bh8nVlUwdQ2K/xte8tHxjW9FtBQTLd8CQQDkUncO35gAqUF9Bhsdzrs7nO1J3VjLrM0ITrepqjqtVEvdXZc+1/UrkWVaIigWAXjQCVfmQzScdbznhYXPz5fXAkEAgB3KMRkhL4yNpmKRjhw+ih+ASeRCCSj6Sjfbhx4XaakYZmbXxnChg+JB+bZNz06YBFC5nLZM7y/n61o1f5/56wJBALw+ZVzE6ly5L34114uG04W9x0HcFgau7MiJphFjgUdAtd/H9xfgE4odMRPUD3q9Me9LlMYK6MiKpfm4c2+3dzcCQQC8y37NPgpNEkd9smMwPpSEjPW41aMlfcKvP4Da3z7G5bGlmuICrva9YDAiaAyDGGCK8LxC8K6HpKrFgYrXkRtt"]);
    
    [Per_MethodsToDealWithManage sharedInstance].superVC = self;
    [[Per_MethodsToDealWithManage sharedInstance]ModifyPayPasswordParameter:@{@"code":self.codeTextField.text,@"paypass":self.tradingPawTextField.text} SuccessBlock:^(id  _Nonnull request) {
        if ([request boolValue]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            
        }
    }];

}
#pragma mark 获取文本框
-(UITextField *)getTextFieldPlaceholder:(NSString *)placeholder isCode:(BOOL)iscode Title:(NSString *)title{
    UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = placeholder;
    [tf setValue:HEX_COLOR(0x666666) forKeyPath:@"_placeholderLabel.textColor"];
    tf.textColor = [UIColor blackColor];
    tf.font = [UIFont systemFontOfSize:HeightRatio(28)];
    tf.backgroundColor = [UIColor whiteColor];
    
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(170), HeightRatio(90))];
    lv.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel  = [UILabel new];
    titleLabel.text = title;
    titleLabel.textColor = HEX_COLOR(0x000000);
    titleLabel.font = [UIFont systemFontOfSize:WidthRatio(27)];
    [lv addSubview:titleLabel];
    [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lv.mas_left);
        make.centerY.mas_equalTo(lv.mas_centerY);
        make.height.mas_equalTo(HeightRatio(27));
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.leftView = lv;
    [tf sizeToFit];
        //    tf.secureTextEntry = YES;
    if (iscode) {
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(150), HeightRatio(90))];
        rightView.backgroundColor = [UIColor clearColor];
        UIButton *codeButton = [UIButton new];
        codeButton.titleLabel.font =[UIFont systemFontOfSize:WidthRatio(28)];
        [codeButton addTarget:self action:@selector(getLoginCode:) forControlEvents:(UIControlEventTouchUpInside)];
        [codeButton setTitleColor:HEX_COLOR(0x7926ff) forState:(UIControlStateNormal)];
        [codeButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        [rightView addSubview:codeButton];
        [codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rightView.mas_right);
            make.top.bottom.mas_equalTo(rightView);
            make.width.mas_greaterThanOrEqualTo(1);
        }];
        tf.rightViewMode = UITextFieldViewModeAlways;
        tf.rightView = rightView;
    }
    UILabel *lin = [UILabel new];
    lin.backgroundColor = HEX_COLOR(0xEAEAEA);
    [tf addSubview:lin];
    [lin mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(tf);
        make.height.mas_equalTo(HeightRatio(1));
    }];
    [self.view addSubview:tf];
    return tf;
}
-(void)getLoginCode:(UIButton *)send{
    if (![[UserCache getUserPhone] isValidateMobile]) {
        [WXZTipView showCenterWithText:@"请输入正确的手机号"];
        return;
    }
    
    /*
    HP_GetVerificationCodeNetApi *getVerCode = [[HP_GetVerificationCodeNetApi alloc]initWithParameter:@{@"phone":[UserCache getUserPhone],@"type":@"4"}];
    [getVerCode startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_GetVerificationCodeNetApi *getCode = (HP_GetVerificationCodeNetApi*) request;
        NSInteger status = [getCode getCodeStatus];
        if (status == 1) {
            [WXZTipView showCenterWithText:@"短信验证码已发送"];
            [self openCountdown:send];
        }else{
            [WXZTipView showCenterWithText:@"短信验证码发送失败"];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_GetVerificationCodeNetApi *getCode = (HP_GetVerificationCodeNetApi*) request;
        [WXZTipView showCenterWithText:[getCode getMsg]];
    }];
        //    WS(weakSelf);
     
     
     */

}
    // 开启倒计时效果
-(void)openCountdown:(UIButton *)authCodeBtn{
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                    //设置按钮的样式
                [authCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [authCodeBtn setTitleColor:HEX_COLOR(0x54a8dd) forState:UIControlStateNormal];
                authCodeBtn.userInteractionEnabled = YES;
                    //                self.userPhoneTextField.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                    //设置按钮显示读秒效果
                [authCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [authCodeBtn setTitleColor:HEX_COLOR(0xffc077) forState:UIControlStateNormal];
                authCodeBtn.userInteractionEnabled = NO;
                    //                self.userPhoneTextField.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
