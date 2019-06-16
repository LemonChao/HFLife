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
            [self uploadBackLocation:city];
        };
        [self.navigationController pushViewController:vc animated:YES];
        
//        [YYB_HF_LocalFailAlertV detectionLocationState:^(int type) {
//
//        }];
        
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
        }else {
            //默认定位
            
        }
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
    
    NSString *address = [[NSUserDefaults standardUserDefaults] valueForKey:SelectedCity];
    if (!address) {
        address = [[NSUserDefaults standardUserDefaults] valueForKey:LocationCity];
    }
    if (!address) {
        address = @"杭州市";
    }
    self.headView.setLocalStr = address;
}

#pragma mark - 上传定位
-(void)uploadBackLocation:(NSString *)city{
    NSLog(@"city = %@",city);
    if (![NSString isNOTNull:city]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:city forKey:@"city_name"];
        //地理反编码，获取经纬度
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        [geoCoder geocodeAddressString:city completionHandler:^(NSArray *placemarks, NSError *error) {
            // 地址为空,直接返回
            if (!city) return ;
            if (error) { // 输入的地址有错误
                [WXZTipView showCenterWithText:@"该地址不存在，请确认地址正确"];
            }else{
                //                // 遍历查询到的地标
                //                NSLog(@"总共有%ld个地标符合要求",placemarks.count);
                //                for (int i = 0; i < placemarks.count; i++) {
                //                    CLPlacemark *placemark = placemarks[i];
                //                    NSLog(@"%@",placemark);
                //                }
                
                // 取地标数组的第一个为最终结果
                CLPlacemark *placemark = [placemarks firstObject];
                
                [dict setObject:MMNSStringFormat(@"%f",placemark.location.coordinate.latitude) forKey:@"lat"];
                [dict setObject:MMNSStringFormat(@"%f",placemark.location.coordinate.longitude) forKey:@"lng"];
                
                [networkingManagerTool requestToServerWithType:POST withSubUrl:kLifeAdress(upDateLocationUrl) withParameters:dict withResultBlock:^(BOOL result, id value) {
                    if (result) {
                        [MMNSUserDefaults setValue:city forKey:SelectedCity];
                        [self.myLocaVeiw loadData];
                        self.headView.setLocalStr = city;
                    }else {
                        if (value && [value isKindOfClass:[NSDictionary class]]) {
                            NSString *msg = value[@"msg"];
                            if (msg) {
                                [WXZTipView showCenterWithText:@"msg"];
                            }
                        }else {
                            [WXZTipView showCenterWithText:@"网络错误"];
                        }
                    }
                }];
            }
        }];
        
        //        if ([JFLocationSingleton sharedInstance].locationArray.count>0) {
        //            CLLocation *newLocation = [[JFLocationSingleton sharedInstance].locationArray lastObject];
        //            CLLocationCoordinate2D gaocoor;
        //            gaocoor.latitude = newLocation.coordinate.latitude ? newLocation.coordinate.latitude : 0.0;
        //            gaocoor.longitude = newLocation.coordinate.longitude ? newLocation.coordinate.longitude : 0.0;
        //            CLLocationCoordinate2D coor = [JZLocationConverter gcj02ToBd09:gaocoor];
        //            [dict setObject:MMNSStringFormat(@"%f",coor.latitude) forKey:@"lat"];
        //            [dict setObject:MMNSStringFormat(@"%f",coor.longitude) forKey:@"lng"];
        //            [networkingManagerTool requestToServerWithType:POST withSubUrl:kLifeAdress(upDateLocationUrl) withParameters:dict withResultBlock:^(BOOL result, id value) {
        //                if (result) {
        //                    [MMNSUserDefaults setValue:city forKey:SelectedCity];
        //                    [self.myLocaVeiw loadData];
        //                    self.headView.setLocalStr = city;
        //                }else {
        //                    if (value && [value isKindOfClass:[NSDictionary class]]) {
        //                        NSString *msg = value[@"msg"];
        //                        if (msg) {
        //                            [WXZTipView showCenterWithText:@"msg"];
        //                        }
        //                    }else {
        //                        [WXZTipView showCenterWithText:@"网络错误"];
        //                    }
        //                }
        //            }];
        //        }
    }
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
