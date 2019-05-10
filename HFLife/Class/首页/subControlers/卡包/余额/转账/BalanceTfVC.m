//
//  BalanceTfVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/4/16.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "BalanceTfVC.h"
#import "transferAccountsView.h"
#import "HHPayPasswordView.h"
//#import "CardBagTransferAccountsNetApi.h"
#import "BalanceHomeVC.h"
@interface BalanceTfVC ()<HHPayPasswordViewDelegate>
@property (nonatomic,copy)NSString *bn_num;
@property (nonatomic,copy)NSString *remark;
@end

@implementation BalanceTfVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEX_COLOR(0xeeeeee);
    self.bn_num = @"";
    [self setupNavBar];
    [self initWithUI];
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
    [self.customNavBar wr_setRightButtonWithTitle:@"转账记录" titleColor:HEX_COLOR(0x2285EB)];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar setOnClickRightButton:^{
        Class vcclass = NSClassFromString(@"BalanceListVC");
        UIViewController *vc=  [[vcclass alloc] init];
        [vc setValue:@"2" forKey:@"type"];
        [vc setValue:@"转账记录" forKey:@"titleStr"];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"转账";
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}
-(void)initWithUI{
    transferAccountsView *tranView = [[transferAccountsView alloc]init];
    tranView.userDict = self.userDict;
    [tranView setTransferAccountsClick:^(NSString * _Nonnull money, NSString * _Nonnull remark) {
        self.bn_num = money;
        self.remark = remark;
        HHPayPasswordView *payPasswordView = [[HHPayPasswordView alloc] init];
        payPasswordView.delegate = self;
        [payPasswordView showInView:self.view];
    }];
    [self.view addSubview:tranView];
    [tranView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavBar.mas_bottom).offset(HeightRatio(31));
        make.height.mas_equalTo(HeightRatio(687));
    }];
}
#pragma mark - HHPayPasswordViewDelegate
- (void)passwordView:(HHPayPasswordView *)passwordView didFinishInputPayPassword:(NSString *)password{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        if ([password isEqualToString:@"000000"]) {
//            [passwordView paySuccess];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [passwordView hide];
//
//            });
//        }else{
////            [passwordView payFailureWithPasswordError:YES withErrorLimit:3];
//            [WXZTipView showCenterWithText:@"密码错误"];
//            [passwordView hide];
//        }
//    });

    /*
    
    CardBagTransferAccountsNetApi *trans = [[CardBagTransferAccountsNetApi alloc]initWithParameter:@{@"member_id":[NSString judgeNullReturnString:self.userDict[@"member_id"]],@"member_paypwd":password,@"bn_num":self.bn_num}];
    [trans startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [passwordView hide];
        CardBagTransferAccountsNetApi *transRequest = (CardBagTransferAccountsNetApi *)request;
        if ([transRequest getCodeStatus]==1) {
            [WXZTipView showCenterWithText:[transRequest getMsg]];
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[BalanceHomeVC class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                    return ;
                }
            }
        }else{
            [WXZTipView showCenterWithText:[transRequest getMsg]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [passwordView hide];
        [WXZTipView showCenterWithText:@"转账失败"];
    }];
     
     */
}
- (void)forgetPayPassword{
    NSLog(@"forgetPayPassword");
}
@end
