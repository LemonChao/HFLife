
//
//  SXF_HF_bindingAccount.m
//  HFLife
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_bindingAccount.h"
#import "SXF_HF_exchangePhoneVc.h"
@interface SXF_HF_bindingAccount ()

@end

@implementation SXF_HF_bindingAccount

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"关联账号";
}

//微信
- (IBAction)tapWechatCell:(UITapGestureRecognizer *)sender {
    [SXF_HF_AlertView showAlertType:AlertType_binding Complete:^(BOOL btnBype) {
    }];
}

//支付宝
- (IBAction)tapAlipyCell:(UITapGestureRecognizer *)sender {
    [SXF_HF_AlertView showAlertType:AlertType_binding Complete:^(BOOL btnBype) {
    }];
}

//手机号
- (IBAction)tapPhoneCell:(UITapGestureRecognizer *)sender {
    SXF_HF_exchangePhoneVc *exchangePhoneVC = [SXF_HF_exchangePhoneVc new];
    [self.navigationController pushViewController:exchangePhoneVC animated:YES];
}

@end
