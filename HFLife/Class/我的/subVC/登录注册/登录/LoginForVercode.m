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
#import "JMConfig.h"
#import "JMTabBarController.h"
@interface LoginForVercode ()
@property (nonatomic,strong)UITextField *userName;//手机号
@property (nonatomic,strong)UITextField *vercodeText;//验证码
@end

@implementation LoginForVercode

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
    
    [subBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userName).mas_offset(-10);
        make.left.mas_equalTo(self.view).mas_offset(12);
        make.right.mas_equalTo(self.view).mas_offset(-12);
        make.bottom.mas_equalTo(self.view).mas_offset(-27);
    }];
    
    self.userName.text = @"15621402093";
    
    UIButton *loginBtn = [UIButton new];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(31)];
    loginBtn.backgroundColor = [UIColor redColor];
    [loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(ScreenScale(40));
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-ScreenScale(40));
        make.top.mas_equalTo(self.vercodeText.mas_bottom).offset(ScreenScale(100));
        make.height.mas_equalTo(HeightRatio(90));
    }];
    MMViewBorderRadius(loginBtn, WidthRatio(45), 0, [UIColor clearColor]);
}

-(UITextField *)userName{
    if (_userName == nil) {
        UITextField *tf = [[UITextField alloc] init];
        //        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.keyboardType = UIKeyboardTypeTwitter;
        tf.placeholder = @"请输入手机号";
        [tf setValue:HEX_COLOR(0xAAAAAA) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x5b5b5b);
        tf.font = [UIFont systemFontOfSize:HeightRatio(32)];
        tf.backgroundColor = [UIColor clearColor];
        tf.clearButtonMode = UITextFieldViewModeAlways;
        
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
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenScale(20), HeightRatio(69))];
        rightView.backgroundColor = [UIColor clearColor];
        UIButton *clearnButton = [UIButton new];
        [clearnButton setImage:[UIImage imageNamed:@"icon_clear"] forState:UIControlStateNormal];
        [clearnButton wh_addActionHandler:^{
            tf.text = @"";
        }];
        [rightView addSubview:clearnButton];
        [clearnButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(rightView);
            make.top.bottom.mas_equalTo(rightView);
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
        _userName = tf;
    }
    return _userName;
}
-(UITextField *)vercodeText{
    if (!_vercodeText) {
        UITextField *tf = [[UITextField alloc] init];
        //        tf.keyboardType = UIKeyboardTypeASCIICapable;
        tf.keyboardType = UIKeyboardTypeTwitter;
        tf.placeholder = @"请输入验证码";
        tf.keyboardType = UIKeyboardTypeNumberPad;
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
        [codeButton addTarget:self action:@selector(getLoginCode:) forControlEvents:(UIControlEventTouchUpInside)];
        [codeButton setTitleColor:HEX_COLOR(0x666666) forState:(UIControlStateNormal)];
        [codeButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
       
        [rightView addSubview:codeButton];
        
        [codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rightView.mas_right);
            make.top.bottom.mas_equalTo(rightView);
            make.width.mas_equalTo(ScreenScale(120));
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
        _vercodeText = tf;
    }
    return _vercodeText;
}

-(void)getLoginCode:(UIButton *)send{
    if (![self.userName.text isValidateMobile]) {
        [WXZTipView showCenterWithText:@"请输入正确的手机号"];
        return;
    }

    
    
    //@{@"mobile":self.userName.text,@"event":@"mobilelogin"}
    [[WBPCreate sharedInstance] showWBProgress];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kSendsms withParameters:@{@"mobile":self.userName.text,@"event":@"mobilelogin"} withResultBlock:^(BOOL result, id value) {
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
//手机验证码登录
-(void)loginBtnClick{
    if ([NSString isNOTNull:self.userName.text]) {
        [WXZTipView showCenterWithText:@"请输入用户名"];
        return;
    }
    if ([NSString isNOTNull:self.vercodeText.text]) {
        [WXZTipView showCenterWithText:@"请输入验证码"];
        return;
    }

    [[WBPCreate sharedInstance] showWBProgress];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kMobileLogin withParameters:@{@"member_mobile":self.userName.text,@"captcha":self.vercodeText.text} withResultBlock:^(BOOL result, id value) {
        [[WBPCreate sharedInstance] hideAnimated];
        if (result) {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = value;
                
                NSDictionary *dataDic = dict[@"data"];
                
                if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                    NSString *token = dataDic[@"ucenter_token"];
                    if (token && [token isKindOfClass:[NSString class]] && token.length > 0) {
                        [[NSUserDefaults standardUserDefaults] setValue:dataDic[@"ucenter_token"] forKey:USER_TOKEN];
                        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:LOGIN_STATES];
                        NSLog(@"%@", [USERDEFAULT valueForKey:LOGIN_STATES]);
                        [LoginVC changeIndxHome];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }else {
                        [WXZTipView showCenterWithText:@"未请求到token"];
                    }
                }
            }
            
        }else {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络错误"];
            }
        }
    }];
}


-(void)registeredClick{
    [self.navigationController pushViewController:[[RegisteredVC alloc]init] animated:YES];
}
-(void)forgotPasswordBtnClick{
    [self.navigationController pushViewController:[[ForgotPasswordVC alloc]init] animated:YES];
}

@end
