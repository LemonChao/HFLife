//
//  RegisteredVC.m
//  HanPay
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RegisteredVC.h"
//#import "HP_GetVerificationCodeNetApi.h"
//#import "HP_RegisteredNetApi.h"
//#import "HP_LoginNetApi.h"
//#import "ServiceAgreementVC.h"
@interface RegisteredVC ()
{
    UIButton *agreeBtn;
}
/** 手机号*/
@property (nonatomic,strong)UITextField *phoneTextField;

/**
 用户名
 */
@property (nonatomic,strong)UITextField *userNameTextField;

/**
 密码
 */
@property (nonatomic,strong)UITextField *passwordTextField;

/**
 邀请码
 */
@property (nonatomic,strong)UITextField *inviteCodeTextField;

/**
 验证码
 */
@property (nonatomic,strong)UITextField *verificationCodeTextField;
@end

@implementation RegisteredVC

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
    titleLabel.text = @"欢迎注册汉富新生活";
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
    
    self.userNameTextField = [self getTextFieldPlaceholder:@"请输入6-15英文字母或数字的用户名" imageName:@"re_user"];
    self.userNameTextField.sd_layout
    .leftSpaceToView(self.view, WidthRatio(98))
    .rightSpaceToView(self.view, WidthRatio(90))
    .topSpaceToView(self.phoneTextField, HeightRatio(22))
    .heightIs(HeightRatio(85));
    
    self.passwordTextField = [self getTextFieldPlaceholder:@"请输入您的密码" imageName:@"mima"];
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.sd_layout
    .leftSpaceToView(self.view, WidthRatio(98))
    .rightSpaceToView(self.view, WidthRatio(90))
    .topSpaceToView(self.userNameTextField, HeightRatio(22))
    .heightIs(HeightRatio(85));
    
    self.inviteCodeTextField = [self getTextFieldPlaceholder:@"推荐邀请码（必填）" imageName:@"invitation"];
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
    
    agreeBtn = [UIButton new];
    agreeBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
    [agreeBtn setTitleColor:HEX_COLOR(0xAAAAAA) forState:(UIControlStateNormal)];
    [agreeBtn setImagePosition:ImagePositionTypeLeft spacing:ScreenScale(20)];
    [agreeBtn addTarget:self action:@selector(agreeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [agreeBtn setTitle:@"我已阅读并接受" forState:(UIControlStateNormal)];
    [agreeBtn setImage:MMGetImage(@"gouxuan") forState:(UIControlStateNormal)];
    [agreeBtn setImage:MMGetImage(@"gouxuan1") forState:(UIControlStateSelected)];
    [self.view addSubview:agreeBtn];
    agreeBtn.sd_layout
    .leftSpaceToView(self.view, WidthRatio(98))
    .topSpaceToView(self.verificationCodeTextField, HeightRatio(52))
    .heightIs(HeightRatio(22))
    .widthIs(WidthRatio(220));
   
//
    UIButton *agreementBtn =  [UIButton new];
    agreementBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
    [agreementBtn addTarget:self action:@selector(agreementBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [agreementBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [agreementBtn setTitle:@"《汉富商城用户注册协议》" forState:(UIControlStateNormal)];
    [self.view addSubview:agreementBtn];
    agreementBtn.sd_layout
    .leftSpaceToView(agreeBtn,-WidthRatio(16))
    .topSpaceToView(self.verificationCodeTextField, HeightRatio(52))
    .heightIs(HeightRatio(22))
    .widthIs(WidthRatio(270));
   
    UIButton *registerdBtn = [UIButton new];
    registerdBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(30)];
    registerdBtn.backgroundColor = [UIColor redColor];
    [registerdBtn setTitle:@"注册" forState:(UIControlStateNormal)];
    [registerdBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [registerdBtn addTarget:self action:@selector(registerdBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:registerdBtn];
    registerdBtn.sd_layout
    .leftSpaceToView(self.view, WidthRatio(95))
    .rightSpaceToView(self.view, WidthRatio(83))
    .topSpaceToView(agreementBtn, HeightRatio(104))
    .heightIs(HeightRatio(88));
    MMViewBorderRadius(registerdBtn, WidthRatio(44), 0, [UIColor clearColor]);
    
    UILabel *label = [UILabel new];
    label.text = @"已有账号？去登陆";
    label.textColor = HEX_COLOR(0x636363);
    label.textAlignment = NSTextAlignmentRight;
    label.font =[UIFont systemFontOfSize:WidthRatio(24)];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:label.text];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[label.text rangeOfString:@"去登陆"]];
    label.attributedText = string;
    [self.view addSubview:label];
    label.sd_layout
    .rightSpaceToView(self.view, WidthRatio(83))
    .topSpaceToView(registerdBtn, HeightRatio(43))
    .heightIs(HeightRatio(24));
    [label setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    UIButton *getback = [UIButton new];
    getback.backgroundColor = [UIColor clearColor];
    [getback addTarget:self action:@selector(axcBaseClickBaseLeftImageBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:getback];
    getback.sd_layout
    .rightEqualToView(label)
    .topEqualToView(label)
    .widthRatioToView(label, 1)
    .heightRatioToView(label, 1);
}
-(void)getLoginCode:(UIButton *)send{
    if (![self.phoneTextField.text isValidateMobile]) {
        [WXZTipView showCenterWithText:@"请输入正确的手机号"];
        return;
    }
    
    if ([NSString isNOTNull:self.inviteCodeTextField.text]) {
        [WXZTipView showCenterWithText:@"邀请码不能为空"];
        return;
    }
    //@"type":@"8" 注册加验证码
    
    
    /*
    
    HP_GetVerificationCodeNetApi *getVerCode = [[HP_GetVerificationCodeNetApi alloc]initWithParameter:@{@"phone":self.phoneTextField.text,@"type":@"8",@"inviteCode":self.inviteCodeTextField.text}];
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
-(void)registerdBtnClick{
    NSLog(@"注册");
    if (![self.phoneTextField.text isValidateMobile]) {
        [WXZTipView showCenterWithText:@"请输入正确的手机号"];
        return;
    }
    if (![NSString validateUserName:self.userNameTextField.text]) {
        [WXZTipView showCenterWithText:@"请输入正确的用户名"];
        return;
    }
    if (![self.passwordTextField.text checkPassWord]) {
        [WXZTipView showCenterWithText:@"密码格式应为6~20位，数字和字母组合的形式"];
        return;
    }
    if ([NSString isNOTNull:self.verificationCodeTextField.text]) {
        [WXZTipView showCenterWithText:@"验证码不能为空"];
        return;
    }
    if ([NSString isNOTNull:self.inviteCodeTextField.text]) {
        [WXZTipView showCenterWithText:@"邀请码不能为空"];
        return;
    }
    if (!agreeBtn.selected) {
        [WXZTipView showCenterWithText:@"您还没同意注册协议"];
        return;
    }
    NSDictionary *dict = @{
                           @"phone":self.phoneTextField.text,
                           @"username":self.userNameTextField.text,
                           @"code":self.verificationCodeTextField.text,
                           @"password":self.passwordTextField.text,
                           @"invite_code":[NSString isNOTNull:self.inviteCodeTextField.text]?@"":self.inviteCodeTextField.text
                           };
    
    /*
    
    HP_RegisteredNetApi *registeredNetApi = [[HP_RegisteredNetApi alloc]initWithParameter:dict];
    [registeredNetApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_RegisteredNetApi *registered = (HP_RegisteredNetApi *)request;
        NSInteger status = [registered getCodeStatus];
        if (status == 1) {
            [WXZTipView showCenterWithText:@"注册成功！"];
            HP_LoginNetApi *loginNetApi  = [[HP_LoginNetApi alloc]initWithParameter:@{@"account":self.phoneTextField.text,@"password":self.passwordTextField.text}];
            [loginNetApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                HP_LoginNetApi *loginRequest = (HP_LoginNetApi *)request;
                if ([loginRequest getCodeStatus] == 1) {
                    NSDictionary *dict = [loginRequest getContent];
                    [HeaderToken setToken:dict[@"token"]];
                    [UserCache setUserPhone:self.phoneTextField.text];
                    [UserCache setUserPass:self.passwordTextField.text];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    [WXZTipView showCenterWithText:[loginRequest getMsg]];
                }
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                HP_LoginNetApi *loginRequest = (HP_LoginNetApi *)request;
                [WXZTipView showCenterWithText:[loginRequest getMsg]];
            }];
            
        }else{
            [WXZTipView showCenterWithText:[registered getMsg]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_RegisteredNetApi *registered = (HP_RegisteredNetApi *)request;
         [WXZTipView showCenterWithText:[registered getMsg]];
    }];
     
     */
}
-(void)agreeBtnClick{
    NSLog(@"是否同意");
    agreeBtn.selected = !agreeBtn.selected;
}
-(void)agreementBtnClick{
    NSLog(@"协议");
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"APP_agreement" ofType:@"doc"];
    
    
    /*
    
    
    ServiceAgreementVC *serv = [[ServiceAgreementVC alloc]init];
    serv.htmlPath = htmlPath;
    serv.title = @"注册协议";
    [self.navigationController pushViewController:serv animated:YES];
     
     */
}

- (void)axcBaseClickBaseLeftImageBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
