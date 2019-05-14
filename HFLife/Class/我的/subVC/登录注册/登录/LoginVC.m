//
//  LoginVC.m
//  HanPay
//
//  Created by mac on 2019/1/17.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "LoginVC.h"
#import <ShareSDK/ShareSDK.h>
//VC
#import "RegisteredVC.h"
#import "ForgotPasswordVC.h"
//#import "HP_LoginNetApi.h"
//#import "HP_ThirdPartyLoginNetApi.h"

#import "ReviseMobilePhone.h"//设置手机号
@interface LoginVC ()
@property (nonatomic,strong)UITextField *userName;
@property (nonatomic,strong)UITextField *passwordText;
@end

@implementation LoginVC

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
    UIImageView *iconImageView = [UIImageView new];
    iconImageView.image = MMGetImage(@"logo");
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(HeightRatio(160)+self.heightStatus);
        make.width.height.mas_equalTo(WidthRatio(130));
    }];
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"欢迎登录汉富新生活";
    titleLabel.font = [UIFont systemFontOfSize:WidthRatio(40)];
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(HeightRatio(65));
        make.height.mas_equalTo(HeightRatio(40));
    }];
    [self.view addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(99));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(92));
        make.height.mas_equalTo(HeightRatio(82));
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(HeightRatio(52));
    }];
    [self.view addSubview:self.passwordText];
    [self.passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(99));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(92));
        make.height.mas_equalTo(HeightRatio(82));
        make.top.mas_equalTo(self.userName.mas_bottom).offset(HeightRatio(26));
    }];
    
    UIButton *forgotPasswordBtn = [UIButton new];
    forgotPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(23)];
    [forgotPasswordBtn setTitle:@"忘记密码 ？" forState:(UIControlStateNormal)];
    [forgotPasswordBtn setTitleColor:HEX_COLOR(0x656565) forState:(UIControlStateNormal)];
    [forgotPasswordBtn addTarget:self action:@selector(forgotPasswordBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:forgotPasswordBtn];
    [forgotPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userName.mas_left);
        make.top.mas_equalTo(self.passwordText.mas_bottom).offset(HeightRatio(45));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_equalTo(HeightRatio(23));
    }];
    
    UIButton *registeredBtn = [UIButton new];
    registeredBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(23)];
    [registeredBtn setTitle:@"还没有账号，去注册" forState:(UIControlStateNormal)];
    [registeredBtn setTitleColor:HEX_COLOR(0x656565) forState:(UIControlStateNormal)];
    [registeredBtn addTarget:self action:@selector(registeredClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:registeredBtn];
    [registeredBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.userName.mas_right);
        make.top.mas_equalTo(self.passwordText.mas_bottom).offset(HeightRatio(45));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_equalTo(HeightRatio(23));
    }];
    
    UIButton *loginBtn = [UIButton new];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(31)];
    loginBtn.backgroundColor = [UIColor redColor];
    [loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userName.mas_left);
        make.right.mas_equalTo(self.userName.mas_right);
        make.top.mas_equalTo(self.passwordText.mas_bottom).offset(HeightRatio(160));
        make.height.mas_equalTo(HeightRatio(90));
    }];
    MMViewBorderRadius(loginBtn, WidthRatio(45), 0, [UIColor clearColor]);
    
    UILabel *lin = [UILabel new];
    lin.backgroundColor = HEX_COLOR(0xdddddd);
    [self.view addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userName.mas_left);
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(HeightRatio(97));
        make.width.mas_equalTo(WidthRatio(194));
        make.height.mas_equalTo(HeightRatio(3));
    }];
    
    UILabel *la =[UILabel new];
    la.text = @"第三方登录";
    la.font = [UIFont systemFontOfSize:WidthRatio(21)];
    la.textColor = HEX_COLOR(0x828282);
    [self.view addSubview:la];
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(lin.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_equalTo(HeightRatio(21));
    }];
    
    UILabel *lin2 = [UILabel new];
    lin2.backgroundColor = HEX_COLOR(0xdddddd);
    [self.view addSubview:lin2];
    [lin2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(la.mas_right).offset(WidthRatio(33));
        make.centerY.mas_equalTo(lin.mas_centerY);
        make.width.mas_equalTo(WidthRatio(194));
        make.height.mas_equalTo(HeightRatio(3));
    }];
    
    UIButton *QQBtn = [UIButton new];
    QQBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(25)];
    [QQBtn setImage:MMGetImage(@"QQ") forState:(UIControlStateNormal)];
    [QQBtn setTitle:@"QQ登录" forState:(UIControlStateNormal)];
    [QQBtn setTitleColor:HEX_COLOR(0x828282) forState:(UIControlStateNormal)];
    [QQBtn setImagePosition:ImagePositionTypeLeft spacing:ScreenScale(15)];
    
    [QQBtn addTarget:self action:@selector(loginWithQQ) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:QQBtn];
    [QQBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(162));
        make.top.mas_equalTo(la.mas_bottom).offset(HeightRatio(54));
        make.width.mas_equalTo(WidthRatio(153));
        make.height.mas_equalTo(HeightRatio(57));
    }];
    
    UIButton *WeChatBtn = [UIButton new];
    WeChatBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(25)];
    [WeChatBtn setImage:MMGetImage(@"weixin") forState:(UIControlStateNormal)];
    [WeChatBtn setTitle:@"微信登录" forState:(UIControlStateNormal)];
    [WeChatBtn setTitleColor:HEX_COLOR(0x828282) forState:(UIControlStateNormal)];
    [WeChatBtn setImagePosition:ImagePositionTypeLeft spacing:ScreenScale(15)];
    
    [WeChatBtn addTarget:self action:@selector(loginWithWeChat) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:WeChatBtn];
    [WeChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(150));
        make.top.mas_equalTo(la.mas_bottom).offset(HeightRatio(54));
        make.width.mas_equalTo(WidthRatio(188));
        make.height.mas_equalTo(HeightRatio(57));
    }];
    
    lin.hidden = YES;
    la.hidden = YES;
    lin2.hidden = YES;
    QQBtn.hidden = YES;
    WeChatBtn.hidden = YES;
}

