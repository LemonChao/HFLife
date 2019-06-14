//
//  NearPageVC.m
//  HFLife
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "NearPageVC.h"
#import "YYB_HF_LocalHeadView.h"
#import "YYB_HF_LifeLocaView.h"
#import "YBPopupMenu.h"
//定位
//城市选择相关
#import "JFLocation.h"
#import "YYB_HF_NearSearchVC.h"

#import "YYB_HF_LocalFailAlertV.h"//定位失败显示
@interface NearPageVC (){
    int arc;
    BOOL isFirstLoad;
    
}
/** 容器TableView*/
@property(nonatomic, strong) YYB_HF_LocalHeadView *headView;
@property(nonatomic, strong) NSMutableDictionary *cellHeightDic;
@property(nonatomic, strong) YYB_HF_LifeLocaView *myLocaVeiw;

@end

@implementation NearPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellHeightDic = [NSMutableDictionary dictionary];
    isFirstLoad = YES;
    
    YYB_HF_LocalHeadView *headView = [[YYB_HF_LocalHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NavBarHeight)];
    [self.view addSubview:headView];
    self.headView = headView;
    headView.addressSelect = ^{
        //地址选择
        YYB_HF_WKWebVC *vc = [[YYB_HF_WKWebVC alloc]init];
        vc.urlString = kH5LocaAdress(kChoiceCity);
        
        vc.choiceCity = ^(NSString * _Nonnull city) {
            self.headView.setLocalStr = city;
            [MMNSUserDefaults setValue:city forKey:SelectedCity];
            [self uploadBackLocation:city];
        };
        [self.navigationController pushViewController:vc animated:YES];
    };
    headView.userHeadClick = ^{
        //点击头像
        [self.navigationController pushViewController:[NSClassFromString(@"PersonalDataVC") new] animated:YES];
    };
    
    headView.orderIconClick = ^{
        //点击订单
        YYB_HF_WKWebVC *vc = [[YYB_HF_WKWebVC alloc]init];
        vc.urlString = kH5LocaAdress(kOrderList);
        
        [self.navigationController pushViewController:vc animated:YES];
    };
    headView.searchIconClick = ^(NSString * _Nonnull search) {
        //点击搜索
        YYB_HF_NearSearchVC *vc = [[YYB_HF_NearSearchVC alloc]init];
        vc.searchStrDe = search;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    self.myLocaVeiw = [[YYB_HF_LifeLocaView alloc]initWithFrame:CGRectZero];
    self.myLocaVeiw.supVC = self;
    WEAK(weakSelf);
    self.myLocaVeiw.reFreshData = ^(YYB_HF_nearLifeModel * _Nonnull nearModel) {
        //数据更新
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        }else {
            //app 未开启定位
            [[YYB_HF_LocalFailAlertV shareInstance] show];
        }
        if (nearModel.city_now && [nearModel.city_now isKindOfClass:[NSString class]] && nearModel.city_now.length > 0) {
            weakSelf.headView.setLocalStr = nearModel.city_now;
        }else {
            weakSelf.headView.setLocalStr = @"正在定位...";
        }
    };
    
    [self.view addSubview:self.myLocaVeiw];
    //    [self.myLocaVeiw setFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight)];
    [self.myLocaVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headView.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(self.view).mas_offset(0);
        make.right.mas_equalTo(self.view).mas_offset(-0);
        make.height.mas_equalTo(SCREEN_HEIGHT - NavBarHeight - TabBarHeight);
    }];
    //定位是否上传过
    NSString *seleCity = [MMNSUserDefaults valueForKey:SelectedCity];
    if (seleCity && [seleCity isKindOfClass:[NSString class]] && seleCity.length > 0) {
        [self uploadBackLocation:seleCity];
    }else {
        seleCity = [MMNSUserDefaults valueForKey:LocationCity];
        if (seleCity && [seleCity isKindOfClass:[NSString class]] && seleCity.length > 0) {
            [self uploadBackLocation:seleCity];
        }
    }
    
    
}

#pragma mark - 上传定位
-(void)uploadBackLocation:(NSString *)city{
    NSLog(@"city = %@",city);
    if (![NSString isNOTNull:city]) {
        NSLog(@"上传定位");
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:city forKey:@"city_name"];
        
        if ([JFLocationSingleton sharedInstance].locationArray.count>0) {
            CLLocation *newLocation = [[JFLocationSingleton sharedInstance].locationArray lastObject];
            CLLocationCoordinate2D gaocoor;
            gaocoor.latitude = newLocation.coordinate.latitude ? newLocation.coordinate.latitude : 0.0;
            gaocoor.longitude = newLocation.coordinate.longitude ? newLocation.coordinate.longitude : 0.0;
            CLLocationCoordinate2D coor = [JZLocationConverter gcj02ToBd09:gaocoor];
            [dict setObject:MMNSStringFormat(@"%f",coor.latitude) forKey:@"lat"];
            [dict setObject:MMNSStringFormat(@"%f",coor.longitude) forKey:@"lng"];
        }
        
        
        [networkingManagerTool requestToServerWithType:POST withSubUrl:SXF_LOC_URL_STR(upDateLocationUrl) withParameters:dict withResultBlock:^(BOOL result, id value) {
            
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.customNavBar setHidden:YES];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    self.headView.setHeadImage = [userInfoModel sharedUser].userHeaderImage;
    
    if (self->isFirstLoad) {
        [self.myLocaVeiw loadData];
        self->isFirstLoad = NO;
    }
    [YYB_HF_LocalFailAlertV detectionLocationState:^(int type) {
        if (type == 0) {
            //app 已开启定位
        }else {
            //系统 未开启定位
            [[YYB_HF_LocalFailAlertV shareInstance] show];
        }
    }];
    
}


- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

@end
