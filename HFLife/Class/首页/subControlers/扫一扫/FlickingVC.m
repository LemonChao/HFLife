//
//  FlickingVC.m
//  HFLife
//
//  Created by sxf on 2019/1/18.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "FlickingVC.h"
#import "SGQRCode.h"
#import "MBProgressHUD+SGQRCode.h"
#import "RSAEncryptor.h"
#import "TransferVC.h"
#import "WKWebViewController.h"
#import "SXF_HF_PayVC.h"//付款
#import "SXF_HF_GetMoneyVC.h"//收款
#import "HF_PayHelp.h"
@interface FlickingVC () {
    SGQRCodeObtain *obtain;
}
@property (nonatomic, strong) SGQRCodeScanView *scanView;
@property (nonatomic, strong) UIButton *flashlightBtn;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, assign) BOOL isSelectedFlashlightBtn;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation FlickingVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        /// 二维码开启方法
    [obtain startRunningWithBefore:nil completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanView addTimer];
    
    
    //禁用第三方键盘
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = NO; // 控制整个功能是否启用
    
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //开启第三方键盘
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanView removeTimer];
    [self removeFlashlightBtn];
    [obtain stopRunning];
}

- (void)dealloc {
    NSLog(@"WCQRCodeVC - dealloc");
    [self removeScanningView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor blackColor];
    obtain = [SGQRCodeObtain QRCodeObtain];
    [self setupQRCodeScan];
    [self setupNavigationBar];
    [self.view addSubview:self.scanView];
    [self.view addSubview:self.promptLabel];
        /// 为了 UI 效果
    [self.view addSubview:self.bottomView];
}

- (void)setupQRCodeScan {
    __weak typeof(self) weakSelf = self;
    
    SGQRCodeObtainConfigure *configure = [SGQRCodeObtainConfigure QRCodeObtainConfigure];
    configure.sampleBufferDelegate = YES;
    [obtain establishQRCodeObtainScanWithController:self configure:configure];
    [obtain setBlockWithQRCodeObtainScanResult:^(SGQRCodeObtain *obtain, NSString *result) {
        if (result) {
            [MBProgressHUD SG_showMBProgressHUDWithModifyStyleMessage:@"正在处理..." toView:weakSelf.view];
            [obtain stopRunning];
            [obtain playSoundName:@"SGQRCode.bundle/sound.caf"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"result = %@",result);
                [MBProgressHUD SG_hideHUDForView:weakSelf.view];
                NSString *code = @"";
                if ([result containsString:@"http"] || [result containsString:@"https"]) {
                    NSArray *array = [result componentsSeparatedByString:@"show_code="];
                    if (array.count > 1) {
                        code = array[1];
                    }
                    if (code.length == 0) {
                        SXF_HF_WKWebViewVC *webVC = [SXF_HF_WKWebViewVC new];
                        webVC.urlString = result;
                        [weakSelf.navigationController pushViewController:webVC animated:YES];
                        return ;
                    }
                    
                }else{
                    code = result;
                }
                
                if([result containsString:@"itunes.apple.com"]) {
                    NSLog(@"str1包含str2");
                    //跳转到appleStore
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:result]];
                } else {
                    
                    NSLog(@"str1不包含str2");
                    [weakSelf decodingString:code];
                }
            });
        }
    }];
    [obtain setBlockWithQRCodeObtainScanBrightness:^(SGQRCodeObtain *obtain, CGFloat brightness) {
        if (brightness < - 1) {
            [weakSelf.view addSubview:weakSelf.flashlightBtn];
        } else {
            if (weakSelf.isSelectedFlashlightBtn == NO) {
                [weakSelf removeFlashlightBtn];
            }
        }
    }];
}

- (void)setupNavigationBar {
    self.customNavBar.title = @"扫一扫";
    WEAK(weakSelf);
    [self.customNavBar wr_setRightButtonWithTitle:@"相册" titleColor:[UIColor blackColor]];
    self.customNavBar.onClickRightButton = ^{
        [weakSelf rightBarButtonItenAction];
    };

}

- (void)rightBarButtonItenAction {
    __weak typeof(self) weakSelf = self;
    
    [obtain establishAuthorizationQRCodeObtainAlbumWithController:nil];
    if (obtain.isPHAuthorization == YES) {
        [self.scanView removeTimer];
    }
    [obtain setBlockWithQRCodeObtainAlbumDidCancelImagePickerController:^(SGQRCodeObtain *obtain) {
        [weakSelf.view addSubview:weakSelf.scanView];
    }];
    [obtain setBlockWithQRCodeObtainAlbumResult:^(SGQRCodeObtain *obtain, NSString *result) {
        [MBProgressHUD SG_showMBProgressHUDWithModifyStyleMessage:@"正在处理..." toView:weakSelf.view];
        
        
        
        if (result == nil) {
            NSLog(@"暂未识别出二维码");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD SG_hideHUDForView:weakSelf.view];
                [MBProgressHUD SG_showMBProgressHUDWithOnlyMessage:@"未发现二维码/条形码" delayTime:1.0];
            });
        } else {
//            ScanSuccessJumpVC *jumpVC = [[ScanSuccessJumpVC alloc] init];
//            jumpVC.comeFromVC = ScanSuccessJumpComeFromWC;
//            if ([result hasPrefix:@"http"]) {
//                jumpVC.jump_URL = result;
//            } else {
//                jumpVC.jump_bar_code = result;
//            }
           
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD SG_hideHUDForView:weakSelf.view];
                [weakSelf decodingString:result];
