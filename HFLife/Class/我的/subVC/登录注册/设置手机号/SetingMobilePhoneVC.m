//
//  SetingMobilePhoneVC.m
//  HFLife
//
//  Created by mac on 2019/5/16.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SetingMobilePhoneVC.h"

@interface SetingMobilePhoneVC ()<UITextFieldDelegate>
@property(nonatomic, strong) UITextField *phoneText;
@property (nonatomic,strong)UITextField *vercodeText;
@property (nonatomic,strong)UITextField *inviteCodeTextField;

@end

@implementation SetingMobilePhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithUI];
    [self setupNavBar];
    // Do any additional setup after loading the view.
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
    self.customNavBar.title = @"绑定手机号";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initWithUI{
   
    
    UILabel *lin = [UILabel new];
    lin.backgroundColor = HEX_COLOR(0xF5F5F5);
    [self.view addSubview:lin];
    [lin mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(12);
        make.right.mas_equalTo(self.view.mas_right).offset(-12);
        make.top.mas_equalTo(self.view).mas_offset(self.navBarHeight + 1);
        make.height.mas_equalTo(1);
    }];
    [self.view addSubview:self.phoneText];
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(12);
        make.right.mas_equalTo(self.view.mas_right).offset(-12);
        make.height.mas_equalTo(HeightRatio(82));
        make.top.mas_equalTo(self.view).offset(self.navBarHeight + HeightRatio(26));
    }];
    [self.view addSubview:self.vercodeText];
    [self.vercodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(12);
        make.right.mas_equalTo(self.view.mas_right).offset(-12);
        make.height.mas_equalTo(HeightRatio(82));
        make.top.mas_equalTo(self.phoneText.mas_bottom).offset(HeightRatio(26));
    }];
    
    [self.view addSubview:self.inviteCodeTextField];
    [self.inviteCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(12);
        make.right.mas_equalTo(self.view.mas_right).offset(-12);
        make.height.mas_equalTo(HeightRatio(82));
        make.top.mas_equalTo(self.vercodeText.mas_bottom).offset(HeightRatio(26));
    }];
    
    UIButton *sureBtn = [UIButton new];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(31)];
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(ScreenScale(12));
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-ScreenScale(12));
        make.top.mas_equalTo(self.inviteCodeTextField.mas_bottom).offset(ScreenScale(40));
        make.height.mas_equalTo(HeightRatio(90));
    }];
    MMViewBorderRadius(sureBtn, WidthRatio(10), 0, [UIColor clearColor]);
    
    //    UILabel *lin = [UILabel new];
    //    lin.backgroundColor = HEX_COLOR(0xdddddd);
    //    [self.view addSubview:lin];
    //    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(self.phoneText.mas_left);
    //        make.top.mas_equalTo(loginBtn.mas_bottom).offset(HeightRatio(97));
    //        make.width.mas_equalTo(WidthRatio(194));
    //        make.height.mas_equalTo(HeightRatio(3));
    //    }];
    
    //    UILabel *la =[UILabel new];
    //    la.text = @"第三方登录";
    //    la.font = [UIFont systemFontOfSize:WidthRatio(21)];
    //    la.textColor = HEX_COLOR(0x828282);
    //    [self.view addSubview:la];
    //    [la mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.mas_equalTo(self.view.mas_centerX);
    //        make.centerY.mas_equalTo(lin.mas_centerY);
    //        make.width.mas_greaterThanOrEqualTo(1);
    //        make.height.mas_equalTo(HeightRatio(21));
    //    }];
    //
    //    UILabel *lin2 = [UILabel new];
    //    lin2.backgroundColor = HEX_COLOR(0xdddddd);
    //    [self.view addSubview:lin2];
    //    [lin2 mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(la.mas_right).offset(WidthRatio(33));
    //        make.centerY.mas_equalTo(lin.mas_centerY);
    //        make.width.mas_equalTo(WidthRatio(194));
    //        make.height.mas_equalTo(HeightRatio(3));
    //    }];
    //
    //    UIButton *QQBtn = [UIButton new];
    //    QQBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(25)];
    //    [QQBtn setImage:MMGetImage(@"QQ") forState:(UIControlStateNormal)];
    //    [QQBtn setTitle:@"QQ登录" forState:(UIControlStateNormal)];
    //    [QQBtn setTitleColor:HEX_COLOR(0x828282) forState:(UIControlStateNormal)];
    //    [QQBtn setImagePosition:ImagePositionTypeLeft spacing:ScreenScale(15)];
    //
    //    [QQBtn addTarget:self action:@selector(loginWithQQ) forControlEvents:(UIControlEventTouchUpInside)];
    //    [self.view addSubview:QQBtn];
    //    [QQBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(162));
    //        make.top.mas_equalTo(la.mas_bottom).offset(HeightRatio(54));
    //        make.width.mas_equalTo(WidthRatio(153));
    //        make.height.mas_equalTo(HeightRatio(57));
    //    }];
    //
    //    UIButton *WeChatBtn = [UIButton new];
    //    WeChatBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(25)];
    //    [WeChatBtn setImage:MMGetImage(@"weixin") forState:(UIControlStateNormal)];
    //    [WeChatBtn setTitle:@"微信登录" forState:(UIControlStateNormal)];
    //    [WeChatBtn setTitleColor:HEX_COLOR(0x828282) forState:(UIControlStateNormal)];
    //    [WeChatBtn setImagePosition:ImagePositionTypeLeft spacing:ScreenScale(15)];
    //
    //    [WeChatBtn addTarget:self action:@selector(loginWithWeChat) forControlEvents:(UIControlEventTouchUpInside)];
    //    [self.view addSubview:WeChatBtn];
    //    [WeChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(150));
    //        make.top.mas_equalTo(la.mas_bottom).offset(HeightRatio(54));
    //        make.width.mas_equalTo(WidthRatio(188));
    //        make.height.mas_equalTo(HeightRatio(57));
    //    }];
    
    //    lin.hidden = YES;
    //    la.hidden = YES;
    //    lin2.hidden = YES;
    //    QQBtn.hidden = YES;
    //    WeChatBtn.hidden = YES;
}

