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
#import "SetingMobilePhoneVC.h"//设置手机号
#import "ServiceAgreementVC.h"//注册i协议

#import "JMTabBarController.h"
#import "JMConfig.h"

#import "LoginForVercode.h"

//#import "UPWAuthPlugin.h"//银联登录
@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithUI];
//    [self setupNavBar];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.navigationController.navigationBar.hidden = YES;
        if (self.isChangeNewAccount) {
            WS(weakSelf);
            [super setupNavBar];
            [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
            self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
            [self.customNavBar setOnClickLeftButton:^{
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }];
            [self.customNavBar wr_setBottomLineHidden:YES];
            self.customNavBar.title = @"";
            self.customNavBar.titleLabelColor = [UIColor clearColor];
            self.customNavBar.backgroundColor = [UIColor clearColor];
        }else {
            self.customNavBar.hidden = YES;
        }
    });
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
-(void)setupNavBar{

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
    iconImageView.image = MMGetImage(@"logo_title");
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(ScreenScale(117));
        make.width.mas_equalTo(ScreenScale(155));
        make.height.mas_equalTo(ScreenScale(168));

    }];
    
    UIButton *loginBtn = [UIButton new];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(31)];
    loginBtn.backgroundColor = [UIColor redColor];
    [loginBtn setTitle:@"注册" forState:(UIControlStateNormal)];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [loginBtn addTarget:self action:@selector(registeredClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(ScreenScale(15));
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-ScreenScale(15));
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(ScreenScale(90));
        make.height.mas_equalTo(HeightRatio(90));
    }];
    MMViewBorderRadius(loginBtn, WidthRatio(45), 0, [UIColor clearColor]);
    
    UILabel *lin = [UILabel new];
    lin.textColor = HEX_COLOR(0xAAAAAA);
    lin.font = FONT(14);
    [self.view addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(ScreenScale(40));
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(ScreenScale(14));
        make.height.mas_equalTo(HeightRatio(21));
    }];
    
    lin.text = @"注册/登录即表示同意";
    UILabel *lin2 = [UILabel new];
    lin2.textColor = HEX_COLOR(0xCA1400);
    [self.view addSubview:lin2];
    [lin2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lin.mas_right);
        make.centerY.mas_equalTo(lin.mas_centerY);
        make.height.mas_equalTo(HeightRatio(21));
    }];
    lin2.font = FONT(14);
    lin2.text = @"《汉富商城用户注册协议》";
    lin2.userInteractionEnabled = YES;
    [lin2 wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        NSLog(@"协议");
//        NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"APP_agreement" ofType:@"doc"];
//        ServiceAgreementVC *serv = [[ServiceAgreementVC alloc]init];
//        serv.htmlPath = htmlPath;
//        serv.title = @"注册协议";
//        serv.row = 1;
        YYB_HF_WKWebVC *vc = [[YYB_HF_WKWebVC alloc]init];
        vc.urlString = kAppAgreement;
        vc.isTop = NO;
        vc.isNavigationHidden = YES;

        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    UILabel *fastLogin = [UILabel new];
    fastLogin.textColor = HEX_COLOR(0x0C0B0B);
    [self.view addSubview:fastLogin];
    [fastLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-123);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(ScreenScale(12));
    }];
    fastLogin.text = @"快捷登录";
    fastLogin.font = FONT(12);

    
    UIButton *WeChatBtn = [UIButton new];
    UIButton *phoneBtn = [UIButton new];
    UIButton *alipyBtn = [UIButton new];

    [self.view addSubview:WeChatBtn];
    [self.view addSubview:phoneBtn];
    [self.view addSubview:alipyBtn];

    WeChatBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(25)];
    [WeChatBtn setImage:MMGetImage(@"weixin") forState:(UIControlStateNormal)];
    
    [WeChatBtn addTarget:self action:@selector(loginWithWeChat) forControlEvents:(UIControlEventTouchUpInside)];
   
    
    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(25)];
    [phoneBtn setImage:MMGetImage(@"icon_phone") forState:(UIControlStateNormal)];
    
    [phoneBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-ScreenScale(50));
        make.width.mas_equalTo(ScreenScale(44));
        make.height.mas_equalTo(ScreenScale(44));
        make.centerX.mas_equalTo(self.view);
    }];
    [WeChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(phoneBtn.mas_left).offset(-ScreenScale(50));
        make.centerY.mas_equalTo(phoneBtn);
        make.width.mas_equalTo(ScreenScale(44));
        make.height.mas_equalTo(ScreenScale(44));
    }];
    
    alipyBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(25)];
    [alipyBtn setImage:MMGetImage(@"icon_alipy") forState:(UIControlStateNormal)];
    
    [alipyBtn addTarget:self action:@selector(loginWithAliPay) forControlEvents:(UIControlEventTouchUpInside)];
    [alipyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(phoneBtn.mas_right).offset(ScreenScale(50));
        make.centerY.mas_equalTo(phoneBtn);
        make.width.mas_equalTo(ScreenScale(44));
        make.height.mas_equalTo(ScreenScale(44));
    }];
    
}
//手机验证码登录
-(void)loginBtnClick{
    
    LoginForVercode *vc = [LoginForVercode new];
    vc.isChangeNewAccount = self.isChangeNewAccount;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)loginWithQQ {
    [[WBPCreate sharedInstance] showWBProgress];
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error){
               [[WBPCreate sharedInstance] hideAnimated];
               if (state == SSDKResponseStateSuccess){
                   [CommonTools setToken:@""];// !!!:三方登录 清空token
                   
                   //             NSDictionary *dataDict = @{@"type":@"qq",@"openId":user.uid,@"nickname":user.nickname,@"img":user.icon};
                   
                   NSDictionary *parm = @{@"openid":user.uid,@"nickname":user.nickname,@"user_headimg":user.icon,@"sex":@(user.gender)};
               }else{
                   NSLog(@"%@",error);
               }
           }];
}
-(void)loginWithWeChat{

    [[WBPCreate sharedInstance] showWBProgress];
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error){
               [[WBPCreate sharedInstance] hideAnimated];
               if (state == SSDKResponseStateSuccess){
                   
                   // !!!:三方登录 清空token
                   NSDictionary *dataDict = @{@"openid":user.uid,@"nickname":user.nickname,@"user_headimg":user.icon,@"sex":@(user.gender)};
                   [[WBPCreate sharedInstance] showWBProgress];
                   [networkingManagerTool requestToServerWithType:POST withSubUrl:kWXLogin withParameters:dataDict withResultBlock:^(BOOL result, id value) {
                       [[WBPCreate sharedInstance] hideAnimated];
                       if (result) {
                           NSDictionary *dict = value;
                           NSDictionary *dataDic = [dict safeObjectForKey:@"data"];
                           
                           NSString *ucenter_token = [dataDic safeObjectForKey:@"ucenter_token"];
                           
                           if (ucenter_token && [ucenter_token isKindOfClass:[NSString class]] && ucenter_token.length > 0) {
                               [[NSUserDefaults standardUserDefaults] setValue:[dataDic safeObjectForKey:@"ucenter_token"]  forKey:USER_TOKEN];
                               [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:LOGIN_STATES];
                               [[WBPCreate sharedInstance] showWBProgress];
                               [userInfoModel getUserInfo:^(id  _Nonnull result) {
                                   if (self.isChangeNewAccount) {
                                       
                                   }else {
                                       [LoginVC changeIndxHome];
                                   }
                                   [self dismissViewControllerAnimated:YES completion:nil];
                               }];
                           }else {
                               SetingMobilePhoneVC *vc = [[SetingMobilePhoneVC alloc]init];
                               vc.openIdStr = user.uid;
                               vc.loginType = LoginTypeWeiXin;
                               vc.isChangeNewAccount = self.isChangeNewAccount;
                               if ([self.navigationController.viewControllers.lastObject isKindOfClass:[LoginVC class]]) {
                                   [self.navigationController pushViewController:vc animated:YES];
                               }
                           }
                           
                       }else{
                           if (value && [value isKindOfClass:[NSDictionary class]]) {
                               [WXZTipView showCenterWithText:value[@"msg"]];
                           }else {
                               [WXZTipView showCenterWithText:@"网络请求错误"];
                           }
                       }
                   }];
               }else{
                   NSLog(@"error = %@",error);
               }
           }];
}