//                NSString *amoubt = [RSAEncryptor decryptString:result privateKey:AMOUNTRSAPUBLICKEY];
//                if ([amoubt containsString:@"HanPay:"]) {
//                    NSArray *array = [amoubt componentsSeparatedByString:@","];
//                    NSString *str1 = array[0];
//                    NSString *str2 = array[1];
//                    NSString *amoubtStr = [str1 substringFromIndex:7];
//                    NSString *userID = [str2 substringFromIndex:7];
//                    TransferVC *tran = [[TransferVC alloc]init];
//                    tran.amount = amoubtStr;
//                    tran.userID = userID;
//                    [weakSelf.navigationController pushViewController:tran animated:YES];
//                }else if ([amoubt containsString:@"HanPay_Merchants:"]){
//                    [WXZTipView showCenterWithText:@"该二维码只适用商户进行扫码"];
//                    [weakSelf.navigationController popViewControllerAnimated:YES];
//                }else{
//                    [WXZTipView showCenterWithText:@"无效的二维码"];
//                    [weakSelf.navigationController popViewControllerAnimated:YES];
//                }
            });
        }
    }];
}



- (SGQRCodeScanView *)scanView {
    if (!_scanView) {
        _scanView = [[SGQRCodeScanView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.9 * self.view.frame.size.height)];
    }
    return _scanView;
}
- (void)removeScanningView {
    [self.scanView removeTimer];
    [self.scanView removeFromSuperview];
    self.scanView = nil;
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.backgroundColor = [UIColor clearColor];
        CGFloat promptLabelX = 0;
        CGFloat promptLabelY = 0.73 * self.view.frame.size.height;
        CGFloat promptLabelW = self.view.frame.size.width;
        CGFloat promptLabelH = 25;
        _promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _promptLabel.text = @"将二维码/条码放入框内, 即可自动扫描";
    }
    return _promptLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scanView.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.scanView.frame))];
        _bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _bottomView;
}

#pragma mark - - - 闪光灯按钮
- (UIButton *)flashlightBtn {
    if (!_flashlightBtn) {
            // 添加闪光灯按钮
        _flashlightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        CGFloat flashlightBtnW = 30;
        CGFloat flashlightBtnH = 30;
        CGFloat flashlightBtnX = 0.5 * (self.view.frame.size.width - flashlightBtnW);
        CGFloat flashlightBtnY = 0.55 * self.view.frame.size.height;
        _flashlightBtn.frame = CGRectMake(flashlightBtnX, flashlightBtnY, flashlightBtnW, flashlightBtnH);
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightOpenImage"] forState:(UIControlStateNormal)];
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightCloseImage"] forState:(UIControlStateSelected)];
        [_flashlightBtn addTarget:self action:@selector(flashlightBtn_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashlightBtn;
}

- (void)flashlightBtn_action:(UIButton *)button {
    if (button.selected == NO) {
        [obtain openFlashlight];
        self.isSelectedFlashlightBtn = YES;
        button.selected = YES;
    } else {
        [self removeFlashlightBtn];
    }
}

- (void)removeFlashlightBtn {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self->obtain closeFlashlight];
        self.isSelectedFlashlightBtn = NO;
        self.flashlightBtn.selected = NO;
        [self.flashlightBtn removeFromSuperview];
    });
}

-(void)decodingString:(NSString *)string{
    WS(weakSelf);
    //扫描到w二维码后 获取对方的用户信息用以显示
    [networkingManagerTool requestToServerWithType:POST withSubUrl:SXF_LOC_URL_STR(GetQrcodeInfo) withParameters:@{@"code_str":string, @"app_type" : @"1"} withResultBlock:^(BOOL result, id value) {
//        [HF_PayHelp goWXPay:string];
//        return;
        if (result && value) {
            //二维码类型：0本站链接 1收款码 2付款码
            if (value[@"data"][@"type"]) {
                NSString *type = [NSString stringWithFormat:@"%@", value[@"data"][@"type"]];
                if ([type isEqualToString:@"0"]) {
                    //加载页面
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString judgeNullReturnString:string]]];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    
                }else{
                    
                    SXF_HF_PayVC *payVC = [SXF_HF_PayVC new];
                    //获取到对方的用户信息
                    NSString *userName = value[@"data"][@"member_truename"];
                    if (userName && userName.length > 0) {
                        payVC.payName = [userName stringByReplacingCharactersInRange:NSMakeRange(userName.length - 1, 1) withString:@"*"];
                    }
                    NSString *headerUrl = value[@"data"][@"member_avatar"];
                    payVC.payHeaderUrl = headerUrl;
                    payVC.codeStr = string;
                    
                    if ([type integerValue] == 1) {
                        //去付款
                        payVC.payType = YES;
                        payVC.payMoney = value[@"data"][@"set_money"];
                    }else if([type integerValue] == 2){
                        //我要收款  跳转到 输入金额 收款界面
                        payVC.payType = NO;
                        
                        [WXZTipView showCenterWithText:@"功能暂未开通"];
                        [self.navigationController popViewControllerAnimated:YES];
                        return ;
                        
                    }
                    //扫描的是收款码信息 跳转到付款界面
                    [weakSelf.navigationController pushViewController:payVC animated:YES];
                }
                
            }
        }
    }];
}



//微信打开url





@end
