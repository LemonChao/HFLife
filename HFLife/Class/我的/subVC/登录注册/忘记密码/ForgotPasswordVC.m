//
//  ForgotPasswordVC.m
//  HanPay
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ForgotPasswordVC.h"
//#import "HP_GetVerificationCodeNetApi.h"
//#import "HP_ForgotPasswordNetApi.h"
@interface ForgotPasswordVC ()
/** 手机号*/
@property (nonatomic,strong)UITextField *phoneTextField;

/**
 密码
 */
@property (nonatomic,strong)UITextField *passwordTextField;

/**
 确认密码
 */
@property (nonatomic,strong)UITextField *inviteCodeTextField;

/**
 验证码
 */
@property (nonatomic,strong)UITextField *verificationCodeTextField;
@end

@implementation ForgotPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar setOnClickRightButton:^{
        NSLog(@"搜索");
    }];
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}
-(void)initWithUI{
    UILabel *titleLabel  = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:WidthRatio(42)];
    titleLabel.textColor = HEX_COLOR(0x000000);
    titleLabel.text = self.isSetPas ? @"设置密码":@"忘记密码";
    [self.view addSubview:titleLabel];
    titleLabel.sd_layout
    .topSpaceToView(self.view, HeightRatio(256))
    .leftSpaceToView(self.view, WidthRatio(94))
    .heightIs(HeightRatio(40));
        //    设置最大宽度，实现自适应宽度
    [titleLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    [self.view addSubview:self.phoneTextField];
    self.phoneTextField.sd_layout
    .leftSpaceToView(self.view, WidthRatio(98))
    .rightSpaceToView(self.view, WidthRatio(90))
    .heightIs(HeightRatio(85))
    .topSpaceToView(titleLabel, HeightRatio(107));
    
    UILabel *instructionsLabel = [UILabel new];
    instructionsLabel.text = @"密码为6-12位，必须包含数字、字母两种元素";
    instructionsLabel.textColor = HEX_COLOR(0x999999);
    instructionsLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [self.view addSubview:instructionsLabel];
    [instructionsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_left);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(HeightRatio(34));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    
    self.passwordTextField = [self getTextFieldPlaceholder:@"请输入您的密码" imageName:@"mima"];
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.sd_layout
    .leftSpaceToView(self.view, WidthRatio(98))
    .rightSpaceToView(self.view, WidthRatio(90))
    .topSpaceToView(self.phoneTextField, HeightRatio(22))
    .heightIs(HeightRatio(85));
    
    self.inviteCodeTextField = [self getTextFieldPlaceholder:@"请确认您的密码" imageName:@"mima"];
    self.inviteCodeTextField.secureTextEntry = YES;
    self.inviteCodeTextField.sd_layout
    .leftSpaceToView(self.view, WidthRatio(98))
    .rightSpaceToView(self.view, WidthRatio(90))
    .topSpaceToView(self.passwordTextField, HeightRatio(22))
    .heightIs(HeightRatio(85));
    
    self.verificationCodeTextField.sd_layout
    .leftSpaceToView(self.view, WidthRatio(98))
    .rightSpaceToView(self.view, WidthRatio(90))
    .topSpaceToView(self.inviteCodeTextField, HeightRatio(22))
    .heightIs(HeightRatio(85));
    
    
    UIButton *confirmBtn = [UIButton new];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(30)];
    confirmBtn.backgroundColor = [UIColor redColor];
    [confirmBtn setTitle:@"确认" forState:(UIControlStateNormal)];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:confirmBtn];
    confirmBtn.sd_layout
    .leftSpaceToView(self.view, WidthRatio(95))
    .rightSpaceToView(self.view, WidthRatio(83))
    .topSpaceToView(self.verificationCodeTextField, HeightRatio(230))
    .heightIs(HeightRatio(88));
    MMViewBorderRadius(confirmBtn, WidthRatio(44), 0, [UIColor clearColor]);
    
}
-(void)getLoginCode:(UIButton *)send{
    if (![self.phoneTextField.text isValidateMobile]) {
        [WXZTipView showCenterWithText:@"请输入正确的手机号"];
        return;
    }
    /*
    HP_GetVerificationCodeNetApi *getVerCode = [[HP_GetVerificationCodeNetApi alloc]initWithParameter:@{@"phone":self.phoneTextField.text,@"type":@"3"}];
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
-(void)confirmBtnClick{
    if (![self.phoneTextField.text isValidateMobile]) {
        [WXZTipView showCenterWithText:@"请输入正确的手机号"];
        return;
    }
    if (![self.passwordTextField.text checkPassWord]) {
        [WXZTipView showCenterWithText:@"密码格式应为6~20位，数字和字母组合的形式"];
        return;
    }
    if (![self.passwordTextField.text isEqualToString:self.inviteCodeTextField.text]) {
        [WXZTipView showCenterWithText:@"两次输入的密码不一致"];
        return;
    }
    if ([NSString isNOTNull:self.verificationCodeTextField.text]) {
        [WXZTipView showCenterWithText:@"验证码不能为空"];
        return;
    }
    NSDictionary *dict = @{
                           @"phone":self.phoneTextField.text,
                           @"code":self.verificationCodeTextField.text,
                           @"password":self.passwordTextField.text
                           };
    
    [networkingManagerTool requestToServerWithType:POST withSubUrl:@"忘记密码接口" withParameters:nil withResultBlock:^(BOOL result, id value) {
//        if (result) {
//            [UserCache setUserPhone:self.phoneTextField.text];
//            [UserCache setUserPass:self.passwordTextField.text];
//            if (self.isSetPas) {
//                [UserCache setUserPassword:@"1"];
//            }
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        [WXZTipView showCenterWithText:value[@"msg"]];
        
    }];
    
    /*
    HP_ForgotPasswordNetApi *forgotPasswordNetApi = [[HP_ForgotPasswordNetApi alloc]initWithParameter:dict];
    [forgotPasswordNetApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_ForgotPasswordNetApi *forgotPasswordRequest = (HP_ForgotPasswordNetApi *)request;
        if ([forgotPasswordRequest getCodeStatus] == 1) {
            [UserCache setUserPhone:self.phoneTextField.text];
            [UserCache setUserPass:self.passwordTextField.text];
            if (self.isSetPas) {
                 [UserCache setUserPassword:@"1"];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        [WXZTipView showCenterWithText:[forgotPasswordRequest getMsg]];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_ForgotPasswordNetApi *forgotPasswordRequest = (HP_ForgotPasswordNetApi *)request;
        [WXZTipView showCenterWithText:[forgotPasswordRequest getMsg]];
    }];
     
     */
}
#pragma mark ===懒加载===
-(UITextField *)phoneTextField{
    if (!_phoneTextField) {
        UITextField *tf = [[UITextField alloc] init];
            //        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.placeholder = @"请输入手机号";
        [tf setValue:HEX_COLOR(0xAAAAAA) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x000000);
        tf.font = [UIFont systemFontOfSize:HeightRatio(30)];
        tf.backgroundColor = [UIColor clearColor];
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(94), HeightRatio(85))];
        lv.backgroundColor = [UIColor clearColor];
        
        UILabel *segmentLabel  = [UILabel new];
        segmentLabel.text = @"+86";
        segmentLabel.textColor = HEX_COLOR(0x000000);
        segmentLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
        [lv addSubview:segmentLabel];
        [segmentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lv.mas_left);
            make.centerY.mas_equalTo(lv.mas_centerY);
            make.height.mas_equalTo(HeightRatio(26));
            make.width.mas_greaterThanOrEqualTo(1);
        }];
        
        UILabel *verticalLabel = [UILabel new];
        verticalLabel.backgroundColor = HEX_COLOR(0x000000);
        [lv addSubview:verticalLabel];
        [verticalLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lv.mas_left).offset(WidthRatio(65));
            make.centerY.mas_equalTo(lv.mas_centerY);
            make.height.mas_equalTo(HeightRatio(28));
            make.width.mas_equalTo(WidthRatio(3));
        }];
        
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = lv;
        [tf sizeToFit];
        
        UILabel *lin = [UILabel new];
        lin.backgroundColor = HEX_COLOR(0xDDDDDD);
        [tf addSubview:lin];
        [lin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(tf);
            make.height.mas_equalTo(HeightRatio(1));
        }];
        [self.view addSubview:tf];
        _phoneTextField = tf;
    }
    return _phoneTextField;
}
-(UITextField *)getTextFieldPlaceholder:(NSString *)placeholder imageName:(NSString *)imageName{
    UITextField *tf = [[UITextField alloc] init];
    tf.keyboardType = UIKeyboardTypeTwitter;
    tf.placeholder = placeholder;
    [tf setValue:HEX_COLOR(0xAAAAAA) forKeyPath:@"_placeholderLabel.textColor"];
    tf.textColor = HEX_COLOR(0x5b5b5b);
    tf.font = [UIFont systemFontOfSize:HeightRatio(30)];
    tf.backgroundColor = [UIColor clearColor];
    
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(63), HeightRatio(85))];
    lv.backgroundColor = [UIColor clearColor];
    
    UIImageView *iconImageView = [UIImageView new];
    iconImageView.image = MMGetImage(imageName);
    [lv addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lv.mas_left).offset(WidthRatio(7));
        make.centerY.mas_equalTo(lv.mas_centerY);
        make.width.mas_equalTo(WidthRatio(28));
        make.height.mas_equalTo(HeightRatio(31));
    }];
    
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.leftView = lv;
    [tf sizeToFit];
    
    UILabel *lin = [UILabel new];
    lin.backgroundColor = HEX_COLOR(0xDDDDDD);
    [tf addSubview:lin];
    [lin mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(tf);
        make.height.mas_equalTo(HeightRatio(1));
    }];
    [self.view addSubview:tf];
    return tf;
}
-(UITextField *)verificationCodeTextField{
    if (_verificationCodeTextField == nil) {
        UITextField *tf = [[UITextField alloc] init];
            //        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.keyboardType = UIKeyboardTypeTwitter;
        tf.placeholder = @"请输入验证码";
        [tf setValue:HEX_COLOR(0xAAAAAA) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x5b5b5b);
        tf.font = [UIFont systemFontOfSize:HeightRatio(30)];
        tf.backgroundColor = [UIColor clearColor];
        
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(63), HeightRatio(85))];
        lv.backgroundColor = [UIColor clearColor];
        
        UIImageView *iconImageView = [UIImageView new];
        iconImageView.image = MMGetImage(@"security");
        [lv addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lv.mas_left).offset(WidthRatio(7));
            make.centerY.mas_equalTo(lv.mas_centerY);
            make.width.mas_equalTo(WidthRatio(28));
            make.height.mas_equalTo(HeightRatio(31));
        }];
        
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = lv;
        [tf sizeToFit];
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(150), HeightRatio(85))];
        rightView.backgroundColor = [UIColor clearColor];
        UIButton *codeButton = [UIButton new];
        codeButton.titleLabel.font =[UIFont systemFontOfSize:WidthRatio(30)];
        [codeButton addTarget:self action:@selector(getLoginCode:) forControlEvents:(UIControlEventTouchUpInside)];
        [codeButton setTitleColor:HEX_COLOR(0x666666) forState:(UIControlStateNormal)];
        [codeButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        [rightView addSubview:codeButton];
        [codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rightView.mas_right);
            make.top.bottom.mas_equalTo(rightView);
            make.width.mas_greaterThanOrEqualTo(1);
        }];
        tf.rightViewMode = UITextFieldViewModeAlways;
        tf.rightView = rightView;
        
        
        UILabel *lin = [UILabel new];
        lin.backgroundColor = HEX_COLOR(0xDDDDDD);
        [tf addSubview:lin];
        [lin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(tf);
            make.height.mas_equalTo(HeightRatio(1));
        }];
        [self.view addSubview:tf];
        _verificationCodeTextField = tf;
    }
    return _verificationCodeTextField;
}
@end
