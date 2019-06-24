//
//  YYB_HF_submitDealPassWordVC.m
//  HFLife
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_submitDealPassWordVC.h"
#import "ZLSafetyPswView.h"
@interface YYB_HF_submitDealPassWordVC ()<UITextFieldDelegate>
@property(nonatomic, strong) UITextField *passWordText;//密码
@property (nonatomic,strong)UITextField *confirmPassWordText;//密码
@property (nonatomic,strong)UIImageView *saveImageView;//icon
@property (nonatomic,strong)UILabel *saveLabel;//安全提示
@property (nonatomic,strong)UILabel *errLabel;//错误信息
@property (nonatomic,strong)UIButton *sureBtn;//确认按钮

@property (nonatomic, strong) ZLSafetyPswView *passwordView;//密码
@property (nonatomic,strong) ZLSafetyPswView *confirmPasswordView;//密码



@end

@implementation YYB_HF_submitDealPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavBar];
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
        if (weakSelf.isLocal) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else {
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }
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

-(void)setUpUI {
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavBar.mas_bottom).mas_offset(8);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    self.saveImageView = [UIImageView new];
    self.saveLabel = [UILabel new];
    self.errLabel = [UILabel new];
    [self.view addSubview:self.saveImageView];
    [self.view addSubview:self.saveLabel];
    [self.view addSubview:self.errLabel];
    [self.view addSubview:self.passWordText];
    [self.view addSubview:self.confirmPassWordText];
    
    
    
    [self.saveImageView setImage:image(@"icon_safe")];
    self.saveLabel.text = @"为了您的资金安全 \n请先设置交易密码";
    self.saveLabel.font = FONT(14);
    self.saveLabel.textColor = HEX_COLOR(0x0C0B0B);
    self.saveLabel.numberOfLines = 2;
    
    self.errLabel.textColor = HEX_COLOR(0xCA1400);
    self.errLabel.font = FONT(11);
    self.errLabel.text = @"错误";
    self.errLabel.hidden = YES;
    
    
    
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
    
    UIView *top = self.saveImageView;

    [self.passWordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top.mas_bottom).mas_offset(ScreenScale(60));
        make.left.mas_equalTo(self.view).mas_offset(ScreenScale(55));
        make.height.mas_equalTo(ScreenScale(40));
        make.right.mas_equalTo(self.view).mas_offset(ScreenScale(-55));
        
    }];
    
    [self.confirmPassWordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passWordText.mas_bottom).mas_offset(ScreenScale(50));
        make.left.mas_equalTo(self.view).mas_offset(ScreenScale(55));
        make.height.mas_equalTo(ScreenScale(40));
        make.right.mas_equalTo(self.view).mas_offset(ScreenScale(-55));
        
    }];
    [self.errLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.confirmPassWordText.mas_bottom).mas_offset(ScreenScale(30));
        make.left.mas_equalTo(self.view).mas_offset(ScreenScale(12 + 20));
        make.height.mas_equalTo(ScreenScale(15));
        
    }];
    
    self.passwordView = [[ZLSafetyPswView alloc] initWithFrame:CGRectMake(50, 100, self.view.frame.size.width - 100, 45)];
    [self.view addSubview:self.passwordView];
    WEAK(weakSelf)
    self.passwordView.passwordDidChangeBlock = ^(NSString *password) {
        NSLog(@"---用户输入密码为: %@",password);
        weakSelf.passWordText.text = password;
        
        if (self.passWordText.text.length == 6 && self.confirmPassWordText.text.length == 6) {
            [weakSelf.sureBtn setEnabled:YES];
            [weakSelf.sureBtn setBackgroundColor:HEX_COLOR(0xCA1400)];
            weakSelf.errLabel.hidden = YES;
        }
        else {
            [weakSelf.sureBtn setEnabled:NO];
            [weakSelf.sureBtn setBackgroundColor:HEX_COLOR(0xAAAAAA)];
            weakSelf.errLabel.text = @"请输入6位交易密码";
            weakSelf.errLabel.hidden = NO;
        }
    };
    self.confirmPasswordView = [[ZLSafetyPswView alloc] initWithFrame:CGRectMake(50, 100, self.view.frame.size.width - 100, 45)];
    [self.view addSubview:self.confirmPasswordView];
    self.confirmPasswordView.passwordDidChangeBlock = ^(NSString *password) {
        NSLog(@"---用户输入密码为: %@",password);
        weakSelf.confirmPassWordText.text = password;
        
        if (self.passWordText.text.length == 6 && self.confirmPassWordText.text.length == 6) {
            [weakSelf.sureBtn setEnabled:YES];
            [weakSelf.sureBtn setBackgroundColor:HEX_COLOR(0xCA1400)];
            weakSelf.errLabel.hidden = YES;
        }
        else {
            [weakSelf.sureBtn setEnabled:NO];
            [weakSelf.sureBtn setBackgroundColor:HEX_COLOR(0xAAAAAA)];
            weakSelf.errLabel.text = @"请输入6位交易密码";
            weakSelf.errLabel.hidden = NO;
        }
    };
    
    
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.passWordText.mas_bottom);
        make.height.mas_equalTo(45);
        make.centerX.mas_equalTo(self.passWordText);
        make.width.mas_equalTo(SCREEN_WIDTH - 100);
    }];
    
    [self.confirmPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.confirmPassWordText.mas_bottom);
        make.height.mas_equalTo(45);
        make.centerX.mas_equalTo(self.confirmPassWordText);
        make.width.mas_equalTo(SCREEN_WIDTH - 100);
    }];
    
    
    
    UIButton *sureBtn = [UIButton new];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(31)];
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [sureBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    //    [sureBtn setBackgroundColor:HEX_COLOR(0xCA1400)];
    [sureBtn setBackgroundColor:HEX_COLOR(0xAAAAAA)];
    [sureBtn setEnabled:NO];
    [self.view addSubview:sureBtn];
    sureBtn.clipsToBounds = YES;
    sureBtn.layer.cornerRadius = 5;
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(ScreenScale(12));
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-ScreenScale(12));
        make.top.mas_equalTo(self.confirmPassWordText.mas_bottom).offset(ScreenScale(70));
        make.height.mas_equalTo(HeightRatio(90));
    }];
    self.sureBtn = sureBtn;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