-(UITextField *)phoneText{
    if (_phoneText == nil) {
        UITextField *tf = [[UITextField alloc] init];
        //        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.keyboardType = UIKeyboardTypeTwitter;
        tf.placeholder = @"请输入手机号(+86)";
        [tf setValue:HEX_COLOR(0xAAAAAA) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x5b5b5b);
        tf.font = [UIFont systemFontOfSize:HeightRatio(32)];
        tf.backgroundColor = [UIColor clearColor];
        tf.clearButtonMode = UITextFieldViewModeAlways;
        tf.delegate = self;
        
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenScale(12), ScreenScale(24))];
        lv.backgroundColor = [UIColor clearColor];
        
//        UIImageView *iconImageView = [UIImageView new];
//        iconImageView.image = MMGetImage(@"icon_user");
//        [lv addSubview:iconImageView];
//        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(lv.mas_left);
//            make.centerY.mas_equalTo(lv.mas_centerY);
//            make.width.mas_equalTo(ScreenScale(24));
//            make.height.mas_equalTo(ScreenScale(24));
//        }];
        
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = lv;
        [tf sizeToFit];
        
        
        
        UILabel *lin = [UILabel new];
        lin.backgroundColor = HEX_COLOR(0xF5F5F5);
        [tf addSubview:lin];
        [lin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(tf);
            make.height.mas_equalTo(1);
        }];
        [self.view addSubview:tf];
        _phoneText = tf;
    }
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenScale(20), HeightRatio(69))];
    rightView.backgroundColor = [UIColor clearColor];
    UIButton *clearnButton = [UIButton new];
    [clearnButton setImage:[UIImage imageNamed:@"icon_clear"] forState:UIControlStateNormal];
    [clearnButton wh_addActionHandler:^{
        self->_phoneText.text = @"";
    }];
    [rightView addSubview:clearnButton];
    [clearnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(rightView);
        make.top.bottom.mas_equalTo(rightView);
    }];
    _phoneText.rightView = rightView;
    _phoneText.rightViewMode = UITextFieldViewModeAlways;
    return _phoneText;
}
-(UITextField *)vercodeText{
    if (!_vercodeText) {
        UITextField *tf = [[UITextField alloc] init];
        //        tf.keyboardType = UIKeyboardTypeASCIICapable;
        tf.keyboardType = UIKeyboardTypeTwitter;
        tf.placeholder = @"请输入验证码";
        [tf setValue:HEX_COLOR(0xAAAAAA) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x5b5b5b);
        //        tf.secureTextEntry = YES;
        tf.font = [UIFont systemFontOfSize:HeightRatio(32)];
        tf.backgroundColor = [UIColor clearColor];
        
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenScale(12), ScreenScale(24))];
        lv.backgroundColor = [UIColor clearColor];
        