-(void)loginWithAliPay {
    
    [LoginVC aliPayInfo:^(NSString *authCode) {
        
        [[WBPCreate sharedInstance]showWBProgress];
        // !!!: 调取后台接口获取支付宝用户信息
        [networkingManagerTool requestToServerWithType:POST withSubUrl:kAlipayLogin withParameters:@{@"auth_code":authCode} withResultBlock:^(BOOL result, id value) {
            [[WBPCreate sharedInstance]hideAnimated];
            if (result) {
                if (value && [value isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dict = value;
                    NSDictionary *dataDic = [dict safeObjectForKey:@"data"];
                    
                    NSString *ucenter_token = [dataDic safeObjectForKey:@"ucenter_token"];
                    NSString *alipayOpenId = [dataDic safeObjectForKey:@"openid"];
                    
                    if (ucenter_token && [ucenter_token isKindOfClass:[NSString class]] && ucenter_token.length > 0) {
                        [[NSUserDefaults standardUserDefaults] setValue:[dataDic safeObjectForKey:@"ucenter_token"]  forKey:USER_TOKEN];
                        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:LOGIN_STATES];
                        [[WBPCreate sharedInstance] showWBProgress];
                        [userInfoModel getUserInfo:^(id  _Nonnull result) {
                            if (self.isChangeNewAccount) {
                                
                            }else {
                                [LoginVC changeIndxHome];
                            }
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }];
                    }else {
                        SetingMobilePhoneVC *vc = [[SetingMobilePhoneVC alloc]init];
                        vc.openIdStr = alipayOpenId;
                        vc.loginType = LoginTypeAliPay;
                        vc.isChangeNewAccount = self.isChangeNewAccount;
                        if ([self.navigationController.viewControllers.lastObject isKindOfClass:[LoginVC class]]) {
                            [self.navigationController pushViewController:vc animated:YES];
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
    }];
}

#pragma mark -  获取支付宝authCode
+ (void)aliPayInfo:(void (^)(NSString *authCode))authInfo {
    NSString *appScheme = @"hanFuLife";//@"你的appScheme";
    //authStr参数后台获取！和开发中心配置的app有关系，包含appid\name等等信息。
    __block NSString *authStr = @"";// @"apiname=com.alipay.account.auth&app_id=xxxxx&app_name=mc&auth_type=AUTHACCOUNT&biz_type=openservice&method=alipay.open.auth.sdk.code.get&pid=xxxxx&product_id=APP_FAST_LOGIN&scope=kuaijie&target_id=20141225xxxx&sign_type=RSA2&sign=fMcp4GtiM6rxSIeFnJCVePJKV43eXrUP86CQgiLhDHH2u%2FdN75eEvmywc2ulkm7qKRetkU9fbVZtJIqFdMJcJ9Yp%2BJI%2FF%2FpESafFR6rB2fRjiQQLGXvxmDGVMjPSxHxVtIqpZy5FDoKUSjQ2%2FILDKpu3%2F%2BtAtm2jRw1rUoMhgt0%3D";//@"后台获取的authStr";
    
    [[WBPCreate sharedInstance]showWBProgress];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kAlipayOauth withParameters:nil withResultBlock:^(BOOL result, id value) {
        [[WBPCreate sharedInstance]hideAnimated];
        if (result) {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                authStr = value[@"data"];
                if (authStr && [authStr isKindOfClass:[NSString class]] && authStr.length > 0) {
                    //没有安装支付宝客户端的跳到网页授权时会在这个方法里回调
                    [[AFAuthSDK defaultService] authv2WithInfo:authStr fromScheme:appScheme callback:^(NSDictionary *result) {
                        
                        NSString *status = result[@"resultStatus"];
                        if (status && [status intValue] == 9000) {
                            // 解析 auth code
                            NSString *resultString = result[@"result"];
                            NSString *authCode = nil;
                            if (resultString.length>0) {
                                if ([resultString containsString:@"success=true"] && [resultString containsString:@"result_code=200"]) {
                                    NSArray *resultArr = [resultString componentsSeparatedByString:@"&"];
                                    for (NSString *subResult in resultArr) {
                                        
                                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                            authCode = [subResult substringFromIndex:10];
                                            authInfo(authCode);
                                            break;
                                        }
                                    }
                                }
                            }
                            NSLog(@"resultString = %@",resultString);
                            NSLog(@"authv2WithInfo授权结果 authCode = %@", authCode?:@"");
                        }else {
                            NSString *str = @"授权失败";
                            if (result && [result isKindOfClass:[NSDictionary class]]) {
                                str = result[@"memo"];
                            }
                            [WXZTipView showCenterWithText:str];
                        }
                    }];
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

//注册
-(void)registeredClick{
    RegisteredVC *vc = [[RegisteredVC alloc]init];
    vc.isChangeNewAccount = self.isChangeNewAccount;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)forgotPasswordBtnClick{
    [self.navigationController pushViewController:[[ForgotPasswordVC alloc]init] animated:YES];
}


/** 跳转登录 */
+ (void)login{
    //跳转登录
    
    Class loginClass = NSClassFromString(@"LoginVC");
    id loginVC = [[loginClass alloc] init];
    if (loginVC) {
        UIViewController *currentVC = [NSObject getCurrentViewController];
        if ([currentVC.navigationController.rootViewController class] != loginClass) {
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:USER_TOKEN];
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:LOGIN_STATES];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERINFO_DATA];
            [userInfoModel attempDealloc];
            BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
            [currentVC presentViewController:navi animated:YES completion:nil];
        }
    }else{
        
        [CustomPromptBox showTextHud:@"您还未创建登录VC"];
    }
}

+ (void)changeIndxHome{
    [JMConfig config].selectedIndex = 0;
    
}

@end
