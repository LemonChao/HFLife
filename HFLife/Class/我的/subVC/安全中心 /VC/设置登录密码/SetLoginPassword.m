//
//  SetLoginPassword.m
//  HanPay
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "SetLoginPassword.h"
#import "Per_MethodsToDealWithManage.h"
@interface SetLoginPassword ()
/** 就密码 */
@property (nonatomic,strong) UITextField *used_PawTextField;
/** 新密码 */
@property (nonatomic,strong) UITextField *pawTextField;
/** 确认密码 */
@property (nonatomic,strong) UITextField *affirm_pawTextField;
@end

@implementation SetLoginPassword

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
//    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = [UserCache getUserPasswordStatus] ? @"修改登录密码" : @"设置登录密码";
    self.customNavBar.backgroundColor = RGBA(136, 53, 230, 1);//[UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    
}
-(void)initWithUI{
    UILabel *titleLabel  = [UILabel new];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:WidthRatio(35)];
    titleLabel.textColor = HEX_COLOR(0x000000);
//    titleLabel.text = [UserCache getUserPasswordStatus] ? @"修改登录密码" : @"设置登录密码";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(HeightRatio(20)+self.navBarHeight);
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(22));
        make.height.mas_greaterThanOrEqualTo(1);
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    
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
    
    self.used_PawTextField = [self getTextFieldPlaceholder:@"请输入旧密码"];
    [self.used_PawTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(76));
        make.top.mas_equalTo(instructionsLabel.mas_bottom).offset(HeightRatio(52));
    }];
    
    self.pawTextField = [self getTextFieldPlaceholder:@"请输入新密码"];
    [self.pawTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(76));
        make.top.mas_equalTo(self.used_PawTextField.mas_bottom).offset(HeightRatio(23));
    }];
    
    self.affirm_pawTextField = [self getTextFieldPlaceholder:@"请确认新密码"];
    [self.affirm_pawTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(76));
        make.top.mas_equalTo(self.pawTextField.mas_bottom).offset(HeightRatio(23));
    }];
    
    UILabel *label = [UILabel new];
    label.text = [UserCache getUserPasswordStatus] ? @"修改后，您当前的账号的信息，个人资产不变" : @"";
    label.textColor = HEX_COLOR(0x999999);
    label.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(27));
        make.top.mas_equalTo(self.affirm_pawTextField.mas_bottom).offset(HeightRatio(90));
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
        [button setTitle:@"确认" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    });
    
}
#pragma mark 获取文本框
-(UITextField *)getTextFieldPlaceholder:(NSString *)placeholder{
    UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = placeholder;
    [tf setValue:HEX_COLOR(0x666666) forKeyPath:@"_placeholderLabel.textColor"];
    tf.textColor = [UIColor blackColor];
    tf.font = [UIFont systemFontOfSize:HeightRatio(32)];
    tf.backgroundColor = [UIColor whiteColor];
    tf.secureTextEntry = YES;
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
-(void)buttonClick{
    if ([NSString isNOTNull:self.used_PawTextField.text]) {
        [WXZTipView showCenterWithText:@"请输入原密码"];
        return;
    }
    if (![self.pawTextField.text checkPassWord]) {
        [WXZTipView showCenterWithText:@"请输入符合规则的密码"];
        return;
    }
    if (![self.pawTextField.text isEqualToString:self.affirm_pawTextField.text]) {
        [WXZTipView showCenterWithText:@"确认的密码和输入的密码不同"];
        return;
    }
    NSDictionary *dict = @{@"newpassword":self.pawTextField.text,@"oldpassword":self.used_PawTextField.text};
    [[Per_MethodsToDealWithManage sharedInstance]ModifyLoginPasswordParameter:dict SuccessBlock:^(id  _Nonnull request) {
        if ([request boolValue]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
    }];
//    [WXZTipView showCenterWithText:@"密码设置成功"];
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
