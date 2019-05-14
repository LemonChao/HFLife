//
//  ConfirmInformationVC.m
//  HanPay
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ConfirmInformationVC.h"
#import "SetTradePassword.h"
#import "Per_MethodsToDealWithManage.h"

@interface ConfirmInformationVC ()
/** 手机号 */
@property (nonatomic,strong) UITextField *userNameTextField;
/** 验证码 */
@property (nonatomic,strong) UITextField *idCardTextField;
@end

@implementation ConfirmInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    self.customNavBar.title = @"确认信息";
    self.customNavBar.backgroundColor = RGBA(136, 53, 230, 1);//[UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    
}
-(void)initWithUI{
    self.userNameTextField = [self getTextFieldPlaceholder:@"请输入姓名" Title:@"真实姓名"];
    [self.view addSubview:self.userNameTextField];
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight);
        make.height.mas_equalTo(HeightRatio(90));
    }];
    
    self.idCardTextField = [self getTextFieldPlaceholder:@"请填写身份证号码" Title:@"身份证号"];
    [self.view addSubview:self.idCardTextField];
    [self.idCardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.top.mas_equalTo(self.userNameTextField.mas_bottom);
        make.height.mas_equalTo(HeightRatio(90));
    }];
    
    UILabel *label = [UILabel new];
    label.text = @"请确认是本人设置交易密码";
    label.textColor = HEX_COLOR(0x999999);
    label.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(27));
        make.top.mas_equalTo(self.idCardTextField.mas_bottom).offset(HeightRatio(274));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
        //
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
        [button setTitle:@"下一步" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    });
}
-(void)buttonClick{
    if ([NSString isNOTNull:self.userNameTextField.text]) {
        [WXZTipView showCenterWithText:@"请填写你的真实姓名"];
        return;
    }
    if (![self.idCardTextField.text isValidateIdentityCard]) {
        [WXZTipView showCenterWithText:@"请填写正确的身份证号码"];
        return;
    }
    [Per_MethodsToDealWithManage sharedInstance].superVC = self;
    [[Per_MethodsToDealWithManage sharedInstance]identityInformationConfirmParameter:@{@"truename":self.userNameTextField.text,@"idcard":self.idCardTextField.text}];
    [self.navigationController pushViewController:[[SetTradePassword alloc]init] animated:YES];
}
#pragma mark 获取文本框
-(UITextField *)getTextFieldPlaceholder:(NSString *)placeholder Title:(NSString *)title{
    UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = placeholder;
    [tf setValue:HEX_COLOR(0x666666) forKeyPath:@"_placeholderLabel.textColor"];
    tf.textColor = [UIColor blackColor];
    tf.font = [UIFont systemFontOfSize:HeightRatio(28)];
    tf.backgroundColor = [UIColor whiteColor];
    
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(170), HeightRatio(90))];
    lv.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel  = [UILabel new];
    titleLabel.text = title;
    titleLabel.textColor = HEX_COLOR(0x000000);
    titleLabel.font = [UIFont systemFontOfSize:WidthRatio(27)];
    [lv addSubview:titleLabel];
    [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lv.mas_left);
        make.centerY.mas_equalTo(lv.mas_centerY);
        make.height.mas_equalTo(HeightRatio(27));
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.leftView = lv;
    [tf sizeToFit];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
