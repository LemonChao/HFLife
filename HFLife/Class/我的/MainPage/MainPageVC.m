
//
//  MainPageVC.m
//  HFLife
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "MainPageVC.h"
#import "SXF_HF_MainPageView.h"


#import "ShippingAddressVC.h"
//#import "BindingPayWayVC.h"
#import "InviteVC.h"
#import "SecurityCenterVC.h"
#import "EnterVC.h"
#import "MyCollectionVC.h"
#import "myFriendListVC.h"
#import "AboutVC.h"

//富权
#import "FQ_homeVC.h"
//余额
#import "BalanceHomeVC.h"
@interface MainPageVC ()
@property (nonatomic, strong)SXF_HF_MainPageView *mainPageView;
@end

@implementation MainPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"";
    [self setUpUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.mainPageView.memberInfoModel = [userInfoModel sharedUser];
    [self loadData];
    [NOTIFICATION postNotificationName:@"stopScroll" object:@(0)];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [NOTIFICATION postNotificationName:@"stopScroll" object:@(1)];
}
- (void)setUpUI{
    self.mainPageView = [[SXF_HF_MainPageView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight - self.tabBarHeight)];
    [self.view addSubview:self.mainPageView];
     
    WEAK(weakSelf);
    self.mainPageView.selectedItemCallback = ^(NSIndexPath * _Nonnull indexPath) {
        NSLog(@"分区 %ld   行%ld", (long)indexPath.section, (long)indexPath.row);
        BaseViewController *vc;
        SXF_HF_WKWebViewVC *webVC = [SXF_HF_WKWebViewVC new];
        //token不存在 跳转 登录
        if (!LogIn_Success) {
            [SXF_HF_AlertView showAlertType:AlertType_login Complete:^(BOOL btnBype) {
                if (btnBype) {
                    //登录页
                    [WXZTipView showCenterWithText:@"去登陆"];
                    return ;
                }
            }];
        }else {
            if (indexPath.section == 0) {
                
                if (![[userInfoModel sharedUser] chect_rz_status]) {
                    if ([[userInfoModel sharedUser].rz_status integerValue] == 0) {
                        //去认证
                        [SXF_HF_AlertView showAlertType:AlertType_realyCheck Complete:^(BOOL btnBype) {
                            if (btnBype) {
                                SXF_HF_WKWebViewVC *web = [SXF_HF_WKWebViewVC new];
                                web.urlString = SXF_WEB_URLl_Str(certification);
                                [weakSelf.navigationController pushViewController:web animated:YES];
                            }
                        }];
                    }else{
                        [WXZTipView showCenterWithText:[userInfoModel sharedUser].rz_statusName];
                    }
                    return ;
                }
                
                
                
                if (indexPath.row == 0) {
                    //余额
                    webVC.urlString = SXF_WEB_URLl_Str(balanceMain);
                    vc = webVC;
                }else if (indexPath.row == 1){
                    //可兑换
                    webVC.urlString = SXF_WEB_URLl_Str(convertible);
                    vc = webVC;
                }else{
                    //富权
                    webVC.urlString = SXF_WEB_URLl_Str(richRightBalance);
                    vc = webVC;
                }
            }else
                if (indexPath.section == 1) {
                    NSArray *urlArr = @[addressList,
                                        bankCardList,
                                        share,
                                        @"",
                                        enterIndex,//我要入驻
                                        upgrade,//领取收款码
                                        upgradeMain,
                                        myCollection,
                                        myFriendsMain,
                                        @"",
                                        ];
                    
                    if (indexPath.row == 1) {
                        //银行卡实名认证
                        if (![[userInfoModel sharedUser] chect_rz_status]) {
                            [WXZTipView showCenterWithText:[userInfoModel sharedUser].rz_statusName];
                            return ;
                        }
                    }
                    
                    if (indexPath.row == 3) {
                        //安全中心
                        vc = [SecurityCenterVC new];
                    }else if (indexPath.row == 8){
                        vc = [AboutVC new];
                    }else{
                        webVC.urlString = SXF_WEB_URLl_Str(urlArr[indexPath.row]);
                        if (indexPath.row == 4 || indexPath.row == 5) {
                            webVC.urlString = urlArr[indexPath.row];
                        }
                        vc = webVC;
                    }
                    
                }
            if (vc) {
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }
        
        
    };
    
    [self.customNavBar wr_setLeftButtonWithTitle:@"我的" titleColor:HEX_COLOR(0x000000)];
    
    
}
#pragma mark - 加载数据
- (void)loadData {
//    [[WBPCreate sharedInstance] showWBProgress];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kCenterAdress(kMemberInfo) withParameters:nil withResultBlock:^(BOOL result, id value) {
//        [[WBPCreate sharedInstance] hideAnimated];
        if (result) {
            [userInfoModel attempDealloc];
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *dataDic = value[@"data"];
                if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                    
                    
                    [[userInfoModel sharedUser] setValuesForKeysWithDictionary:dataDic];
                    [userInfoModel saveUserDataAndAccount];
                    //初始化头像
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [userInfoModel sharedUser].userHeaderImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:MY_URL_IMG([userInfoModel sharedUser].member_avatar)]];
                    }];
                    //刷新界面
                    self.mainPageView.memberInfoModel = [userInfoModel sharedUser];
                    
                    //设置用户信息
                    [self.mainPageView refreshUser];
                    
                    
                }else {
                    [WXZTipView showCenterWithText:@"个人信息获取错误"];
                }
            }
        }else {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络错误"];
                [userInfoModel getSavedUserData];
            }
        }
    }];
}



@end
