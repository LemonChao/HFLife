
//
//  SXF_HF_exchangePhoneVc.m
//  HFLife
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_exchangePhoneVc.h"

@interface SXF_HF_exchangePhoneVc ()
@property (weak, nonatomic) IBOutlet UIButton *configerBtn;

@end

@implementation SXF_HF_exchangePhoneVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"更换手机号";
    self.configerBtn.enabled = NO;
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
    [sender setTheCountdownStartWithTime:60 title:@"重新获取" countDownTitle:@"s" mainColor:[UIColor whiteColor] countColor:[UIColor whiteColor]];
}

@end
