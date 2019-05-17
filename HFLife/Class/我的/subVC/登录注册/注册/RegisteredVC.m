//
//  LoginForVercode.m
//  HFLife
//
//  Created by mac on 2019/5/16.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "LoginForVercode.h"
#import <ShareSDK/ShareSDK.h>
//VC
#import "RegisteredVC.h"
#import "ForgotPasswordVC.h"
#import "ReviseMobilePhone.h"//设置手机号

@interface RegisteredVC ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *userName;
@property (nonatomic,strong)UITextField *vercodeText;
@property (nonatomic,strong)UITextField *inviteCodeTextField;

@end

@implementation RegisteredVC

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
    self.customNavBar.title = @"";
    self.customNavBar.titleLabelColor = [UIColor clearColor];
    self.customNavBar.backgroundColor = [UIColor clearColor];
}
-(void)initWithUI{
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.image = MMGetImage(@"log_bg");
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    UIView *view = [[UIView alloc] init];
    [bgImageView addSubview:view];
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(bgImageView);
    }];
    
    
    UIImageView *iconImageView = [UIImageView new];
    iconImageView.image = MMGetImage(@"icon_phone_login");
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(ScreenScale(117));
        make.width.mas_equalTo(ScreenScale(100));
        make.height.mas_equalTo(ScreenScale(100));
        
    }];
    
    UIView *subBgView = [UIView new];
    subBgView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    subBgView.layer.cornerRadius = 12;
    [self.view addSubview:subBgView];
    
    [self.view addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(99));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(92));
        make.height.mas_equalTo(HeightRatio(82));
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(HeightRatio(52));
    }];
    [self.view addSubview:self.vercodeText];
    [self.vercodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(99));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(92));
        make.height.mas_equalTo(HeightRatio(82));
        make.top.mas_equalTo(self.userName.mas_bottom).offset(HeightRatio(26));
    }];
    
    [self.view addSubview:self.inviteCodeTextField];
    [self.inviteCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(99));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(92));
        make.height.mas_equalTo(HeightRatio(82));
        make.top.mas_equalTo(self.vercodeText.mas_bottom).offset(HeightRatio(26));
    }];
    
    
    [subBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userName).mas_offset(-10);
        make.left.mas_equalTo(self.view).mas_offset(12);
        make.right.mas_equalTo(self.view).mas_offset(-12);
        make.bottom.mas_equalTo(self.view).mas_offset(-27);
    }];
    
    //    UIButton *forgotPasswordBtn = [UIButton new];
    //    forgotPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(23)];
    //    [forgotPasswordBtn setTitle:@"忘记密码 ？" forState:(UIControlStateNormal)];
    //    [forgotPasswordBtn setTitleColor:HEX_COLOR(0x656565) forState:(UIControlStateNormal)];
    //    [forgotPasswordBtn addTarget:self action:@selector(forgotPasswordBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    //    [self.view addSubview:forgotPasswordBtn];
    //    [forgotPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(self.userName.mas_left);
    //        make.top.mas_equalTo(self.vercodeText.mas_bottom).offset(HeightRatio(45));
    //        make.width.mas_greaterThanOrEqualTo(1);
    //        make.height.mas_equalTo(HeightRatio(23));
    //    }];
    //
    //    UIButton *registeredBtn = [UIButton new];
    //    registeredBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(23)];
    //    [registeredBtn setTitle:@"还没有账号，去注册" forState:(UIControlStateNormal)];
    //    [registeredBtn setTitleColor:HEX_COLOR(0x656565) forState:(UIControlStateNormal)];
    //    [registeredBtn addTarget:self action:@selector(registeredClick) forControlEvents:(UIControlEventTouchUpInside)];
    //    [self.view addSubview:registeredBtn];
    //    [registeredBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.mas_equalTo(self.userName.mas_right);
    //        make.top.mas_equalTo(self.vercodeText.mas_bottom).offset(HeightRatio(45));
    //        make.width.mas_greaterThanOrEqualTo(1);
    //        make.height.mas_equalTo(HeightRatio(23));
    //    }];
    
    UIButton *loginBtn = [UIButton new];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(31)];
    loginBtn.backgroundColor = [UIColor redColor];
    [loginBtn setTitle:@"注册" forState:(UIControlStateNormal)];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [loginBtn addTarget:self action:@selector(reginBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(ScreenScale(40));
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-ScreenScale(40));
        make.top.mas_equalTo(self.inviteCodeTextField.mas_bottom).offset(ScreenScale(40));
        make.height.mas_equalTo(HeightRatio(90));
    }];
    MMViewBorderRadius(loginBtn, WidthRatio(45), 0, [UIColor clearColor]);
    
    //    UILabel *lin = [UILabel new];
    //    lin.backgroundColor = HEX_COLOR(0xdddddd);
    //    [self.view addSubview:lin];
    //    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(self.userName.mas_left);
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

