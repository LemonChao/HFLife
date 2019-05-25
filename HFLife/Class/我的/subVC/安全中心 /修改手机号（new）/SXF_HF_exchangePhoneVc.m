
//
//  SXF_HF_exchangePhoneVc.m
//  HFLife
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_exchangePhoneVc.h"

@interface SXF_HF_exchangePhoneVc () {
    BOOL changeNum;
}
@property (weak, nonatomic) IBOutlet UIButton *configerBtn;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextF;
@property (strong, nonatomic) IBOutlet UITextField *verCodeTextf;
@property(nonatomic, strong) UIButton *verBtn;//验证码按钮
@end

@implementation SXF_HF_exchangePhoneVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"更换手机号";
    self.configerBtn.enabled = NO;
    self.phoneNumLabel.text = [[userInfoModel sharedUser].member_mobile EncodeTel];
    changeNum = NO;
}




- (IBAction)subMitBtnClick:(UIButton *)sender {
    
    if (self.verCodeTextf.text.length == 0) {
        [WXZTipView showCenterWithText:@"请输入验证码"];
        return;
    }
    
    if (!changeNum) {
        //验证旧手机号
        [[WBPCreate sharedInstance]showWBProgress];
        [networkingManagerTool requestToServerWithType:POST withSubUrl:kCheckMobile_security withParameters:@{@"captcha":self.verCodeTextf.text} withResultBlock:^(BOOL result, id value) {
            [[WBPCreate sharedInstance]hideAnimated];
            if (result) {
                if (value && [value isKindOfClass:[NSDictionary class]]) {
                    self.verCodeTextf.text = @"";
                    [self.phoneTextF setHidden:NO];
                    [self.verBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                    self->changeNum = YES;
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
    else {
        //修改手机号
        [[WBPCreate sharedInstance]showWBProgress];
        [networkingManagerTool requestToServerWithType:POST withSubUrl:kChangemobile withParameters:@{@"mobile":self.phoneTextF.text,@"captcha":self.verCodeTextf.text} withResultBlock:^(BOOL result, id value) {
            [[WBPCreate sharedInstance]hideAnimated];
            if (result) {
                //
                if (value && [value isKindOfClass:[NSDictionary class]]) {
                    [WXZTipView showCenterWithText:@"修改成功"];
                    NSString *token = [value safeObjectForKey:@"ucenter_token"];
                    if (token && [token isKindOfClass:[NSString class]] && token.length > 0) {
                        [[NSUserDefaults standardUserDefaults]setValue:token forKey:USER_TOKEN];
                        [userInfoModel sharedUser].member_mobile = self.phoneTextF.text;
                        [self.navigationController popViewControllerAnimated:YES];
                    }else {
                        [WXZTipView showCenterWithText:@"未获取到token"];
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
}


- (IBAction)phoneTF:(UITextField *)sender {
    if (sender.text.length == 0) {
        self.configerBtn.backgroundColor = colorAAAAAA;
        self.configerBtn.enabled = NO;
    }else{
        self.configerBtn.backgroundColor = colorCA1400;
        self.configerBtn.enabled = YES;
    }
}


- (IBAction)authCodeBtnClick:(UIButton *)sender {
    
    if (!changeNum) {
        //验证手机号
        [[WBPCreate sharedInstance]showWBProgress];
        [networkingManagerTool requestToServerWithType:POST withSubUrl:kSendsms withParameters:@{@"mobile":[userInfoModel sharedUser].member_mobile,@"event":@"checkmobile"} withResultBlock:^(BOOL result, id value) {
            [[WBPCreate sharedInstance]hideAnimated];
            if (result) {
                if (value && [value isKindOfClass:[NSDictionary class]]) {
                    
                }
                
            }else {
                if (value && [value isKindOfClass:[NSDictionary class]]) {
                    [WXZTipView showCenterWithText:value[@"msg"]];
                }else {
                    [WXZTipView showCenterWithText:@"网络错误"];
                }
            }
        }];
    }else {
        //注销手机号
        [[WBPCreate sharedInstance]showWBProgress];
        [networkingManagerTool requestToServerWithType:POST withSubUrl:kSendsms withParameters:@{@"mobile":self.phoneTextF.text,@"event":@"changemobile"} withResultBlock:^(BOOL result, id value) {
            [[WBPCreate sharedInstance]hideAnimated];
            if (result) {
                if (value && [value isKindOfClass:[NSDictionary class]]) {
                    
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
    [sender setTheCountdownStartWithTime:60 title:@"重新获取" countDownTitle:@"s" mainColor:[UIColor whiteColor] countColor:[UIColor whiteColor]];
}

@end
