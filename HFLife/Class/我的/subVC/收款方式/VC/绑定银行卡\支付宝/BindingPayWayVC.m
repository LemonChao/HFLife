//
//  BindingPayWayVC.m
//  HFLife
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "BindingPayWayVC.h"
//#import "JYBDBankCardVC.h"
#import "WLCardNoFormatter.h"
//#import "Per_MethodsToDealWithManage.h"
//#import "HP_GetVerificationCodeNetApi.h"
#import "LYBmOcrManager.h"
@interface BindingPayWayVC ()<UITextFieldDelegate>
/** 姓名 */
@property (nonatomic,strong) UITextField *userNameTextField;
/** 银行卡 */
@property (nonatomic,strong) UITextField *bankCardTextField;
/** 银行卡类型*/
@property (nonatomic,strong) UITextField *typeTextField;
/** 手机号*/
@property (nonatomic,strong) UITextField *phoneTextField;
/** 验证码*/
@property (nonatomic,strong) UITextField *codeTextField;

/**
 格式化银行卡数据格式
 */
@property (strong, nonatomic) WLCardNoFormatter *cardNoFormatter;
@end

@implementation BindingPayWayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEX_COLOR(0xf5f6f7);
    [self initWithUI];
    [self setupNavBar];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [[NSOperationQueue currentQueue] addOperationWithBlock:^{
        [self.customNavBar setHidden:NO];
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"银行卡绑定";
    
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}
-(void)initWithUI{
    UIImageView *iconImageView = [UIImageView new];
    iconImageView.image = MMGetImage(@"bindinglogo");
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(HeightRatio(75)+self.navBarHeight);
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(162));
        make.width.height.mas_equalTo(WidthRatio(142));
    }];
    
    UIImageView *iconImageView1 = [UIImageView new];
    iconImageView1.image = MMGetImage(@"binding");
    [self.view addSubview:iconImageView1];
    [iconImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(iconImageView.mas_centerY);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(WidthRatio(66));
        make.height.mas_equalTo(HeightRatio(40));
    }];
    
    UIImageView *iconImageView2 = [UIImageView new];
    iconImageView2.image = MMGetImage(@"yinhangka");
    [self.view addSubview:iconImageView2];
    [iconImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(iconImageView.mas_centerY);
        make.left.mas_equalTo(iconImageView1.mas_right).offset(WidthRatio(53));
        make.width.height.mas_equalTo(WidthRatio(142));
        
    }];
    
    self.userNameTextField = [self getTextFieldPlaceholder:@"请输入真实姓名" isCode:NO Title:@"真实姓名"];
    self.userNameTextField.text = [UserCache getUserRealName];
    self.userNameTextField.enabled = NO;
    [self.view addSubview: self.userNameTextField ];
    [ self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(HeightRatio(90));
        make.height.mas_equalTo(HeightRatio(90));
    }];
    
    self.bankCardTextField = [self getTextFieldPlaceholder:@"请输入银行卡号" isCode:YES Title:@"银行卡号"];
    self.bankCardTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.bankCardTextField.delegate = self;
    self.bankCardTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview: self.bankCardTextField ];
    [ self.bankCardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.userNameTextField.mas_bottom);
        make.height.mas_equalTo(HeightRatio(90));
    }];
    
    self.typeTextField = [self getTextFieldPlaceholder:@"请输入银行名称" isCode:NO Title:@"卡类型"];//请输入
    [self.view addSubview: self.typeTextField ];
    [ self.typeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.bankCardTextField.mas_bottom);
        make.height.mas_equalTo(HeightRatio(90));
    }];
    
    self.phoneTextField = [self getTextFieldPlaceholder:@"请输入手机号码" isCode:NO Title:@"手机号码"];
    self.phoneTextField.text = [[UserCache getUserPhone] EncodeTel];
    self.phoneTextField.enabled = NO;
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview: self.phoneTextField];
    [ self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.typeTextField.mas_bottom);
        make.height.mas_equalTo(HeightRatio(90));
    }];
    
    self.codeTextField = [self getTextFieldPlaceholder:@"请输入验证码" isCode:YES Title:@"验证码"];
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview: self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom);
        make.height.mas_equalTo(HeightRatio(90));
    }];
    
    
    UIButton *button = [[UIButton alloc]init];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(145));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(145));
        make.top.mas_equalTo(self.codeTextField.mas_bottom).offset(HeightRatio(73));
        make.height.mas_equalTo(HeightRatio(68));
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
        [button setTitle:@"下一步" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    });
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.bankCardTextField) {
        [self.cardNoFormatter bankNoField:textField shouldChangeCharactersInRange:range replacementString:string];
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.bankCardTextField) {
        self.typeTextField.text = [NSString getBankName:[self.bankCardTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    }
}
#pragma mark 获取文本框
-(UITextField *)getTextFieldPlaceholder:(NSString *)placeholder isCode:(BOOL)iscode Title:(NSString *)title{
    UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = placeholder;
    [tf setValue:HEX_COLOR(0x666666) forKeyPath:@"_placeholderLabel.textColor"];
    tf.textColor = HEX_COLOR(0x333333);
    tf.font = [UIFont systemFontOfSize:HeightRatio(25)];
    tf.backgroundColor = [UIColor whiteColor];
    
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(217), HeightRatio(90))];
    lv.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel  = [UILabel new];
    titleLabel.text = title;
    titleLabel.textColor = HEX_COLOR(0x333333);
    titleLabel.font = [UIFont systemFontOfSize:WidthRatio(27)];
    [lv addSubview:titleLabel];
    [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lv.mas_left).offset(WidthRatio(44));
        make.centerY.mas_equalTo(lv.mas_centerY);
        make.height.mas_equalTo(HeightRatio(27));
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.leftView = lv;
    [tf sizeToFit];
    //    tf.secureTextEntry = YES;
    if (iscode) {
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [title isEqualToString:@"银行卡号"] ?WidthRatio(60):WidthRatio(172), HeightRatio(90))];
        rightView.backgroundColor = [UIColor clearColor];
        UIButton *codeButton = [UIButton new];
        [rightView addSubview:codeButton];
        if ([title isEqualToString:@"银行卡号"]) {
            [codeButton setImage:MMGetImage(@"saomiao") forState:(UIControlStateNormal)];
            [codeButton addTarget:self action:@selector(saomiaoClick) forControlEvents:(UIControlEventTouchUpInside)];
            [codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(rightView);
                make.top.bottom.mas_equalTo(rightView);
                //                make.width.mas_greaterThanOrEqualTo(1);
            }];
        }else{
            codeButton.titleLabel.font =[UIFont systemFontOfSize:WidthRatio(25)];
            [codeButton addTarget:self action:@selector(getLoginCode:) forControlEvents:(UIControlEventTouchUpInside)];
            [codeButton setTitleColor:HEX_COLOR(0x7926ff) forState:(UIControlStateNormal)];
            [codeButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
            [codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(rightView.mas_left);
                make.top.bottom.mas_equalTo(rightView);
                make.width.mas_greaterThanOrEqualTo(1);
            }];
        }
        
        
        
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
    //    WS(weakSelf);
