//
//  ReviseMobilePhone.m
//  HanPay
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ReviseMobilePhone.h"
//#import "HP_GetVerificationCodeNetApi.h"
#import "Per_MethodsToDealWithManage.h"
@interface ReviseMobilePhone ()
/** 手机号 */
@property (nonatomic,strong) UITextField *phoneTextField;
/** 验证码 */
@property (nonatomic,strong) UITextField *codeTextField;
@end

@implementation ReviseMobilePhone

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    [self setupNavBar];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
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
//    self.customNavBar.title = [NSString isNOTNull:[UserCache getUserPhone]] ? @"设置手机号" : @"修改手机号";
    self.customNavBar.backgroundColor = RGBA(136, 53, 230, 1);//[UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    
}
-(void)initWithUI{
    UILabel *titleLabel  = [UILabel new];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:WidthRatio(35)];
    titleLabel.textColor = HEX_COLOR(0x000000);
//    titleLabel.text = [NSString isNOTNull:[UserCache getUserPhone]] ? @"设置手机号" : @"修改手机号";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(HeightRatio(20)+self.navBarHeight);
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(22));
        make.height.mas_greaterThanOrEqualTo(1);
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel *instructionsLabel = [UILabel new];
//    instructionsLabel.text = [NSString isNOTNull:[UserCache getUserPhone]] ? @"" : MMNSStringFormat(@"您当前的手机号码为%@",[[UserCache getUserPhone] EncodeTel]);
    instructionsLabel.textColor = HEX_COLOR(0x999999);
    instructionsLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [self.view addSubview:instructionsLabel];
    [instructionsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_left);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(HeightRatio(34));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
//    self.phoneTextField = [self getTextFieldPlaceholder:[NSString isNOTNull:[UserCache getUserPhone]] ? @"请输入您当前使用的新手机号码" : @"请输入您当前使用的新手机号码" isCode:NO];
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(76));
        make.top.mas_equalTo(instructionsLabel.mas_bottom).offset(HeightRatio(52));
    }];
    
    self.codeTextField = [self getTextFieldPlaceholder:@"请输入您收到的验证码" isCode:YES];
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(76));
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).offset(HeightRatio(23));
    }];
    
    
    UILabel *label = [UILabel new];
//    label.text = [NSString isNOTNull:[UserCache getUserPhone]] ? @"" :@"修改后，您当前的账号的信息，个人资产不变";
    label.textColor = HEX_COLOR(0x999999);
    label.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(27));
        make.top.mas_equalTo(self.codeTextField.mas_bottom).offset(HeightRatio(90));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    // 0.1秒后获取frame
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
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
//        [button setTitle: [NSString isNOTNull:[UserCache getUserPhone]] ? @"确认设置" : @"确认修改" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    });
    
}
#pragma mark 获取文本框
-(UITextField *)getTextFieldPlaceholder:(NSString *)placeholder isCode:(BOOL)iscode{
    UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = placeholder;
    [tf setValue:HEX_COLOR(0x666666) forKeyPath:@"_placeholderLabel.textColor"];
    tf.textColor = [UIColor blackColor];
    tf.font = [UIFont systemFontOfSize:HeightRatio(32)];
    tf.backgroundColor = [UIColor whiteColor];
    //    tf.secureTextEntry = YES;
    if (iscode) {
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(150), HeightRatio(76))];
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
    if (![self.phoneTextField.text isValidateMobile]) {
        [WXZTipView showCenterWithText:@"请输入正确的手机号"];
        return;
    }
    
    NSDictionary *parm = @{@"phone":[NSString judgeNullReturnString:self.phoneTextField.text],@"type":@"5"};
    
    
    /*
    
    HP_GetVerificationCodeNetApi *getVerCode = [[HP_GetVerificationCodeNetApi alloc]initWithParameter:parm];
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
    //    WS(weakSelf);
    
}
-(void)buttonClick{
    if (![self.phoneTextField.text isValidateMobile]) {
        [WXZTipView showCenterWithText:@"请输入正确的手机号"];
        return;
    }
    if ([NSString isNOTNull:self.codeTextField.text]) {
        [WXZTipView showCenterWithText:@"请输入验证码"];
        return;
    }
    
    
    /*
    
    
    if ([NSString isNOTNull:[UserCache getUserPhone]] && self.tokenStr) {
        // !!!: 第三方没有手机号登录 绑定手机号
        [[Per_MethodsToDealWithManage sharedInstance]ModifyBindPhoneNotHeadTokenParameter:@{@"code":self.codeTextField.text,@"newphone":self.phoneTextField.text,@"Token":self.tokenStr} SuccessBlock:^(id  _Nonnull request) {
            if ([request boolValue]) {
        
                if (self.setPhoneNumOk) {
                    self.setPhoneNumOk(self.phoneTextField.text);
                }
        
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }else {
        [[Per_MethodsToDealWithManage sharedInstance]ModifyBindPhoneParameter:@{@"code":self.codeTextField.text,@"newphone":self.phoneTextField.text} SuccessBlock:^(id  _Nonnull request) {
            if ([request boolValue]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
     
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
@end
