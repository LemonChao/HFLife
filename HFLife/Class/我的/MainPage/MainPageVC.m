
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
    self.mainPageView.memberInfoModel = [userInfoModel sharedUser];
    [self loadData];
}
- (void)setUpUI{
    self.mainPageView = [[SXF_HF_MainPageView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight - self.tabBarHeight)];
    [self.view addSubview:self.mainPageView];
     
    WEAK(weakSelf);
    self.mainPageView.selectedItemCallback = ^(NSIndexPath * _Nonnull indexPath) {
        NSLog(@"分区 %ld   行%ld", (long)indexPath.section, (long)indexPath.row);
        BaseViewController *vc = [BaseViewController new];
        SXF_HF_WKWebViewVC *webVC;
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
                if (indexPath.row == 0) {
                    //富权
                    webVC.urlString = richRightBalance;
                    vc = webVC;
                }else if (indexPath.row == 1){
                    //余额
                    webVC.urlString = balanceMain;
                    vc = webVC;
                }
            }else
            if (indexPath.section == 1) {
                NSArray *urlArr = @[addressList,
                                    bankCardList,
                                    @"",@"",
                                    @"",//我要入驻
                                    
                                    ];
                switch (indexPath.row) {
                    case 0:
                    {// 收货地址
                        webVC.urlString = addressList;
                        vc = webVC;
                    }
                        break;
                    case 1:
                    {//银行卡

                        webVC.urlString = bankCardList;
                        vc = webVC;
                    }
                        break;
                    case 2:
                        //分享好友
                        vc = [InviteVC new];
                        break;
                    case 3:
                        //安全中心
                        vc = [SecurityCenterVC new];
                        break;
                    case 4:
                    {//我要入驻
                        webVC.urlString = @"";
                        vc = [EnterVC new];
                    }
                        break;
                    case 5:
                    {
                        webVC.urlString = upgradeMain;
                        vc = webVC;
                    }
                        break;
                    case 6:
                    {
                        webVC.urlString = myCollection;
                        vc = webVC;
                    }
                        break;
                    case 7:
                        webVC.urlString = myFriendsMain;
                        vc = webVC;
                        break;
                    case 8:
                        webVC.urlString = myFriendsMain;
                        vc = webVC;
                        break;
                    case 9:
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
    
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kMemberInfo withParameters:nil withResultBlock:^(BOOL result, id value) {
        if (result) {
            [userInfoModel attempDealloc];
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *dataDic = value[@"data"];
                if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                    
                    
                    [[userInfoModel sharedUser] setValuesForKeysWithDictionary:dataDic];
                    
                    
                    //存储修改账号信息===

                    NSString *acckey = [userInfoModel sharedUser].member_mobile;
                    if (acckey) {
                        NSDictionary *accountDic = [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO_ACCOUNT];
                        NSMutableDictionary *accountDicCopy;
                        if ((accountDic && [accountDic isKindOfClass:[NSDictionary class]])) {
                            accountDicCopy = [[NSMutableDictionary alloc]initWithDictionary:accountDic];
                        }else {
                            accountDicCopy = [[NSMutableDictionary alloc]init];
                        }
                        NSDictionary *accountItem = @{
                                                      @"member_mobile":[NSString judgeNullReturnString:[userInfoModel sharedUser].member_mobile],
                                                      @"member_avatar":[NSString judgeNullReturnString:[userInfoModel sharedUser].member_avatar],
                                                      @"token":[NSString judgeNullReturnString:[[NSUserDefaults standardUserDefaults] valueForKey:USER_TOKEN]]
                                                      };
                        [accountDicCopy setValue:accountItem forKey:acckey];
                        [[NSUserDefaults standardUserDefaults] setValue:accountDicCopy forKey:USERINFO_ACCOUNT];
                    }
                    
                    ///====
                    
                    //存储用户信息
                    NSData *encodeInfo = [NSKeyedArchiver archivedDataWithRootObject:[userInfoModel sharedUser]];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:encodeInfo forKey:USERINFO_DATA];
                    [defaults synchronize];
                    //====
                    //初始化头像
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [userInfoModel sharedUser].userHeaderImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:MY_URL_IMG([userInfoModel sharedUser].member_avatar)]];
                    }];
                    //刷新界面
                    self.mainPageView.memberInfoModel = [userInfoModel sharedUser];
                }else {
                    [WXZTipView showCenterWithText:@"个人信息获取错误"];
                }
            }
        }else {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *savedEncodedData = [defaults objectForKey:USERINFO_DATA];
            userInfoModel *user = [[userInfoModel alloc]init];
            if(savedEncodedData){
                user = (userInfoModel *)[NSKeyedUnarchiver unarchiveObjectWithData:savedEncodedData];
                UIImage *img;
                if (user.userHeaderImage) {
                    //image值单独赋值
                    img = user.userHeaderImage;
                }
                user.userHeaderImage = nil;
                NSMutableDictionary *dataDic = [user mj_keyValues];
                [dataDic setValue:img forKey:@"userHeaderImage"];
                if (dataDic) {
                    [[userInfoModel sharedUser] setValuesForKeysWithDictionary:dataDic];
                }
            }
            
            self->isFirstLoad = YES;
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络错误"];
            }
        }
    }];
}




@end
