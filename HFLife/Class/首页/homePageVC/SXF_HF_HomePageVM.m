
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


@property (nonatomic, strong)NSDictionary <NSString *, NSArray *>*homePageListDic;//数据原数组
//新闻数组
@property (nonatomic, strong)NSMutableArray *newsListArrM;



@end


@implementation SXF_HF_HomePageVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.locationManager.delegate = self;
        [self timingTask];
        self.homePageListDic = @{@"nav" : [NSArray array],
                                 @"banner" : [NSArray array],
                                 @"activity" : [NSArray array],
                                 };
        self.newsListArrM = [NSMutableArray array];
    }
    return self;
}


//循环加载接口
- (void) circleLoadData{
    
}




- (void) getBannerData{
    WEAK(weakSelf);
    [networkingManagerTool requestToServerWithType:POST withSubUrl:HomeNavBanner withParameters:@{} withResultBlock:^(BOOL result, id value) {
        [self.collectionView endRefreshData];
        if (result){
            if ([value[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                self.collectionView.peopleNum = value[@"data"][@"nums"];
                self.collectionView.fqPrice = value[@"data"][@"bn_acc_ratio"];
                
                //
                
                //需要计算得来
                NSString *moneyStr = [NSString stringWithFormat:@"%@", [self getMoney:Format(self.collectionView.fqPrice ? self.collectionView.fqPrice : @(0)) :value[@"data"][@"static_coin"]]];
                self.collectionView.myFQ = moneyStr;
                NSDictionary *dict = value[@"data"];
                NSMutableDictionary *dataSourceDicM = [NSMutableDictionary dictionary];
                if ([dict objectForKey:@"nav"] && [[dict objectForKey:@"nav"] isKindOfClass:[NSArray class]]) {
                    NSArray *navListArr = [HR_dataManagerTool getModelArrWithArr:[dict valueForKey:@"nav"] withClass:[homeListModel class]];
                    [dataSourceDicM  setObject:navListArr forKey:@"nav"];
                }
                if ([dict objectForKey:@"banner"] && [[dict objectForKey:@"banner"] isKindOfClass:[NSArray class]]) {
                    NSArray *bannerListArr = [HR_dataManagerTool getModelArrWithArr:[dict valueForKey:@"banner"] withClass:[homeListModel class]];
                    [dataSourceDicM setValue:bannerListArr forKey:@"banner"];
                }
                if ([dict objectForKey:@"activity"] && [[dict objectForKey:@"activity"] isKindOfClass:[NSArray class]]) {
                    NSArray *activityListArr = [HR_dataManagerTool getModelArrWithArr:[dict valueForKey:@"activity"] withClass:[homeActivityModel class]];
                    [dataSourceDicM setValue:activityListArr forKey:@"activity"];
                }
                if ([dict objectForKey:@"notice"] && [[dict objectForKey:@"notice"] isKindOfClass:[NSArray class]]) {
                    NSArray *activityListArr = [HR_dataManagerTool getModelArrWithArr:[dict valueForKey:@"notice"] withClass:[noticeModel class]];
                    [dataSourceDicM setValue:activityListArr forKey:@"notice"];
                }
                self.homePageListDic = dataSourceDicM;
                self.collectionView.dataSourceDict = self.homePageListDic;
            }else{
                [WXZTipView showCenterWithText:@"数据异常"];
            }
            
        }else{
            
        }
    }];
}

- (void) getNewsListData:(NSInteger)page{
    [networkingManagerTool requestToServerWithType:POST withSubUrl:HomeNewsList withParameters:@{@"page" :@(page)} withResultBlock:^(BOOL result, id value) {
        [self.collectionView endRefreshData];
        if (result){
            [self.collectionView endRefreshData];
            if ([value[@"data"] isKindOfClass:[NSArray class]]) {
                NSArray *newsModels = [HR_dataManagerTool   getModelArrWithArr:value[@"data"] withClass:[homeListModel class]];
                if (page == 1) {
                    [self.newsListArrM removeAllObjects];
                    self.newsListArrM = [newsModels mutableCopy];
                }else{
                    [self.newsListArrM addObjectsFromArray:newsModels];
                }
                self.collectionView.newsListModelArr = [self.newsListArrM copy];
            }
        }
    }];
}






//actions
/**
 点击分区头
 */
- (void)clickHeaderBtn:(NSInteger) index{
    if (!LogIn_Success) {
        [SXF_HF_AlertView showAlertType:AlertType_login Complete:^(BOOL btnBype) {
            if (btnBype) {
                //登录页
                [WXZTipView showCenterWithText:@"去登陆"];
                return ;
            }
        }];
    }else{
        if (![userInfoModel sharedUser].chect_rz_status) {
            return;
        }
        UIViewController *vc;
        if (index == 0) {
            //检测相机权限
            if ([NSObject isCameraAvailable]) {
                if (![userInfoModel isCanUseCamare]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您未开通相机权限" message:@"请在设置-隐私-相册中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
                    [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    }]];
                    [self.vc.navigationController presentViewController:alert animated:YES completion:nil];
                    return;
                }else{
                    vc = [FlickingVC new];//扫一扫
                }
            }else{
                [WXZTipView showCenterWithText:@"相机不可用"];
                return;
            }
            
        }else if (index == 1){
            SXF_HF_GetMoneyVC *payVC = [SXF_HF_GetMoneyVC new];//付款
            payVC.payType = NO;
            vc = payVC;
        }else if (index == 2){
            SXF_HF_GetMoneyVC *getVC = [SXF_HF_GetMoneyVC new];//收款
            getVC.payType = YES;
            vc = getVC;
        }else if (index == 3){
            vc = [SXF_HP_cardPacketVC new];//卡包
        }else if (index == 4){
            //搜索
            
        }
        if (vc) {
            [self.vc.navigationController pushViewController:vc animated:YES];
        }
    }
}

