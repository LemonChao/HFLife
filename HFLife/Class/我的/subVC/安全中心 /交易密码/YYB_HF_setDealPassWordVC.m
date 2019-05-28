//
//  YYB_HF_setDealPassWordVC.m
//  HFLife
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_setDealPassWordVC.h"
#import "YYB_HF_submitDealPassWordVC.h"//提交
@interface YYB_HF_setDealPassWordVC ()<UITextFieldDelegate>
@property(nonatomic, strong) UITextField *phoneText;//手机号
@property (nonatomic,strong)UITextField *vercodeText;//验证码
@property (nonatomic,strong)UIImageView *saveImageView;//icon
@property (nonatomic,strong)UILabel *saveLabel;//安全提示
@property (nonatomic,strong)UILabel *vercodeerr;//验证码错误
@property (nonatomic,strong)UIButton *sureBtn;//确认按钮

@end

@implementation YYB_HF_setDealPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBar];
    self.view.backgroundColor = HEX_COLOR(0xF5F5F5);
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    //    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"NearFoodSousuo"]];
    //    [self.customNavBar wr_setRightButtonWithTitle:@"发布" titleColor:HEX_COLOR(0xC04CEB)];
    //    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"yynavi_bg"];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
        //        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.customNavBar setOnClickRightButton:^{
        
        
    }];
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"交易密码";
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}

- (void)setUpUI {
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavBar.mas_bottom).mas_offset(8);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    self.saveImageView = [UIImageView new];
    self.saveLabel = [UILabel new];
    self.vercodeerr = [UILabel new];
    [self.view addSubview:self.saveImageView];
    [self.view addSubview:self.saveLabel];
    [self.view addSubview:self.vercodeerr];
    
    [self.view addSubview:self.phoneText];
    [self.view addSubview:self.vercodeText];

//    self.saveImageView.backgroundColor = [UIColor redColor];
    [self.saveImageView setImage:image(@"icon_safe")];
    self.saveLabel.text = @"为了您的资金安全 \n请先验证手机号";
    self.saveLabel.font = FONT(14);
    self.saveLabel.textColor = HEX_COLOR(0x0C0B0B);
    self.saveLabel.numberOfLines = 2;
    
    self.vercodeerr.textColor = HEX_COLOR(0xCA1400);
    self.vercodeerr.font = FONT(11);
    self.vercodeerr.text = @"验证码错误";
    [self.vercodeerr setHidden:YES];
    
    [self.saveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView).mas_offset(52);
        make.left.mas_equalTo(bgView).mas_offset(ScreenScale(112));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(25);
    }];
    
    [self.saveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.saveImageView);
        make.width.mas_greaterThanOrEqualTo(ScreenScale(111));
        make.height.mas_greaterThanOrEqualTo(0);
        make.left.mas_equalTo(self.saveImageView.mas_right).mas_offset(ScreenScale(10));
    }];
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.saveImageView.mas_bottom).mas_offset(ScreenScale(60));
        make.left.mas_equalTo(self.view).mas_offset(ScreenScale(12));
        make.height.mas_equalTo(ScreenScale(40));
        make.right.mas_equalTo(self.view).mas_offset(ScreenScale(-12));

    }];
    
    [self.vercodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneText.mas_bottom).mas_offset(ScreenScale(50));
        make.left.mas_equalTo(self.view).mas_offset(ScreenScale(12));
        make.height.mas_equalTo(ScreenScale(40));
        make.right.mas_equalTo(self.view).mas_offset(ScreenScale(-12));

    }];
    [self.vercodeerr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.vercodeText.mas_bottom).mas_offset(ScreenScale(30));
        make.left.mas_equalTo(self.view).mas_offset(ScreenScale(12 + 20));
        make.height.mas_equalTo(ScreenScale(15));
        
    }];
    
    
    UIButton *sureBtn = [UIButton new];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(31)];
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
//    [sureBtn setBackgroundColor:HEX_COLOR(0xCA1400)];
    [sureBtn setBackgroundColor:HEX_COLOR(0xAAAAAA)];
    [sureBtn setEnabled:NO];
    [self.view addSubview:sureBtn];
    sureBtn.clipsToBounds = YES;
    sureBtn.layer.cornerRadius = 5;
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(ScreenScale(12));
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-ScreenScale(12));
        make.top.mas_equalTo(self.vercodeText.mas_bottom).offset(ScreenScale(70));
        make.height.mas_equalTo(HeightRatio(90));
    }];
    self.sureBtn = sureBtn;
    
}