#pragma mark - //提交
- (void)submitBtnClick {
    
    if (self.passWordText.text.length != 6 || self.confirmPassWordText.text.length != 6) {
        [WXZTipView showCenterWithText:@"请输入6位交易密码"];
        self.errLabel.text = @"请输入6位交易密码";
        [self.errLabel setHidden:NO];
        return;
    }
    if (![self.passWordText.text isEqualToString:self.confirmPassWordText.text]) {
        [WXZTipView showCenterWithText:@"交易密码输入不一致,请重新输入"];
        self.errLabel.text = @"校验密码不一致";
        [self.errLabel setHidden:NO];
        return;
    }
    
    NSDictionary *parm = @{@"password":self.passWordText.text,@"captcha":self.verCode};
    
    [[WBPCreate sharedInstance]showWBProgress];
    
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kCenterAdress(kSetPayPassword) withParameters:parm withResultBlock:^(BOOL result, id value) {
        [[WBPCreate sharedInstance]hideAnimated];
        if (result) {
            SXF_HF_AlertView *alert = [SXF_HF_AlertView showAlertType:AlertType_exchnageSuccess Complete:nil];
            alert.title = @"设置成功";
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.isLocal) {
                    [self.navigationController popToViewControllerWithLevel:2 animated:YES];
                }else {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            });
            
        }else {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络错误"];
            }
        }
    }];
}

- (UITextField *)passWordText{
    if (_passWordText == nil) {
        UITextField *tf = [[UITextField alloc] init];
        //        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        [tf setValue:HEX_COLOR(0xAAAAAA) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x5b5b5b);
        tf.font = [UIFont systemFontOfSize:HeightRatio(32)];
        tf.backgroundColor = [UIColor clearColor];
        tf.clearButtonMode = UITextFieldViewModeAlways;
        tf.secureTextEntry = YES;
        tf.delegate = self;
        
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenScale(12), ScreenScale(24))];
        lv.backgroundColor = [UIColor clearColor];

        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = lv;
        [tf sizeToFit];
        
        UILabel *tipLabe = [UILabel new];
        tipLabe.font = FONT(15);
        tipLabe.textColor = HEX_COLOR(0xAAAAAA);
        tipLabe.text = @"请输入交易密码";

        [self.view addSubview:tf];
        [tf addSubview:tipLabe];
        [tipLabe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(tf.mas_top).mas_offset(ScreenScale(-20));
            make.left.mas_equalTo(self.view).mas_offset(24);
            make.height.mas_equalTo(ScreenScale(15));
        }];
        
        
