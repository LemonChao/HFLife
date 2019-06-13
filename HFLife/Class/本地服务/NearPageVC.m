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
@interface NearPageVC (){
    int arc;
    BOOL isFirstLoad;
    
}
/** 容器TableView*/
@property(nonatomic, strong) YYB_HF_LocalHeadView *headView;
@property(nonatomic, strong) NSMutableDictionary *cellHeightDic;
@property(nonatomic, strong) YYB_HF_LifeLocaView *myLocaVeiw;
@property(nonatomic, strong) UIView *openLocalView;


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
            [weakSelf.myLocaVeiw setHidden:YES];
            [weakSelf.openLocalView setHidden:NO];
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
        
        
        [networkingManagerTool requestToServerWithType:POST withSubUrl:upDateLocationUrl withParameters:dict withResultBlock:^(BOOL result, id value) {
            
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.customNavBar setHidden:YES];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    self.headView.setHeadImage = [userInfoModel sharedUser].userHeaderImage;
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        //app 已开启定位
        if (isFirstLoad) {
            [self.myLocaVeiw loadData];
            isFirstLoad = NO;
        }
        [self.myLocaVeiw setHidden:NO];
        [self.openLocalView setHidden:YES];
    }else {
        //app 未开启定位
        [self.myLocaVeiw setHidden:YES];
        [self.openLocalView setHidden:NO];
    }
    
}

- (UIView *)openLocalView {
    
    if (_openLocalView) {
        return _openLocalView;
    }
    UIView *view = [UIView new];
    [view setFrame:self.view.frame];
    _openLocalView = view;
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]init];
    label.text = @" 未开启定位 ";
    label.textColor = [UIColor grayColor];
    
    UILabel *labelOpen = [[UILabel alloc]init];
    labelOpen.text = @"  开启定位  ";
    labelOpen.textColor = [UIColor grayColor];
    labelOpen.layer.cornerRadius = 10;
    labelOpen.clipsToBounds = YES;
    labelOpen.layer.borderWidth = 1.5;
    labelOpen.layer.borderColor = [UIColor grayColor].CGColor;
    
    [view addSubview:label];
    [view addSubview:labelOpen];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.centerY.mas_equalTo(view);
        make.height.mas_equalTo(20);
    }];
    
    [labelOpen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(label.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(30);
    }];
    [labelOpen setUserInteractionEnabled:YES];
    [labelOpen wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        
        NSURL *url = [[NSURL alloc] initWithString:UIApplicationOpenSettingsURLString];
        
        
        if( [[UIApplication sharedApplication] canOpenURL:url])
        {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:nil completionHandler:^(BOOL success) {
                    if (success) {
                        [self.openLocalView setHidden:YES];
                        [self.myLocaVeiw setHidden:NO];
                    }
                }];
            }else {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }];
    return _openLocalView;
    
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