//    [self openCountdown:send];
    
    
    
    
    
    /*
    
    HP_GetVerificationCodeNetApi *getVerCode = [[HP_GetVerificationCodeNetApi alloc]initWithParameter:@{@"phone":[UserCache getUserPhone],@"type":@"6"}];
    [getVerCode startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_GetVerificationCodeNetApi *getCode = (HP_GetVerificationCodeNetApi*) request;
        NSInteger status = [getCode getCodeStatus];
        if (status == 1) {
            [WXZTipView showCenterWithText:@"短信验证码已发送"];
            [self openCountdown:send];
        }else{
            //            [WXZTipView showCenterWithText:@"短信验证码发送失败"];
            [WXZTipView showCenterWithText:[getCode getMsg]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_GetVerificationCodeNetApi *getCode = (HP_GetVerificationCodeNetApi*) request;
        [WXZTipView showCenterWithText:[getCode getMsg]];
    }];
     
     
     
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
-(void)saomiaoClick{
    WS(weakSelf);
    
    [[LYBmOcrManager ocrShareManaer] presentAcrVCWithType:CardTypeBankCard complete:^(id result, UIImage *image) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.bankCardTextField.text = result[@"result"][@"bank_card_number"];
            NSString *bankName = result[@"result"][@"bank_name"];
            if (![NSString isNOTNull:bankName]) {
                weakSelf.typeTextField.text = bankName;
                [WXZTipView showCenterWithText:@"识别成功"];

            }else {
                weakSelf.typeTextField.text = [NSString getBankName:[weakSelf.bankCardTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
            }
        });
    }];
    
//    JYBDBankCardVC *vc = [[JYBDBankCardVC alloc]init];
//    vc.finish = ^(JYBDBankCardInfo *info, UIImage *image) {
//        weakSelf.bankCardTextField.text = info.bankNumber;
//        weakSelf.typeTextField.text = [NSString getBankName:[weakSelf.bankCardTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
//    };
//    [self.navigationController pushViewController:vc animated:YES];
}
- (WLCardNoFormatter *)cardNoFormatter {
    if(_cardNoFormatter == nil) {
        _cardNoFormatter = [[WLCardNoFormatter alloc] init];
    }
    return _cardNoFormatter;
}

-(void)buttonClick{
    if ([NSString isNOTNull:self.userNameTextField.text]) {
        [WXZTipView showCenterWithText:@"未获取到真实姓名"];
        return;
    }
    if (![NSString checkCardNo:self.bankCardTextField.text]) {
        [WXZTipView showCenterWithText:@"请填写正确的银行卡号"];
        return;
    }
    if ([NSString isNOTNull:self.typeTextField.text]) {
        [WXZTipView showCenterWithText:@"请输入银行名称"];
        return;
    }
    if (![[UserCache getUserPhone] isValidateMobile]) {
        [WXZTipView showCenterWithText:@"请填写正确的手机号"];
        return;
    }
    if ([NSString isNOTNull:self.codeTextField.text]) {
        [WXZTipView showCenterWithText:@"请填写验证码"];
        return;
    }
    NSDictionary *dict = @{@"type":@"2",
                           @"code":self.codeTextField.text,
                           @"bank_card":self.bankCardTextField.text,
                           @"bank_name":self.typeTextField.text
                           };
    
    
    
    /*
    
    
    [[Per_MethodsToDealWithManage sharedInstance]bindBankCardPayWayParameter:dict SuccessBlock:^(id  _Nonnull request) {
        if ([request boolValue]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
     
     
     
     */
     
     
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
