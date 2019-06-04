
//
//  SXF_HF_GetMoneyVC.m
//  HFLife
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_GetMoneyVC.h"
#import "SXF_HF_GetMoneyView.h"
#import "receiptRecordListVC.h"
#import "SetAmountVC.h"
#import "BarCodeView.h"
#import "SXF_HF_payStepAleryView.h"
#import "SXF_HF_payMoneyPawordVC.h"
@interface SXF_HF_GetMoneyVC ()<SetAmountDelegate>
@property (nonatomic, strong)SXF_HF_GetMoneyView *getMoneyView;
@end

@implementation SXF_HF_GetMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = self.payType ? @"收钱" : @"向商家付款";
    [self setUpUI];
    
    [self loadServerData];
    
}
- (void)loadServerData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (self.payType) {
        //收钱
        [param setValue:@"1" forKey:@"type"];
        //需要设置金额的时候 穿这个参数
//        [param setValue:@"100" forKey:@"set_money"];
    }else{
        //付款
        [param setValue:@"2" forKey:@"type"];
        
    }

    [networkingManagerTool requestToServerWithType:POST withSubUrl:CreateMoneyQrcode withParameters:param withResultBlock:^(BOOL result, id value) {\
        if ([value isKindOfClass:[NSDictionary class]]) {
            if (result){
                NSLog(@"%@", value);
                if ([value[@"data"] isKindOfClass:[NSDictionary class]]) {
                    if (value[@"data"][@"show_code"]) {
                        //临时数据
                        [self.getMoneyView setDataForView:value[@"data"][@"show_code"] type:NO];
                    }
                }
            }else{
                [WXZTipView showCenterWithText:value[@"msg"]];
            }
        }
        
    } witnVC:self];
}



- (void)setUpUI{
    self.getMoneyView  = [[SXF_HF_GetMoneyView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];
    [self.view addSubview:self.getMoneyView];
    self.getMoneyView.payType = self.payType;
    WEAK(weakSelf);
    self.getMoneyView.tabBtnCallback = ^(NSInteger index) {
        NSLog(@"%ld", index);
        
        __block BaseViewController *vc ;
        
        if (!weakSelf.payType) {
            //向商家付钱
            if (index == 2) {
                //余额支付
                SXF_HF_payStepAleryView *payAlert = [SXF_HF_payStepAleryView showAlertComplete:^(BOOL btnBype) {
                    
                } password:^(NSString * _Nonnull pwd) {
                    
                }];
                payAlert.payStepCallback = ^(NSIndexPath * _Nonnull indexP) {
                    //第几步
                    
                    NSLog(@"选择s的是%ld", (long)indexP.row);
                    
                    //test 密码也
                    SXF_HF_payMoneyPawordVC *pswVC = [SXF_HF_payMoneyPawordVC new];
                    [weakSelf.navigationController pushViewController:pswVC animated:YES];
                    
                };
                payAlert.payStep = 1;
            }else if (index == 3){
                //付款记录
                receiptRecordListVC *recordVC = [[receiptRecordListVC alloc] init];
                recordVC.payType = NO;
                vc = recordVC;
            }else{
                
            }
        }else{
            if (index == 0) {
                //设置金额
                SetAmountVC *setAmVC = [SetAmountVC new];
                vc = setAmVC;
                setAmVC.amountDelegate = weakSelf;
            }else if (index == 2){
                //收款记录
                receiptRecordListVC *recordVC = [[receiptRecordListVC alloc] init];
                recordVC.payType = YES;
                vc = recordVC;
            }else if (index == 3){
                //正在付款z。。。。
            }else if (index == 4){
                //商家入驻
            }
        }
        if (vc) {
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    
    //点击条形码 旋转
    self.getMoneyView.clickBarCodeImageV = ^(UIImage * _Nonnull image, NSString *codeStr) {
        BarCodeView *codeview =[[BarCodeView alloc]initImage:image withCodeStr:codeStr];
        [weakSelf.view addSubview:codeview];
    };
    
    
    [self.customNavBar wr_setRightButtonWithImage:MY_IMAHE(@"更多")];
    [self.customNavBar setOnClickRightButton:^{
        [SXF_HF_AlertView showAlertType:AlertType_topRight Complete:^(BOOL btnBype) {
            if (btnBype) {
                //收款码介绍
//                BaseViewController *vc = [BaseViewController new];
//                vc.customNavBar.title = @"收款码介绍";
//                [weakSelf.navigationController pushViewController:vc animated:YES];
                SXF_HF_WKWebViewVC *webVC = [SXF_HF_WKWebViewVC new];
                webVC.urlString = SXF_WEB_URLl_Str(reCodeIntroduction);
                [weakSelf.navigationController pushViewController:webVC animated:YES];
            }else{
                //开启或关闭到账通知
                setGetMoneyStatus(!OpenMoneyNotiStatus)
                [WXZTipView showCenterWithText:OpenMoneyNotiStatus ? @"已开启" : @"已关闭"];
                
            }
            
        }];
    }];
}

#pragma mark 代理
-(void)SetAmountNumber:(NSString *)amount{
    [self.getMoneyView setDataForView:[RSAEncryptor encryptString:MMNSStringFormat(@"HanPay:%@,UserID:%@",amount,[userInfoModel sharedUser].ID) publicKey:AMOUNTRSAPRIVATEKEY] type:YES];
}


@end