-(UITextField *)userName{
    if (_userName == nil) {
        UITextField *tf = [[UITextField alloc] init];
        //        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.keyboardType = UIKeyboardTypeTwitter;
        tf.placeholder = @"请输入手机号/用户名";
        [tf setValue:HEX_COLOR(0xAAAAAA) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x5b5b5b);
        tf.font = [UIFont systemFontOfSize:HeightRatio(32)];
        tf.backgroundColor = [UIColor clearColor];
        tf.clearButtonMode = UITextFieldViewModeAlways;
        tf.delegate = self;
        
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenScale(30), ScreenScale(24))];
        lv.backgroundColor = [UIColor clearColor];
        
        UIImageView *iconImageView = [UIImageView new];
        iconImageView.image = MMGetImage(@"icon_user");
        [lv addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lv.mas_left);
            make.centerY.mas_equalTo(lv.mas_centerY);
            make.width.mas_equalTo(ScreenScale(24));
            make.height.mas_equalTo(ScreenScale(24));
        }];
        
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = lv;
        [tf sizeToFit];
        
        
        
        UILabel *lin = [UILabel new];
        lin.backgroundColor = HEX_COLOR(0xdddddd);
        [tf addSubview:lin];
        [lin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(tf);
            make.height.mas_equalTo(HeightRatio(3));
        }];
        [self.view addSubview:tf];
        _userName = tf;
    }
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenScale(20), HeightRatio(69))];
    rightView.backgroundColor = [UIColor clearColor];
    UIButton *clearnButton = [UIButton new];
    [clearnButton setImage:[UIImage imageNamed:@"icon_clear"] forState:UIControlStateNormal];
    [clearnButton wh_addActionHandler:^{
        self->_userName.text = @"";
    }];
    [rightView addSubview:clearnButton];
    [clearnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(rightView);
        make.top.bottom.mas_equalTo(rightView);
    }];
    _userName.rightViewMode = UITextFieldViewModeAlways;
    _userName.rightView = rightView;
    return _userName;
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
        
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenScale(30), ScreenScale(24))];
        lv.backgroundColor = [UIColor clearColor];
        
        UIImageView *iconImageView = [UIImageView new];
        iconImageView.image = MMGetImage(@"icon_mima");
        [lv addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lv.mas_left);
            make.centerY.mas_equalTo(lv.mas_centerY);
            make.width.mas_equalTo(ScreenScale(21));
            make.height.mas_equalTo(ScreenScale(24));
        }];
        
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = lv;
        [tf sizeToFit];
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(120), HeightRatio(69))];
        rightView.backgroundColor = [UIColor clearColor];
        UIButton *codeButton = [UIButton new];
        codeButton.titleLabel.font =[UIFont systemFontOfSize:WidthRatio(24)];
        [codeButton addTarget:self action:@selector(getRegistCode:) forControlEvents:(UIControlEventTouchUpInside)];
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
        lin.backgroundColor = HEX_COLOR(0xdddddd);
        [tf addSubview:lin];
        [lin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(tf);
            make.height.mas_equalTo(HeightRatio(3));
        }];
        [self.view addSubview:tf];
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
        
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenScale(30), ScreenScale(24))];
        lv.backgroundColor = [UIColor clearColor];
        
        UIImageView *iconImageView = [UIImageView new];
        iconImageView.image = MMGetImage(@"icon_invite");
        [lv addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lv.mas_left);
            make.centerY.mas_equalTo(lv.mas_centerY);
            make.width.mas_equalTo(ScreenScale(24));
            make.height.mas_equalTo(ScreenScale(25));
        }];
        
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = lv;
        [tf sizeToFit];
        
        UILabel *lin = [UILabel new];
        lin.backgroundColor = HEX_COLOR(0xdddddd);
        [tf addSubview:lin];
        [lin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(tf);
            make.height.mas_equalTo(HeightRatio(3));
        }];
        [self.view addSubview:tf];
        _inviteCodeTextField = tf;
    }
    _inviteCodeTextField.rightView = [UIView new];
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