-(UITextField *)userName{
    if (_userName == nil) {
        UITextField *tf = [[UITextField alloc] init];
            //        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.keyboardType = UIKeyboardTypeTwitter;
        tf.placeholder = @"请输入手机号/用户名";
        [tf setValue:HEX_COLOR(0x5b5b5b) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x5b5b5b);
        tf.font = [UIFont systemFontOfSize:HeightRatio(32)];
        tf.backgroundColor = [UIColor clearColor];
        
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(48), HeightRatio(82))];
        lv.backgroundColor = [UIColor clearColor];
        
        UIImageView *iconImageView = [UIImageView new];
        iconImageView.image = MMGetImage(@"shouji");
        [lv addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lv.mas_left);
            make.centerY.mas_equalTo(lv.mas_centerY);
            make.width.mas_equalTo(WidthRatio(22));
            make.height.mas_equalTo(HeightRatio(30));
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
    return _userName;
}
-(UITextField *)passwordText{
    if (!_passwordText) {
        UITextField *tf = [[UITextField alloc] init];
            //        tf.keyboardType = UIKeyboardTypeASCIICapable;
        tf.keyboardType = UIKeyboardTypeTwitter;
        tf.placeholder = @"请输入您的密码";
        [tf setValue:HEX_COLOR(0x5b5b5b) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x5b5b5b);
        tf.secureTextEntry = YES;
        tf.font = [UIFont systemFontOfSize:HeightRatio(32)];
        tf.backgroundColor = [UIColor clearColor];
        
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(48), HeightRatio(82))];
        lv.backgroundColor = [UIColor clearColor];
        
        UIImageView *iconImageView = [UIImageView new];
        iconImageView.image = MMGetImage(@"mima");
        [lv addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lv.mas_left);
            make.centerY.mas_equalTo(lv.mas_centerY);
            make.width.mas_equalTo(WidthRatio(25));
            make.height.mas_equalTo(HeightRatio(30));
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
        [self.view addSubview:tf];
        _passwordText = tf;
    }
    return _passwordText;
}
-(void)loginBtnClick{
    if ([NSString isNOTNull:self.userName.text]) {
        [WXZTipView showCenterWithText:@"请输入用户名"];
        return;
    }
    if ([NSString isNOTNull:self.passwordText.text]) {
        [WXZTipView showCenterWithText:@"请输入密码"];
        return;
    }
    
    
    
    /*
    
    
    HP_LoginNetApi *loginNetApi  = [[HP_LoginNetApi alloc]initWithParameter:@{@"account":self.userName.text,@"password":self.passwordText.text}];
    [loginNetApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_LoginNetApi *loginRequest = (HP_LoginNetApi *)request;
        if ([loginRequest getCodeStatus] == 1) {
            NSDictionary *dict = [loginRequest getContent];
            [HeaderToken setToken:dict[@"token"]];
            [CommonTools setToken:dict[@"token"]];
            [UserCache setUserPhone:self.userName.text];
            [UserCache setUserPass:self.passwordText.text];
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
-(void)loginWithQQ{
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error){
         if (state == SSDKResponseStateSuccess){
             [CommonTools setToken:@""];// !!!:三方登录 清空token

             NSDictionary *dataDict = @{@"type":@"qq",@"openId":user.uid,@"nickname":user.nickname,@"img":user.icon};
             
             
             
             /*
             
             
             HP_ThirdPartyLoginNetApi *thirdParty = [[HP_ThirdPartyLoginNetApi alloc]initWithParameter:dataDict];
             [thirdParty startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                 HP_ThirdPartyLoginNetApi *thirdPartyRequest = (HP_ThirdPartyLoginNetApi *)request;
                 if ([thirdPartyRequest getCodeStatus] == 1) {
                     NSDictionary *dict = [thirdPartyRequest getContent];
                    
                     NSString *user_mobile = dict[@"user_mobile"];
                     if (user_mobile && [user_mobile isKindOfClass:[NSString class]] && user_mobile.length > 0) {
                         [HeaderToken setToken:dict[@"token"]];
                         [CommonTools setToken:dict[@"token"]];
                         [self.navigationController popToRootViewControllerAnimated:YES];
                     }else {
                         ReviseMobilePhone *vc = [[ReviseMobilePhone alloc]init];
                         vc.tokenStr = dict[@"token"];
                         vc.setPhoneNumOk = ^(NSString * _Nonnull phoneNum) {
                             [HeaderToken setToken:dict[@"token"]];
                             [CommonTools setToken:dict[@"token"]];
                             [self.navigationController popToRootViewControllerAnimated:YES];
                         };
                         [self.navigationController pushViewController:vc animated:YES];
                     }
                     
                 }else{
                     [WXZTipView showCenterWithText:[thirdPartyRequest getMsg]];
                 }
             } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                 HP_ThirdPartyLoginNetApi *thirdPartyRequest = (HP_ThirdPartyLoginNetApi *)request;
                 [WXZTipView showCenterWithText:[thirdPartyRequest getMsg]];
             }];
              
              
              */
             
         }else{
             NSLog(@"%@",error);
         }
     }];
}
-(void)loginWithWeChat{

    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error){
               if (state == SSDKResponseStateSuccess){
                   
                   [CommonTools setToken:@""];// !!!:三方登录 清空token

                   
                   NSDictionary *dataDict = @{@"type":@"wx",@"openId":user.uid,@"nickname":user.nickname,@"img":user.icon};
                   
                   
                   /*
                   
                   
                   HP_ThirdPartyLoginNetApi *thirdParty = [[HP_ThirdPartyLoginNetApi alloc]initWithParameter:dataDict];
                   [thirdParty startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                       HP_ThirdPartyLoginNetApi *thirdPartyRequest = (HP_ThirdPartyLoginNetApi *)request;
                       if ([thirdPartyRequest getCodeStatus] == 1) {
                           NSDictionary *dict = [thirdPartyRequest getContent];
                          
                           NSString *user_mobile = dict[@"user_mobile"];
                           if (user_mobile && [user_mobile isKindOfClass:[NSString class]] && user_mobile.length > 0) {
                               [HeaderToken setToken:dict[@"token"]];
                               [CommonTools setToken:dict[@"token"]];
                               [self.navigationController popToRootViewControllerAnimated:YES];
                           }else {
                               ReviseMobilePhone *vc = [[ReviseMobilePhone alloc]init];
                               vc.tokenStr = dict[@"token"];
                               vc.setPhoneNumOk = ^(NSString * _Nonnull phoneNum) {
                                   [HeaderToken setToken:dict[@"token"]];
                                   [CommonTools setToken:dict[@"token"]];
                                   [self.navigationController popToRootViewControllerAnimated:YES];
                               };
                               [self.navigationController pushViewController:vc animated:YES];
                           }
                          
                       }else{
                           [WXZTipView showCenterWithText:[thirdPartyRequest getMsg]];
                       }
                   } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                       HP_ThirdPartyLoginNetApi *thirdPartyRequest = (HP_ThirdPartyLoginNetApi *)request;
                       [WXZTipView showCenterWithText:[thirdPartyRequest getMsg]];
                   }];
                    
                    
                    */
                    
                    
               }else{
                   NSLog(@"error = %@",error);
               }
           }];
}
-(void)registeredClick{
    [self.navigationController pushViewController:[[RegisteredVC alloc]init] animated:YES];
}
-(void)forgotPasswordBtnClick{
    [self.navigationController pushViewController:[[ForgotPasswordVC alloc]init] animated:YES];
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
