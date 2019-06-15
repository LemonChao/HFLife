//
//  ModifyNicknameVC.m
//  HanPay
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ModifyNicknameVC.h"
//#import "HP_ChangeNicknameNetApi.h"
@interface ModifyNicknameVC ()<UITextFieldDelegate>
{
    UITextField *userNameTextField;
}

@end

@implementation ModifyNicknameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    //    [self.customNavBar wr_setRightButtonWithTitle:@"保存" titleColor:[UIColor whiteColor]];
    //    [self.customNavBar.rightButton setBadgeBGColor:HEX_COLOR(0xCA1400)];
    UIButton *rightBtn = [UIButton wh_buttonWithTitle:@"保存" backColor:HEX_COLOR(0xCA1400) backImageName:nil titleColor:[UIColor whiteColor] fontSize:14 frame:CGRectMake(0, 0, 50, 32) cornerRadius:5];
    [rightBtn wh_addActionHandler:^{
        NSLog(@"click");
        [self buttonClick];
    }];
    
    [self.customNavBar addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.customNavBar.leftButton);
        make.right.mas_equalTo(self.customNavBar).mas_offset(-13);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(32);
    }];
    
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    //    [self.customNavBar setOnClickRightButton:^{
    //        NSLog(@"保存");
    //    }];
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"昵称";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    
    if ([self.type isEqualToString:@"年龄"]) {
        self.customNavBar.title = @"年龄";
    }
}
-(void)initWithUI{
    userNameTextField = [UITextField new];

    NSString *placeStr = @"请输入昵称";
    NSString *markStr = @"好昵称可以让大家更容易记住你。";
    NSString *nameStr = [userInfoModel sharedUser].nickname;
    if ([self.type isEqualToString:@"年龄"]) {
        placeStr = @"请输入年龄";
        markStr = @"永远活在18岁。";
        userNameTextField.keyboardType = UIKeyboardTypeNumberPad;
        nameStr = [userInfoModel sharedUser].member_age.stringValue;
    }
    userNameTextField.backgroundColor = [UIColor whiteColor];
    userNameTextField.textColor = [UIColor blackColor];
    userNameTextField.font = [UIFont systemFontOfSize:WidthRatio(30)];
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(0,0,22,50)];
    leftView.backgroundColor = [UIColor clearColor];
    userNameTextField.leftView = leftView;
    userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    userNameTextField.placeholder = placeStr;
    userNameTextField.text = nameStr;
    userNameTextField.delegate = self;
    
    UIView *line1 = [UIView new];
    line1.setBackgroundColor(HEX_COLOR(0xf4f7f7)).setCornerRadius(0).setBoardWidth(0);
    
    [self.view addSubview:line1];
    
    [self.view addSubview:userNameTextField];
    [userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(2 + self.navBarHeight);
        make.right.mas_equalTo(self.view).mas_offset(-0);
        make.left.mas_equalTo(self.view).mas_offset(0);
        make.height.mas_equalTo(HeightRatio(90));
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self->userNameTextField.mas_top);
        make.right.mas_equalTo(self.view).mas_offset(-0);
        make.left.mas_equalTo(self.view).mas_offset(0);
        make.height.mas_equalTo(2);
    }];
    
    UIView *line = [UIView new];
    
    line.setBackgroundColor(HEX_COLOR(0xCA1400));
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->userNameTextField.mas_bottom);
        make.left.mas_equalTo(self.view).mas_equalTo(ScreenScale(12));
        make.right.mas_equalTo(self.view).mas_equalTo(ScreenScale(-12));
        make.height.mas_equalTo(ScreenScale(1));
    }];
    
    UILabel *markLabel = [UILabel new];
    markLabel.setText(markStr).setTextColor(HEX_COLOR(0xAAAAAA)).setFontSize(14);
    
    [self.view addSubview:markLabel];
    [markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->userNameTextField.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.view).mas_equalTo(ScreenScale(22));
        make.right.mas_equalTo(self.view).mas_equalTo(ScreenScale(-22));
        make.height.mas_equalTo(ScreenScale(16));
    }];
    
    //    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(WidthRatio(20), HeightRatio(264)+self.navBarHeight, SCREEN_WIDTH-WidthRatio(20)-WidthRatio(20), HeightRatio(88))];
    //    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    //    gradientLayer.frame = CGRectMake(0, 0,  SCREEN_WIDTH-WidthRatio(20)-WidthRatio(20), HeightRatio(88));
    //    gradientLayer.startPoint = CGPointMake(0, 0);
    //    gradientLayer.endPoint = CGPointMake(1, 0);
    //    gradientLayer.locations = @[@(0.38),@(0.6),@(0.8),@(1.0)];//渐变点
    //
    //    [gradientLayer setColors:@[(id)[HEX_COLOR(0x9f22ff) CGColor],(id)[HEX_COLOR(0x9323ff) CGColor],(id)HEX_COLOR(0x7f23ff).CGColor]];//渐变数组
    //    [button.layer addSublayer:gradientLayer];
    //    [button setTitle:@"保存" forState:(UIControlStateNormal)];
    //    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    //    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    //    [self.view addSubview:button];
    //    MMViewBorderRadius(button, WidthRatio(10), 0, [UIColor clearColor]);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.type isEqualToString:@"年龄"]) {
        
    }else {
        if (userNameTextField.text.length > 5) {
            [WXZTipView showCenterWithText:@"昵称不能大于5位"];
            return NO;
        }
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([self.type isEqualToString:@"年龄"]) {
        if (userNameTextField.text.length >= 3 && string.length != 0) {
            return NO;
        }
    }else {
        
    }
    
    return YES;
}


//请求修改信息
-(void)buttonClick{
    if ([NSString isNOTNull:userNameTextField.text]) {
        [WXZTipView showCenterWithText:userNameTextField.placeholder];
        return;
    }
    if ([self.type isEqualToString:@"年龄"]) {
        if (([userNameTextField.text intValue]) > 100) {
            [WXZTipView showCenterWithText:@"年龄不能大于100！"];
            return ;
        }
    }else {
        if ((userNameTextField.text.length) > 5) {
            [WXZTipView showCenterWithText:@"昵称不能大于5位数"];
            return ;
        }
    }
    
    NSDictionary *parm = @{@"field":@"nickname",@"value":userNameTextField.text};
    
    if ([self.type isEqualToString:@"年龄"]) {
        parm =  @{@"field":@"member_age",@"value":userNameTextField.text};
    }
    [[WBPCreate sharedInstance]showWBProgress];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kCenterAdress(kSaveMemberBase) withParameters:parm withResultBlock:^(BOOL result, id value) {
        [[WBPCreate sharedInstance]hideAnimated];
        if (result) {
            if (self.modifiedSuccessfulBlock) {
                if ([self.type isEqualToString:@"年龄"]) {
                    int age = [self->userNameTextField.text intValue];
                    NSString *ageStr =  [NSString stringWithFormat:@"%d",age > 128 ? 127 : age];
                    self.modifiedSuccessfulBlock(ageStr);
                }else {
                    self.modifiedSuccessfulBlock(self->userNameTextField.text);
                }
            }
            [self.navigationController popViewControllerAnimated:YES];
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dataDic = value[@"data"];
                NSString *token = [dataDic safeObjectForKey:@"ucenter_token"];
                if (token && token.length > 0) {
                    [WXZTipView showCenterWithText:value[@"msg"]];
                    [[NSUserDefaults standardUserDefaults] setValue:token forKey:USER_TOKEN];
                    [userInfoModel getUserInfo];
                }else {
                    [WXZTipView showCenterWithText:@"资料修改成功,token获取失败"];
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



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