-(void)getRegistCode:(UIButton *)send{
    if (![self.userName.text isValidateMobile]) {
        [WXZTipView showCenterWithText:@"请输入正确的手机号"];
        return;
    }
//    if ([NSString isNOTNull:self.inviteCodeTextField.text]) {
//        [WXZTipView showCenterWithText:@"邀请码不能为空"];
//        return;
//    }
    
//    [self openCountdown:send];
    [[WBPCreate sharedInstance] showWBProgress];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kSendsms withParameters:@{@"mobile":self.userName.text,@"event":@"register"} withResultBlock:^(BOOL result, id value) {
        [[WBPCreate sharedInstance] hideAnimated];
        if (result) {
            [WXZTipView showCenterWithText:@"短信验证码已发送"];
            [self openCountdown:send];
        }else {
            [WXZTipView showCenterWithText:value[@"msg"]];
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
-(void)reginBtnClick{
    if ([NSString isNOTNull:self.userName.text]) {
        [WXZTipView showCenterWithText:@"请输入用户名"];
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
    
    [[WBPCreate sharedInstance] showWBProgress];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kRegisterMobile withParameters:@{@"member_mobile":self.userName.text,@"captcha":self.vercodeText.text,@"invite_code":self.inviteCodeTextField.text ? self.inviteCodeTextField.text : @""} withResultBlock:^(BOOL result, id value) {
        [[WBPCreate sharedInstance] hideAnimated];
        if (result) {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = value;
                
                NSDictionary *dataDic = dict[@"data"];
                if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                    [[NSUserDefaults standardUserDefaults] setValue:dataDic[@"ucenter_token"] forKey:USER_TOKEN];
                    [UserCache setUserPhone:self.userName.text];
                    //                [UserCache setUserPass:self.vercodeText.text];
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }
                
            }
            
        }else {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }
        }
    }];
    
    /*
     
     
     HP_LoginNetApi *loginNetApi  = [[HP_LoginNetApi alloc]initWithParameter:@{@"account":self.userName.text,@"password":self.vercodeText.text}];
     [loginNetApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
     HP_LoginNetApi *loginRequest = (HP_LoginNetApi *)request;
     if ([loginRequest getCodeStatus] == 1) {
     NSDictionary *dict = [loginRequest getContent];
     [HeaderToken setToken:dict[@"token"]];
     [CommonTools setToken:dict[@"token"]];
     [UserCache setUserPhone:self.userName.text];
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
    [self.navigationController pushViewController:[[ForgotPasswordVC alloc]init] animated:YES];
}

#pragma mark - textFiledDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _userName) {
        if (self.userName) {
            
        }
    }
    if (textField == _inviteCodeTextField) {
        if (self.inviteCodeTextField) {
            
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _userName) {
        
        [networkingManagerTool requestToServerWithType:POST withSubUrl:kCheckMobile withParameters:@{@"member_mobile":textField.text} withResultBlock:^(BOOL result, id value) {
            if (result) {
                
            }else {
                
                if (value && [value isKindOfClass:[NSDictionary class]]) {
                    [self setRightView:textField string:@"该用户已存在"];
                }else {
                    [self setRightView:textField string:@"校验接口错误"];
                }
            }
        }];
    }
    if (textField == _inviteCodeTextField) {
        [networkingManagerTool requestToServerWithType:POST withSubUrl:kCheckInviteCode withParameters:@{@"invite_code":textField.text} withResultBlock:^(BOOL result, id value) {
            if (result) {
                
            }else {
                [self setRightView:textField string:@"邀请码错误"];
            }
        }];
    }

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