//        UIImageView *iconImageView = [UIImageView new];
//        iconImageView.image = MMGetImage(@"icon_mima");
//        [lv addSubview:iconImageView];
//        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(lv.mas_left);
//            make.centerY.mas_equalTo(lv.mas_centerY);
//            make.width.mas_equalTo(ScreenScale(21));
//            make.height.mas_equalTo(ScreenScale(24));
//        }];
        
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = lv;
        [tf sizeToFit];
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(120), HeightRatio(69))];
        rightView.backgroundColor = [UIColor clearColor];
        UIButton *codeButton = [UIButton new];
        codeButton.titleLabel.font =[UIFont systemFontOfSize:WidthRatio(24)];
        [codeButton addTarget:self action:@selector(getSetingCode:) forControlEvents:(UIControlEventTouchUpInside)];
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
        lin.backgroundColor = HEX_COLOR(0xF5F5F5);
        [tf addSubview:lin];
        [lin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(tf);
            make.height.mas_equalTo(1);
        }];
        [self.view addSubview:tf];
        _vercodeText = tf;
    }
    return _vercodeText;
}

-(UITextField *)inviteCodeTextField{
    if (!_inviteCodeTextField) {
        UITextField *tf = [[UITextField alloc] init];
        //        tf.keyboardType = UIKeyboardTypeASCIICapable;
        tf.keyboardType = UIKeyboardTypeTwitter;
        tf.placeholder = @"请输入邀请码";
        [tf setValue:HEX_COLOR(0xAAAAAA) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x5b5b5b);
        //        tf.secureTextEntry = YES;
        tf.font = [UIFont systemFontOfSize:HeightRatio(32)];
        tf.backgroundColor = [UIColor clearColor];
        tf.delegate = self;
        
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenScale(12), ScreenScale(24))];
        lv.backgroundColor = [UIColor clearColor];
        
//        UIImageView *iconImageView = [UIImageView new];
//        iconImageView.image = MMGetImage(@"icon_invite");
//        [lv addSubview:iconImageView];
//        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(lv.mas_left);
//            make.centerY.mas_equalTo(lv.mas_centerY);
//            make.width.mas_equalTo(ScreenScale(24));
//            make.height.mas_equalTo(ScreenScale(25));
//        }];
        
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = lv;
        [tf sizeToFit];
        
        UILabel *lin = [UILabel new];
        lin.backgroundColor = HEX_COLOR(0xF5F5F5);
        [tf addSubview:lin];
        [lin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(tf);
            make.height.mas_equalTo(1);
        }];
        [self.view addSubview:tf];
        _inviteCodeTextField = tf;
    }
    _inviteCodeTextField.rightView = [UIView new];
    _inviteCodeTextField.rightViewMode = UITextFieldViewModeAlways;

    return _inviteCodeTextField;
}

// !!!: 设置错误的信息(手机号已注册,邀请码错误)
- (void)setRightView:(UITextField *)tf string:(NSString *)title{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(120), HeightRatio(69))];
    rightView.backgroundColor = [UIColor clearColor];
    UIButton *titleButton = [UIButton new];
    titleButton.titleLabel.font =[UIFont systemFontOfSize:WidthRatio(24)];
    [titleButton setTitleColor:HEX_COLOR(0xCA1400) forState:(UIControlStateNormal)];
    [titleButton setTitle:title forState:(UIControlStateNormal)];
    [rightView addSubview:titleButton];
    [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightView.mas_right);
        make.top.bottom.mas_equalTo(rightView);
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    tf.rightView = rightView;
}

