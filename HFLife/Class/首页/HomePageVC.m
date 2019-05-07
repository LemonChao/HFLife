//
//  HomePageVC.m
//  HanPay
//
//  Created by mac on 2018/12/29.
//  Copyright © 2018年 mac. All rights reserved.
//
#define headerViewHeight  84 + NavBarHeight + WidthRatio(343)
#import "HomePageVC.h"
#import "DHGuidePageHUD.h" 

#import "JPUSHService.h"

//城市选择相关
#import "JFLocation.h"
#import "JFAreaDataManager.h"

#import "SXF_HF_CustomSearchBar.h"

@interface HomePageVC ()<UITableViewDelegate, UITableViewDataSource ,JFLocationDelegate>
@property (nonatomic, strong)JFLocation *locationManager;
@property (nonatomic, strong)NSTimer *circleTimer;
@end

@implementation HomePageVC
- (NSTimer *)circleTimer{
    
    if (!_circleTimer) {
        _circleTimer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(circleLoadData) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_circleTimer forMode:NSRunLoopCommonModes];
    }
    return _circleTimer;
}



//循环加载接口
- (void) circleLoadData{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
            // 静态引导页
        [self setStaticGuidePage];
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.customNavBar.title = @"首页";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"homeNavBG"] forBarMetrics:UIBarMetricsDefault];
    // 设置初始导航栏透明度
    [self wr_setNavBarBackgroundAlpha:0];
    self.locationManager.delegate = self;
    self.view.backgroundColor = HEX_COLOR(0xf4f4f4);

   
    [self setupNavigationItem];
//    [self VersionBounced];
    [self timingTask];
 
    
    [self setUpUI];
    [self loadServerData];
}

- (void)loadServerData{
    
}

- (void)setUpUI{
    SXF_HF_CustomSearchBar *searchBar = [[SXF_HF_CustomSearchBar alloc] initWithFrame:CGRectMake(0, statusBarHeight, SCREEN_WIDTH, 44)];
    [self.customNavBar addSubview:searchBar];
    searchBar.searchBtnClick = ^{
        [WXZTipView showTopWithText:@"搜索"];
    };
}
- (void) click{
    BaseViewController *vc = [BaseViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setStaticGuidePage {
    NSArray *imageNameArray = @[@"guide_1",@"guide_2",@"guide_3"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:NO];
    guidePage.slideInto = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:guidePage];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"homeNavBG"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.circleTimer fire];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.circleTimer invalidate];
    self.circleTimer = nil;
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

}

- (void)setupNavigationItem {
    UIImage *adressBook = [[UIImage imageNamed:@"adressBook"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *addMore = [[UIImage imageNamed:@"addMore"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *itemAdressBook = [[UIBarButtonItem alloc] initWithImage:adressBook style:UIBarButtonItemStylePlain target:self action:@selector(adressBookAction)];
    UIBarButtonItem *itemMore = [[UIBarButtonItem alloc] initWithImage:addMore style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"首页" forState:(UIControlStateNormal)];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(32)];
   
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
        NSString *city = [MMNSUserDefaults objectForKey:@"currentCity"];
        [self uploadBackLocation:city];
        
    });
    
    //4.开始执行
    dispatch_resume(timer);
    
}

#pragma mark --- JFLocationDelegate
//定位中...
- (void)locating {
    NSLog(@"定位中...");
}

//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary valueForKey:@"City"];
   	NSString *city_nsu = [MMNSUserDefaults objectForKey:@"currentCity"];
 
    if (![city_nsu isEqualToString:city]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [MMNSUserDefaults setObject:city forKey:@"locationCity"];
                // [MMNSUserDefaults setObject:city forKey:@"currentCity"];
            [self uploadBackLocation:city];
            
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
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
-(void)uploadBackLocation:(NSString *)city{
    NSLog(@"city = %@",city);
    if (![NSString isNOTNull:city]) {
        NSLog(@"上传定位");
       
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:city forKey:@"city_name"];
        
//        if ([JFLocationSingleton sharedInstance].locationArray.count>0) {
//            CLLocation *newLocation = [[JFLocationSingleton sharedInstance].locationArray lastObject];
//            CLLocationCoordinate2D gaocoor;
//            gaocoor.latitude = newLocation.coordinate.latitude ? newLocation.coordinate.latitude : 0.0;
//            gaocoor.longitude = newLocation.coordinate.longitude ? newLocation.coordinate.longitude : 0.0;
//            CLLocationCoordinate2D coor = [JZLocationConverter gcj02ToBd09:gaocoor];
//            [dict setObject:MMNSStringFormat(@"%f",coor.latitude) forKey:@"lat"];
//            [dict setObject:MMNSStringFormat(@"%f",coor.longitude) forKey:@"lng"];
//        }
        
    }
    
}
#pragma mark ===按钮方法===


-(JFLocation *)locationManager{
    if (!_locationManager) {
        _locationManager = [[JFLocation alloc] init];
            //        _locationManager.delegate = self;
    }
    return _locationManager;
}

-(void)itemButtonClick:(UIButton *)send{
    if ([NSString isNOTNull:[HeaderToken getAccessToken]]) {
        LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"温馨提示" message:@"您还没有登录，暂无法查看内容" cancelBtnTitle:@"取消" otherBtnTitle:@"去登录" clickIndexBlock:^(NSInteger clickIndex) {
            if(clickIndex == 1){
                [[NSNotificationCenter defaultCenter] postNotificationName:LOG_BACK_IN object:nil userInfo:nil];
            }
        }];
        alert.animationStyle=LXASAnimationTopShake;
        [alert showLXAlertView];
    }else{
        if (send.tag == -103){
                //卡包
            return;
        }
        if ([UserCache getUserXinXi]) {
            if (send.tag == -100) {
                if ([UserCache getUserTradePassword]) {
                        //扫一扫
                }else{
                    LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"温馨提示" message:@"您还没有设置交易密码" cancelBtnTitle:nil otherBtnTitle:@"我知道了" clickIndexBlock:^(NSInteger clickIndex) {
                    }];
                    alert.animationStyle=LXASAnimationTopShake;
                    [alert showLXAlertView];
                }
                
            }else if (send.tag == -101){
                    //付款
            }else if (send.tag == -102){
                    //收款
            }
        }else{
            LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"温馨提示" message:@"您还没有进行实名认证" cancelBtnTitle:@"取消" otherBtnTitle:@"去认证" clickIndexBlock:^(NSInteger clickIndex) {
                if(clickIndex == 1){
                    
                }
            }];
            alert.animationStyle=LXASAnimationTopShake;
            [alert showLXAlertView];
        }
        
    }
    
}




- (UIColor *)getNewColorWith:(UIColor *)color alpha:(CGFloat)alpha{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alp = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alp];
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return newColor;
}

@end