- (void)sureBtnClick{
    if ([NSString isNOTNull:self.phoneText.text]) {
        [WXZTipView showCenterWithText:@"请输入手机号"];
        return;
    }
    if ([NSString isNOTNull:self.vercodeText.text]) {
        [WXZTipView showCenterWithText:@"请输入验证码"];
        return;
    }
    
    YYB_HF_submitDealPassWordVC *vc = [[YYB_HF_submitDealPassWordVC alloc]init];
    vc.verCode = self.vercodeText.text;
    [self.navigationController pushViewController:vc animated:YES];
}


- (UITextField *)phoneText{
    if (_phoneText == nil) {
        UITextField *tf = [[UITextField alloc] init];
        //        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.keyboardType = UIKeyboardTypeNumberPad;
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
//    UIButton *clearnButton = [UIButton new];
//    [clearnButton setImage:[UIImage imageNamed:@"icon_clear"] forState:UIControlStateNormal];
//    [clearnButton wh_addActionHandler:^{
//        self->_phoneText.text = @"";
//    }];
//    [rightView addSubview:clearnButton];
//    [clearnButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.left.mas_equalTo(rightView);
//        make.top.bottom.mas_equalTo(rightView);
//    }];
    _phoneText.rightView = rightView;
    _phoneText.rightViewMode = UITextFieldViewModeAlways;
    return _phoneText;
}

- (UITextField *)vercodeText{
    if (!_vercodeText) {
        UITextField *tf = [[UITextField alloc] init];
        //        tf.keyboardType = UIKeyboardTypeASCIICapable;
        //        tf.keyboardType = UIKeyboardTypeTwitter;
        tf.placeholder = @"请输入验证码";
        tf.keyboardType = UIKeyboardTypeNumberPad;
        [tf setValue:HEX_COLOR(0xAAAAAA) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x5b5b5b);
        //        tf.secureTextEntry = YES;
        tf.font = [UIFont systemFontOfSize:HeightRatio(32)];
        tf.backgroundColor = [UIColor clearColor];
        tf.delegate = self;
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
        codeButton.titleLabel.font =[UIFont systemFontOfSize:WidthRatio(32)];
        [codeButton addTarget:self action:@selector(getSetingCode:) forControlEvents:(UIControlEventTouchUpInside)];
        [codeButton setTitleColor:HEX_COLOR(0xCA1400) forState:(UIControlStateNormal)];
        [codeButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        codeButton.clipsToBounds = YES;
        codeButton.layer.cornerRadius = 5;
        codeButton.layer.borderWidth = 1;
        codeButton.layer.borderColor = HEX_COLOR(0xCA1400).CGColor;
        [rightView addSubview:codeButton];
        
        [codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rightView.mas_right);
            make.top.bottom.mas_equalTo(rightView);
            make.width.mas_equalTo(ScreenScale(120));
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

//验证码
- (void)getSetingCode:(UIButton *)send{
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
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kSendsms withParameters:@{@"mobile":self.phoneText.text,@"event":@"set_pay_password"} withResultBlock:^(BOOL result, id value) {
        [[WBPCreate sharedInstance] hideAnimated];
        if (result) {
            [WXZTipView showCenterWithText:@"短信验证码已发送"];
            [send setTheCountdownStartWithTime:60 title:@"获取验证码" countDownTitle:@"s后重新获取" mainColor:[UIColor whiteColor] countColor:[UIColor whiteColor]];

        }else {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络错误"];
            }
        }
    }];
    
}

#pragma mark - textFiledDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.phoneText.text.length > 0 && self.vercodeText.text.length > 0) {
        [self.sureBtn setEnabled:YES];
        [self.sureBtn setBackgroundColor:HEX_COLOR(0xCA1400)];

    }else {
        [self.sureBtn setEnabled:NO];
        [self.sureBtn setBackgroundColor:HEX_COLOR(0xAAAAAA)];
    }
}
@end