//        UILabel *lin = [UILabel new];
//        lin.backgroundColor = HEX_COLOR(0xF5F5F5);
//        [tf addSubview:lin];
//        [lin mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.bottom.right.mas_equalTo(tf);
//            make.height.mas_equalTo(1);
//        }];
        _passWordText = tf;
    }
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenScale(20), HeightRatio(69))];
    rightView.backgroundColor = [UIColor clearColor];
    //    UIButton *clearnButton = [UIButton new];
    //    [clearnButton setImage:[UIImage imageNamed:@"icon_clear"] forState:UIControlStateNormal];
    //    [clearnButton wh_addActionHandler:^{
    //        self->_passWordText.text = @"";
    //    }];
    //    [rightView addSubview:clearnButton];
    //    [clearnButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.left.mas_equalTo(rightView);
    //        make.top.bottom.mas_equalTo(rightView);
    //    }];
    _passWordText.rightView = rightView;
    _passWordText.rightViewMode = UITextFieldViewModeAlways;
    return _passWordText;
}

- (UITextField *)confirmPassWordText{
    if (!_confirmPassWordText) {
        UITextField *tf = [[UITextField alloc] init];
        //        tf.keyboardType = UIKeyboardTypeASCIICapable;
        //        tf.keyboardType = UIKeyboardTypeTwitter;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        [tf setValue:HEX_COLOR(0xAAAAAA) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x5b5b5b);
        //        tf.secureTextEntry = YES;
        tf.font = [UIFont systemFontOfSize:HeightRatio(32)];
        tf.backgroundColor = [UIColor clearColor];
        tf.secureTextEntry = YES;
        
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenScale(12), ScreenScale(24))];
        lv.backgroundColor = [UIColor clearColor];
        
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = lv;
        [tf sizeToFit];
        tf.delegate  = self;
        
        UILabel *tipLabe = [UILabel new];
        tipLabe.font = FONT(15);
        tipLabe.textColor = HEX_COLOR(0xAAAAAA);
        tipLabe.text = @"请输入校验密码";
        [self.view addSubview:tf];
        [tf addSubview:tipLabe];
        [tipLabe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(tf.mas_top).mas_offset(ScreenScale(-20));
            make.left.mas_equalTo(self.view).mas_offset(24);
            make.height.mas_equalTo(ScreenScale(15));
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(120), HeightRatio(69))];
        rightView.backgroundColor = [UIColor clearColor];
        
        tf.rightViewMode = UITextFieldViewModeAlways;
        tf.rightView = rightView;
        
//        UILabel *lin = [UILabel new];
//        lin.backgroundColor = HEX_COLOR(0xF5F5F5);
//        [tf addSubview:lin];
//        [lin mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.bottom.right.mas_equalTo(tf);
//            make.height.mas_equalTo(1);
//        }];
        _confirmPassWordText = tf;
    }
    return _confirmPassWordText;
}


#pragma mark - textFiledDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.errLabel setHidden:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= 6) {
        textField.text = [textField.text substringToIndex:6];
        if (string.length == 0) {
            return YES;
        }
        [WXZTipView showCenterWithText:@"只能输入6位交易密码"];
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.passWordText.text.length == 6 && self.confirmPassWordText.text.length == 6) {
        [self.sureBtn setEnabled:YES];
        [self.sureBtn setBackgroundColor:HEX_COLOR(0xCA1400)];
        self.errLabel.hidden = YES;
    }
    else {
        [self.sureBtn setEnabled:NO];
        [self.sureBtn setBackgroundColor:HEX_COLOR(0xAAAAAA)];
        self.errLabel.text = @"请输入6位交易密码";
        self.errLabel.hidden = NO;
    }
}


@end
