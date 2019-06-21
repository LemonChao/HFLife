//
//  MapViewController.m
//  HFLife
//
//  Created by mac on 2019/2/2.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "MapViewController.h"
#import "MapManager.h"
#import <MapKit/MapKit.h>
#import "JZLocationConverter.h"
#import "UIView+LLXAlertPop.h"
@interface MapViewController ()

@end
@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //不管进行什么地图操作都要先定位自己位置
    [self locationOnlySelf];
    [self setupNavBar];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.isMark) {
            [self addAnonation];
        }
        
    });
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
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar wr_setBottomLineHidden:YES];

    self.customNavBar.titleLabelColor = [UIColor blackColor];
    
}
//显示自己的定位信息
-(void)locationOnlySelf {
    MapManager *manager = [MapManager sharedManager];
    manager.controller = self;
    [manager setNavigationPath:^(CGFloat latitude, CGFloat longitude) {
        [self gotoMapLatitude:latitude Longitude:longitude];
    }];
    [manager initMapView];
}
//给一个坐标，在地图上显示大头针
-(void)addAnonation{
    CLLocationCoordinate2D gaocoor;
    gaocoor.latitude = self.latitude;
    gaocoor.longitude = self.longitude;
//    CLLocationCoordinate2D coor = [JZLocationConverter gcj02ToBd09:gaocoor];
    [[MapManager sharedManager] addAnomationWithCoor:gaocoor];
}
#pragma mark - 去地图展示路线
/** 去地图展示路线 */
- (void)gotoMapLatitude:(CGFloat)latitude Longitude:(CGFloat)longitude{
    
    
    NSMutableArray *arrayTitle = [NSMutableArray array];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        [arrayTitle addObject:@"百度地图"];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        [arrayTitle addObject:@"高德地图"];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com"]]) {
        [arrayTitle addObject:@"苹果地图"];
    }
    UIColor *color = [UIColor blackColor];
    if (arrayTitle.count == 0) {
        [WXZTipView showCenterWithText:@"您手机上暂未有地图相关的APP"];
        return;
    }
    [self.view createAlertViewTitleArray:arrayTitle textColor:color font:[UIFont systemFontOfSize:WidthRatio(29)] actionBlock:^(UIButton * _Nullable button, NSInteger didRow) {
        //获取点击事件
        NSString *title = arrayTitle[didRow];
        if ([title isEqualToString:@"百度地图"]) {
                // 百度地图
                // 起点为“我的位置”，终点为后台返回的坐标
            CLLocationCoordinate2D gaocoor;
            gaocoor.latitude = latitude;
            gaocoor.longitude = longitude;
            
            CLLocationCoordinate2D coor = [JZLocationConverter gcj02ToBd09:gaocoor];
            
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=%f,%f&mode=riding&src=汉支付", coor.latitude, coor.longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSURL *url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
        }else if ([title isEqualToString:@"高德地图"]){
                // 高德地图
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"汉支付",@"hanzhifuMap",latitude,longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }else if ([title isEqualToString:@"苹果地图"]){
                // 苹果地图
            CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(latitude, longitude);
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:loc addressDictionary:nil]];
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                           MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        }
        
    }];
        // 后台返回的目的地坐标是百度地图的
        // 百度地图与高德地图、苹果地图采用的坐标系不一样，故高德和苹果只能用地名不能用后台返回的坐标
//    CGFloat latitude  =  34.784344;  // 纬度
//    CGFloat longitude = 113.680518; // 经度
        // 打开地图的优先级顺序：百度地图->高德地图->苹果地图
    
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
//        
//    }else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
//        
//        
//    }else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com"]]){
//        
//    }else{
//        // 快递员没有安装上面三种地图APP，弹窗提示安装地图APP
//        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请安装地图APP" message:@"建议安装高德地图APP" preferredStyle:UIAlertControllerStyleAlert];
//        [self presentViewController:alertVC animated:NO completion:nil];
//    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
