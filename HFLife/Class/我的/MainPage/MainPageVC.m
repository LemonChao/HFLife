
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
@interface MainPageVC () {
    BOOL isFirstLoad;
}
@property (nonatomic, strong)SXF_HF_MainPageView *mainPageView;
@end

@implementation MainPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    isFirstLoad = YES;
    self.customNavBar.title = @"";
    [self setUpUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    userInfoModel *user = [userInfoModel sharedUser];
    if(user.id && user.id > 0) {
        [self.mainPageView reSetHeadData];
    }
    if (isFirstLoad) {
        isFirstLoad = NO;
        //我的信息
        [self loadData];
    }
}
- (void)setUpUI{
    self.mainPageView = [[SXF_HF_MainPageView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight - self.tabBarHeight)];
    [self.view addSubview:self.mainPageView];
    
    WEAK(weakSelf);
    self.mainPageView.selectedItemCallback = ^(NSIndexPath * _Nonnull indexPath) {
        NSLog(@"分区 %ld   行%ld", (long)indexPath.section, (long)indexPath.row);
        BaseViewController *vc = [BaseViewController new];
        
        //token不存在 跳转 登录
#warning 需要取反
        if (LogIn_Success) {
            [SXF_HF_AlertView showAlertType:AlertType_login Complete:^(BOOL btnBype) {
                if (btnBype) {
                    //登录页
                    [WXZTipView showCenterWithText:@"去登陆"];
                    return ;
                }
            }];
        }else {
            if (indexPath.section == 1) {
                // h5界面
                YYB_HF_WKWebVC *h5webVC = [[YYB_HF_WKWebVC alloc]init];
                h5webVC.isTop = YES;
                h5webVC.isNavigationHidden = YES;
                
                switch (indexPath.row) {
                    case 0:
                    {// 收货地址
                        //                        vc = [ShippingAddressVC new];
                        h5webVC.urlString = @"http://192.168.0.105:8080/addressList";
                        vc = h5webVC;
                    }
                        break;
                    case 1:
                    {//银行卡
                        //                        BindingPayWayVC *bindingVC = [BindingPayWayVC new];
                        //                        bindingVC.isAlipay = NO;
                        //                        vc = bindingVC;
                        if (![[userInfoModel sharedUser].rz_statusName isEqualToString:@"已认证"]) {
                            [SXF_HF_AlertView showAlertType:AlertType_login Complete:^(BOOL btnBype) {
                                if (btnBype) {
                                    //登录页
                                    [WXZTipView showCenterWithText:@"去登陆"];
                                    return ;
                                }
                            }];
                            return ;
                        }
                        h5webVC.urlString = @"http://192.168.0.105:8080/bankCardList";
                        vc = h5webVC;
                    }
                        break;
                    case 2:
                        vc = [InviteVC new];
                        break;
                    case 3:
                        vc = [SecurityCenterVC new];
                        break;
                    case 4:
                    {
                        if (![[userInfoModel sharedUser].rz_statusName isEqualToString:@"已认证"]) {
                            [SXF_HF_AlertView showAlertType:AlertType_login Complete:^(BOOL btnBype) {
                                if (btnBype) {
                                    //登录页
                                    [WXZTipView showCenterWithText:@"去登陆"];
                                    return ;
                                }
                            }];
                            return ;
                        }
                        vc = [EnterVC new];
                        
                    }
                        break;
                    case 5:
                    {
                        //                            vc = [MyCollectionVC new];
                        
                        h5webVC.urlString = @"http://192.168.0.105:8080/myCollection";
                        vc = h5webVC;
                    }
                        break;
                    case 6:
                        vc = [myFriendListVC new];
                        break;
                    case 7:
                        vc = [AboutVC new];
                        break;
                    default:
                        break;
                }
            }
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
        
    };
    
    
    [self.customNavBar wr_setLeftButtonWithTitle:@"我的" titleColor:HEX_COLOR(0x000000)];
    
    
}
#pragma mark - 加载数据
- (void)loadData {
    
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kMemberBaseInfo withParameters:nil withResultBlock:^(BOOL result, id value) {
        if (result) {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *dataDic = value[@"data"];
                if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                    [[userInfoModel sharedUser] setValuesForKeysWithDictionary:dataDic];
                }else {
                    [WXZTipView showCenterWithText:@"个人信息获取错误"];
                }
            }
        }else {
            self->isFirstLoad = YES;
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络错误"];
            }
        }
    }];
    
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kMemberInfo withParameters:nil withResultBlock:^(BOOL result, id value) {
        if (result) {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *dataDic = value[@"data"];
                if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                    MemberInfoModel *memberModel = [[MemberInfoModel alloc]init];
                    [memberModel setValuesForKeysWithDictionary:dataDic];
                    self.mainPageView.memberInfoModel = memberModel;
                }else {
                    [WXZTipView showCenterWithText:@"个人信息获取错误"];
                }
            }
        }else {
            self->isFirstLoad = YES;
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络错误"];
            }
        }
    }];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [SXF_HF_AlertView showAlertType:AlertType_save Complete:^(BOOL btnBype) {
        if (btnBype) {
            NSLog(@"right");
        }else{
            NSLog(@"left");
        }
    }];
    
    
}
@end