//点击cell
- (void)clickCellItem:(NSIndexPath *)indexPath value:(id)value{
    NSLog(@"%ld分区   %ld个    %@", (long)indexPath.section, (long)indexPath.row, value);
    SXF_HF_WKWebViewVC *webVC = [SXF_HF_WKWebViewVC new];
    NSString *urlStr = value;
    
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1) {
        //通知消息
        urlStr = SXF_WEB_URLl_Str(noticeList);
    }else if (indexPath.section == 2){
        
    }else if (indexPath.section == 3){
        
    }else{
        
    }
    
    if (urlStr) {
        webVC.urlString = urlStr;
        [self.vc.navigationController pushViewController:webVC animated:YES];
    }else{
        [WXZTipView showCenterWithText:@"暂无该条详情数据"];
    }
}

//活动按钮点击事件
- (void) clickActivityBtn:(NSString *)btnUrl{
    //加载web页面
    WKWebViewController *webV = [WKWebViewController new];
    if (btnUrl) {
        webV.urlString = btnUrl;
        [self.vc.navigationController pushViewController:webV animated:YES];
    }else{
        [WXZTipView showCenterWithText:@"暂无该条数据"];
    }
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
        NSString *city = [MMNSUserDefaults objectForKey:SelectedCity];
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
        
        JFLocationSingleton * _Nonnull extractedExpr = [JFLocationSingleton sharedInstance];
        if (extractedExpr.locationArray.count>0) {
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
    NSString *city_nsu = [MMNSUserDefaults objectForKey:SelectedCity];
    
    if (![city_nsu isEqualToString:city]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [MMNSUserDefaults setObject:city forKey:LocationCity];
            
            //把已选择的城市更改成定位城市
             [MMNSUserDefaults setObject:city forKey:SelectedCity];
            [self uploadBackLocation:city];
            
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self.vc presentViewController:alertController animated:YES completion:nil];
    }else{
        [self uploadBackLocation:city];
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
//用于货币高精度计算
- (NSDecimalNumber *) getMoney:(NSString *)bn_acc_ratio :(NSString *)static_coin{
    //富权值
    NSDecimalNumber *static_coinNum = [NSDecimalNumber decimalNumberWithString:static_coin];
    //富权价格
    NSDecimalNumber *bn_acc_ratioNum = [NSDecimalNumber decimalNumberWithString:bn_acc_ratio];
    
//    NSDecimalNumber *bn_acc_blNum = [NSDecimalNumber decimalNumberWithString:bn_acc_bl];
    
//    NSDecimalNumber *oneNum = [NSDecimalNumber decimalNumberWithString:@"1"];
    
    
    /*
     scale 结果保留几位小数
     
              raiseOnExactness 发生精确错误时是否抛出异常，一般为NO
     
              raiseOnOverflow 发生溢出错误时是否抛出异常，一般为NO
     
              raiseOnUnderflow 发生不足错误时是否抛出异常，一般为NO
     
              raiseOnDivideByZero 被0除时是否抛出异常，一般为YES
     */
    NSDecimalNumberHandler * rounUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:10 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    
    //富权价格：(富权值*富权价格)*(1-手续费比例)=可兑换余额
    
    //(1-手续费比例)
//    NSDecimalNumber *subNum = [oneNum decimalNumberBySubtracting:bn_acc_blNum withBehavior:rounUp];
//
//
    NSDecimalNumber *valueNum = [static_coinNum decimalNumberByMultiplyingBy:bn_acc_ratioNum withBehavior:rounUp];
    NSLog(@"%@", valueNum);
    return valueNum;
    
}

@end