-(void)getSetingCode:(UIButton *)send{
    if (![self.phoneText.text isValidateMobile]) {
        [WXZTipView showCenterWithText:@"请输入正确的手机号"];
        return;
    }
    //    if ([NSString isNOTNull:self.inviteCodeTextField.text]) {
    //        [WXZTipView showCenterWithText:@"邀请码不能为空"];
    //        return;
    //    }
    
    //    [self openCountdown:send];
    [[WBPCreate sharedInstance] showWBProgress];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kSendsms withParameters:@{@"mobile":self.phoneText.text,@"event":@"wx_bind_mobile"} withResultBlock:^(BOOL result, id value) {
        [[WBPCreate sharedInstance] hideAnimated];
        if (result) {
            [WXZTipView showCenterWithText:@"短信验证码已发送"];
            [self openCountdown:send];
        }else {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络错误"];
            }
        }
    }];
    
    
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
                [authCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [authCodeBtn setTitleColor:HEX_COLOR(0x666666) forState:UIControlStateNormal];
                authCodeBtn.userInteractionEnabled = YES;
                //                self.userPhoneTextField.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [authCodeBtn setTitle:[NSString stringWithFormat:@"%.2ds后重新获取", seconds] forState:UIControlStateNormal];
                [authCodeBtn setTitleColor:HEX_COLOR(0xCA1400) forState:UIControlStateNormal];
                authCodeBtn.userInteractionEnabled = NO;
                //                self.userPhoneTextField.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
-(void)sureBtnClick{
    if ([NSString isNOTNull:self.phoneText.text]) {
        [WXZTipView showCenterWithText:@"请输入手机号"];
        return;
    }
    if ([NSString isNOTNull:self.vercodeText.text]) {
        [WXZTipView showCenterWithText:@"请输入验证码"];
        return;
    }
//    if ([NSString isNOTNull:self.inviteCodeTextField.text]) {
//        [WXZTipView showCenterWithText:@"邀请码不能为空"];
//        return;
//    }
    NSString *subUrl;
    if (self.loginType == LoginTypeWeiXin) {
        subUrl = kWxBindmobile;
    }
    
    [[WBPCreate sharedInstance] showWBProgress];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:subUrl withParameters:@{@"member_mobile":self.phoneText.text,@"captcha":self.vercodeText.text,@"invite_code":self.inviteCodeTextField.text ? self.inviteCodeTextField.text : @"",@"openid":self.openIdStr} withResultBlock:^(BOOL result, id value) {
    [[WBPCreate sharedInstance] hideAnimated];
        if (result) {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = value;
                NSDictionary *dataDic = [dict safeObjectForKey:@"data"];
                
                NSString *token = [dataDic safeObjectForKey:@"ucenter_token"];
                
                if (token && [token isKindOfClass:[NSString class]] && token.length > 0) {
                    [[NSUserDefaults standardUserDefaults] setValue:token forKey:USER_TOKEN];
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }else {
                    [WXZTipView showCenterWithText:@"token获取错误"];
                }
            }

        }else {
            if ((value && [value isKindOfClass:[NSDictionary class]])) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络错误"];
            }
        }
    }];

    /*
     
     
     HP_LoginNetApi *loginNetApi  = [[HP_LoginNetApi alloc]initWithParameter:@{@"account":self.phoneText.text,@"password":self.vercodeText.text}];
     [loginNetApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
     HP_LoginNetApi *loginRequest = (HP_LoginNetApi *)request;
     if ([loginRequest getCodeStatus] == 1) {
     NSDictionary *dict = [loginRequest getContent];
     [HeaderToken setToken:dict[@"token"]];
     [CommonTools setToken:dict[@"token"]];
     [UserCache setUserPhone:self.phoneText.text];
     [UserCache setUserPass:self.vercodeText.text];
     [self.navigationController popToRootViewControllerAnimated:YES];
     }else{
     [WXZTipView showCenterWithText:[loginRequest getMsg]];
     }
     } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
     HP_LoginNetApi *loginRequest = (HP_LoginNetApi *)request;
     [WXZTipView showCenterWithText:[loginRequest getMsg]];
     }];
     
     
     */
}

-(void)forgotPasswordBtnClick{
    
}

#pragma mark - textFiledDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _phoneText) {
        if (self.phoneText) {
            
        }
    }
    if (textField == _inviteCodeTextField) {
        if (self.inviteCodeTextField) {
            
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _phoneText) {
        
        [networkingManagerTool requestToServerWithType:POST withSubUrl:kCheckMobile withParameters:@{@"member_mobile":textField.text} withResultBlock:^(BOOL result, id value) {
            if (result) {

            }else {
                if (value && [value isKindOfClass:[NSDictionary class]]) {
                    [self setRightView:textField string:@"该用户已存在"];
                }else {
                    if (self.phoneText) {}
                }
            }
        }];
    }
    if (textField == _inviteCodeTextField && _inviteCodeTextField.text.length > 0) {
        [networkingManagerTool requestToServerWithType:POST withSubUrl:kCheckInviteCode withParameters:@{@"invite_code":textField.text} withResultBlock:^(BOOL result, id value) {
            if (result) {
                
            }else {
                [self setRightView:textField string:@"邀请码错误"];
            }
        }];
    }
    
}


@end
