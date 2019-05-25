//
//  YYB_HF_destroyAccountVC.m
//  HFLife
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_destroyAccountVC.h"
#import "YYB_HF_destroyFailView.h"
@interface YYB_HF_destroyAccountVC ()<UITextFieldDelegate>
@property(nonatomic, strong) UITextField *phoneText;//手机号
@property (nonatomic,strong)UITextField *vercodeText;//验证码
@property (nonatomic,strong)UIButton *sureBtn;//确认按钮

@end

@implementation YYB_HF_destroyAccountVC

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
        [weakSelf.navigationController popViewControllerAnimated:YES];
        //        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.customNavBar setOnClickRightButton:^{
        
        
    }];
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"注销账号";
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
    
    [self.view addSubview:self.phoneText];
    [self.view addSubview:self.vercodeText];
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView).mas_offset(ScreenScale(26));
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
    
    UIButton *sureBtn = [UIButton new];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(31)];
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitle:@"提交" forState:(UIControlStateNormal)];
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
- (UITextField *)phoneText{
    if (_phoneText == nil) {
        UITextField *tf = [[UITextField alloc] init];
        //        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.text = @"当前手机号";
        [tf setEnabled:NO];
        [tf setValue:HEX_COLOR(0xAAAAAA) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x5b5b5b);
        tf.font = [UIFont systemFontOfSize:HeightRatio(32)];
        tf.backgroundColor = [UIColor clearColor];
        tf.clearButtonMode = UITextFieldViewModeAlways;
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
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenScale(100), HeightRatio(69))];
    rightView.backgroundColor = [UIColor clearColor];
    UIButton *clearnButton = [UIButton new];
    [clearnButton setTitle:[[userInfoModel sharedUser].member_mobile EncodeTel] forState:UIControlStateNormal];
    [clearnButton setTitleColor:HEX_COLOR(0x5b5b5b) forState:UIControlStateNormal];
    [clearnButton.titleLabel setFont:FONT(16)];
//    [clearnButton setImage:[UIImage imageNamed:@"icon_clear"] forState:UIControlStateNormal];
    [clearnButton setEnabled:NO];
    [rightView addSubview:clearnButton];
    [clearnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(rightView);
        make.top.bottom.mas_equalTo(rightView);
    }];
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
        tf.delegate = self;
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(120), HeightRatio(69))];
        rightView.backgroundColor = [UIColor clearColor];
        
        
        UIButton *codeButton = [UIButton new];
        codeButton.titleLabel.font =[UIFont systemFontOfSize:WidthRatio(32)];
        [codeButton addTarget:self action:@selector(getSetingCode:) forControlEvents:(UIControlEventTouchUpInside)];
        [codeButton setTitleColor:HEX_COLOR(0xCA1400) forState:(UIControlStateNormal)];
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

//验证码
- (void)getSetingCode:(UIButton *)send{
    if (![[userInfoModel sharedUser].member_mobile isValidateMobile]) {
        [WXZTipView showCenterWithText:@"手机号不正确"];
        return;
    }
    
    //    [self openCountdown:send];
    [[WBPCreate sharedInstance] showWBProgress];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kSendsms withParameters:@{@"mobile":[userInfoModel sharedUser].member_mobile,@"event":@"close_mobile"} withResultBlock:^(BOOL result, id value) {
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
- (void)openCountdown:(UIButton *)authCodeBtn{
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

//提交
- (void)sureBtnClick {
    
    [[WBPCreate sharedInstance]showWBProgress];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kCloseAccount withParameters:@{@"captcha":self.vercodeText.text} withResultBlock:^(BOOL result, id value) {
        [[WBPCreate sharedInstance]hideAnimated];
        if (result) {
            SXF_HF_AlertView *alert = [SXF_HF_AlertView showAlertType:AlertType_exchnageSuccess Complete:nil];
            alert.title = @"注销成功";
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [LoginVC login];
            });
            
        }else {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                YYB_HF_destroyFailView *view = [[YYB_HF_destroyFailView alloc]init];
                view.tipMsg = [value safeObjectForKey:@"msg"];
                view.sureBlock = ^{
                    [self.navigationController popViewControllerAnimated:YES];
                };
                [self.view addSubview:view];
                
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.bottom.mas_equalTo(self.view);
                    make.top.mas_equalTo(self.customNavBar.mas_bottom);
                }];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
