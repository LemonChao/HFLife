
//
//  SXF_HF_HomePageVM.m
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_HomePageVM.h"

//定位
//城市选择相关
#import "JFLocation.h"
#import "JFAreaDataManager.h"

#import "FlickingVC.h"
#import "PaymentVC.h"
#import "GatheringVC.h"
#import "CardPackageVC.h"


//新版
#import "SXF_HF_GetMoneyVC.h"
#import "SXF_HP_cardPacketVC.h"

@interface SXF_HF_HomePageVM ()<JFLocationDelegate>

@property (nonatomic, strong)JFLocation *locationManager;
@property (nonatomic, strong)NSTimer *circleTimer;

@end


@implementation SXF_HF_HomePageVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.locationManager.delegate = self;
        [self timingTask];
    }
    return self;
}


//循环加载接口
- (void) circleLoadData{
    
}




//actions
/**
 点击分区头
 */
- (void)clickHeaderBtn:(NSInteger) index{
    if (![NSString isNOTNull:[HeaderToken getAccessToken]]) {
        [SXF_HF_AlertView showAlertType:AlertType_login Complete:^(BOOL btnBype) {
            if (btnBype) {
                //登录页
                [WXZTipView showCenterWithText:@"去登陆"];
                return ;
            }
        }];
    }else{
        UIViewController *vc = [BaseViewController new];
        if (index == 0) {
            //检测相机权限
            if ([NSObject isCanUseCamare]) {
                vc = [FlickingVC new];//扫一扫
            }else{
                [WXZTipView showCenterWithText:@"相机不可用"];
                return;
            }
            
        }else if (index == 1){
            vc = [PaymentVC new];//付款
        }else if (index == 2){
            vc = [SXF_HF_GetMoneyVC new];//收款
        }else if (index == 3){
            vc = [SXF_HP_cardPacketVC new];//卡包
        }else if (index == 4){
            //搜索
            
        }
        [self.vc.navigationController pushViewController:vc animated:YES];
    }
}

//点击cell
- (void)clickCellItem:(NSIndexPath *)indexPath{
    NSLog(@"%ld分区   %ld个", (long)indexPath.section, (long)indexPath.row);
}

/**
 更新位置
 */
- (void)upDataLocation{
    [self timingTask];
}
-(void)timingTask{
    //0.创建队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //1.创建GCD中的定时器
    /*
     第一个参数:创建source的类型 DISPATCH_SOURCE_TYPE_TIMER:定时器
     第二个参数:0
     第三个参数:0
     第四个参数:队列
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //2.设置时间等
    /*
     第一个参数:定时器对象
     第二个参数:DISPATCH_TIME_NOW 表示从现在开始计时
     第三个参数:间隔时间 GCD里面的时间最小单位为 纳秒
     第四个参数:精准度(表示允许的误差,0表示绝对精准)
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 300.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    //3.要调用的任务
    dispatch_source_set_event_handler(timer, ^{
        NSString *city = [MMNSUserDefaults objectForKey:selectedCity];
        [self uploadBackLocation:city];
        
    });
    //4.开始执行
    dispatch_resume(timer);
}
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



#pragma mark --- JFLocationDelegate
//定位中...
- (void)locating {
    NSLog(@"定位中...");
}

//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary valueForKey:@"City"];
    NSString *city_nsu = [MMNSUserDefaults objectForKey:selectedCity];
    
    if (![city_nsu isEqualToString:city]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [MMNSUserDefaults setObject:city forKey:@"locationCity"];
            // [MMNSUserDefaults setObject:city forKey:selectedCity];
            [self uploadBackLocation:city];
            
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self.vc presentViewController:alertController animated:YES completion:nil];
    }
}

/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@",message);
    [WXZTipView showCenterWithText:message];
}
/// 定位失败
- (void)locateFailure:(NSString *)message {
    NSLog(@"%@",message);
    [WXZTipView showCenterWithText:message];
}



- (void)fireTimer{
    [self.circleTimer fire];
}
- (void)cancleTimer{
    [self.circleTimer invalidate];
    self.circleTimer = nil;
}




- (NSTimer *)circleTimer{
    
    if (!_circleTimer) {
        _circleTimer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(circleLoadData) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_circleTimer forMode:NSRunLoopCommonModes];
    }
    return _circleTimer;
}

-(JFLocation *)locationManager{
    if (!_locationManager) {
        _locationManager = [[JFLocation alloc] init];
    }
    return _locationManager;
}

@end
