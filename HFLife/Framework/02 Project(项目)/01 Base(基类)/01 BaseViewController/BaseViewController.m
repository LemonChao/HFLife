//
//  ParentViewController.m
//  DuDuJR
//
//  Created by sxf on 2017/11/7.
//  Copyright © 2017年 sxf. All rights reserved.
//

#import "BaseViewController.h"
#import "JQToastWindow.h"
//网络状态
typedef enum NetStatus
{
    WIFI = 0,
    MOBEL,
    BASY,
    NONET
}NetStatus;
@interface BaseViewController ()<UINavigationControllerDelegate>
@property (nonatomic ,copy) NSMutableString *savetitle;
@property (nonatomic,strong)JQToastWindow * loadingToastView;//自定义加载框
//@property (nonatomic ,strong) NSTimer *timer;

@end
static BOOL IsUpdateRemind = YES;
@implementation BaseViewController
{
    BOOL isHaveDian;
    //首字母是否为0
    BOOL isFirstLetter;
    SELUpdateAlert *updateAlert;//更新
}
-(JQToastWindow *)loadingToastView
{
    if (!_loadingToastView) {
        _loadingToastView  = XIB(JQToastWindow);
        _loadingToastView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    }
    return _loadingToastView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    [self setupNavBar];
    
    
    
    
    //系统父类 添加网络通知
    [NOTIFICATION addObserver:self selector:@selector(haveNetRefreshData) name:HAVE_NET object:nil];
    
    
}
//刷新数据 需要子类重写该方法
- (void) haveNetRefreshData{
    
}

- (void)setupNavBar
{
    [self.view addSubview:self.customNavBar];
    
    // 设置自定义导航栏背景图片
//    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"navi_bg"];
    [self.customNavBar wr_setBottomLineHidden:NO];
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    // 设置自定义导航栏标题颜色
    self.customNavBar.titleLabelColor = HEX_COLOR(0x0C0B0B);
    if (self.navigationController.childViewControllers.count != 1) {
        for (UIViewController *vc in self.navigationController.childViewControllers) {
//            NSLog(@"vc = %@", NSStringFromClass([vc class]));
        }
        if (self != self.navigationController.childViewControllers.firstObject) {
            [self.customNavBar wr_setLeftButtonWithNormal:image(@"back") highlighted:image(@"back")];
        }else{
            
        }
        
    }
    // 设置初始导航栏透明度
//    [self wr_setNavBarBackgroundAlpha:0];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //移除通知
    [NOTIFICATION removeObserver:self name:HAVE_NET object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//    [self.view addSubview:self.customNavBar];
    [self.view bringSubviewToFront:self.customNavBar];
    self.navigationController.navigationBar.hidden = YES;
    //百度单页面统计
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   self.navigationController.navigationBar.hidden = NO;
    
    //百度单页面统计
//    [[BaiduMobStat defaultStat] pageviewEndWithName:self.title];
 }

//控制StatusBar是否隐藏 default NO
- (BOOL)prefersStatusBarHidden
{
    return NO;
}
//控制StatusBar显示模式 default
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
//控制StatusBar动画方式 default Fade
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}


//显示自定义加载框
-(void)showLoadingToastView
{
    [self.loadingToastView showToast];
}
//隐藏加载框
-(void)dismissLoadingToastView
{
    [self.loadingToastView hiddenToast];
    self.loadingToastView = nil;
}
- (void)setLimitCount:(NSInteger)limitCount{
    _limitCount = limitCount;
}
- (void)setFirstType:(BOOL)firstType{
    _firstType = firstType;
    isFirstLetter = _firstType;
}
-(BOOL)limiTtextFled:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField.text rangeOfString:@"."].location == NSNotFound)
    {
        isHaveDian = NO;
    }
    if ([string length] > 0)
    {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.')//数据格式正确
        {
            //首字母不能小数点
            if([textField.text length] == 0)
            {
                isFirstLetter = NO;
                if(single == '.')
                {
                    
                    [self showMyMessage:@"亲，第一个数字不能为小数点!"];
                    
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    
                    return NO;
                    
                }
                
                if (single == '0')
                {
                    
                    //                    [self showMyMessage:@"亲，第一个数字不能为0!"];
                    //
                    //                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    //
                    //                    return NO;
                    //允许首字母为0
                    if(!isFirstLetter){
                        isFirstLetter = YES;
                        return YES;
                    }
                    
                    
                    
                }
                
                
            }
            
            //输入的字符是否是小数点
            
            if (single == '.')
            {
                
                if(!isHaveDian)//text中还没有小数点
                {
                    
                    isHaveDian = YES;
                    
                    return YES;
                    
                }else{
                    
                    [self showMyMessage:@"亲，您已经输入过小数点了!"];
                    
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    
                    return NO;
                    
                }
                
            }else{
                
                
                
                if (isHaveDian) {//存在小数点
                    
                    //判断小数点的位数
                    
                    NSRange ran = [textField.text rangeOfString:@"."];
                    
                    if (range.location - ran.location <= self.limitCount) {
                        
                        return YES;
                        
                    }else{
                        
                        [self showMyMessage:[NSString stringWithFormat:@"亲，您最多输入小数点后%ld位!", (long)self.limitCount]];
                        
                        return NO;
                        
                    }
                    
                }else{
                    
                    if (isFirstLetter&&single != '.') {
                        [self showMyMessage:@"亲，您输入的格式错误了"];
                        return NO;
                    }
                    
                    return YES;
                    
                }
                
            }
            
        }else{//输入的数据格式不正确
            
            [self showMyMessage:@"亲，您输入的格式不正确!"];
            
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            
            return NO;
            
        }
        
    }
    
    else
        
    {
        
        return YES;
        
    }
    
    
}

-(void)showMyMessage:(NSString *)str{
    [WXZTipView showCenterWithText:str duration:2];
}

/**
 *  懒加载赋值屏幕高
 *
 *  @return 屏幕高
 */
- (CGFloat )screenHight{
    if (_screenHight == 0) {
        _screenHight = [UIScreen mainScreen].bounds.size.height;
    }
    return _screenHight;
}
/**
 *  懒加载赋值屏幕宽
 *
 *  @return 屏幕宽
 */
- (CGFloat )screenWidth{
    if (_screenWidth == 0) {
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return _screenWidth;
}
- (CGFloat )heightStatus{
    if (_heightStatus == 0) {
        _heightStatus = HeightStatus;
    }
    return _heightStatus;
}
- (CGFloat )navBarHeight{
    if (_navBarHeight == 0) {
        _navBarHeight = NavBarHeight;
    }
    return _navBarHeight;
}
- (CGFloat)tabBarHeight{
    if (_tabBarHeight == 0) {
        _tabBarHeight = TabBarHeight;
    }
    return _tabBarHeight;
}
- (WRCustomNavigationBar *)customNavBar
{
    if (_customNavBar == nil) {
        _customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    }
    return _customNavBar;
}
//版本更新

#pragma mark APP更新
-(void)versionUpdateRequest{
    NSDictionary *dict = @{
                           @"appname" : APP_NAME,
                           @"type" : @"2",
                           @"ver_nod" : APP_VERSION,
                           };
    [networkingManagerTool requestToServerWithType:POST withSubUrl:SXF_LOC_URL_STR(appUpDateUrl) withParameters:dict withResultBlock:^(BOOL result, id value) {
        if (result) {
            if ([value isKindOfClass:[NSDictionary class]]) {
                [self setUpVersion:value[@"data"]];
            }else{
                if (self->updateAlert) {
                    [self->updateAlert removeFromSuperview];
                }
            }
        }
    }];
}



//判断是否有版本更新
- (BOOL)compareVersionsFormAppStore:(NSString*)AppStoreVersion WithAppVersion:(NSString*)AppVersion{
    
    BOOL littleSunResult = false;
    
    NSMutableArray* a = (NSMutableArray*) [AppStoreVersion componentsSeparatedByString: @"."];
    NSMutableArray* b = (NSMutableArray*) [AppVersion componentsSeparatedByString: @"."];
    
    while (a.count < b.count) { [a addObject: @"0"]; }
    while (b.count < a.count) { [b addObject: @"0"]; }
    
    for (int j = 0; j<a.count; j++) {
        if ([[a objectAtIndex:j] integerValue] > [[b objectAtIndex:j] integerValue]) {
            littleSunResult = true;
            break;
        }else if([[a objectAtIndex:j] integerValue] < [[b objectAtIndex:j] integerValue]){
            littleSunResult = false;
            break;
        }else{
            littleSunResult = false;
        }
    }
    return littleSunResult;//true就是有新版本，false就是没有新版本
    
}




//版本设置
-(void)setUpVersion:(NSDictionary *)dataDict{
    if (dataDict != nil && [dataDict isKindOfClass:[NSDictionary class]]) {
        NSString *description = dataDict[@"remark"];
        if (![NSString isNOTNull:description]) {
            [CommonTools setUpdateDescription:description];
        }else{
            [CommonTools setUpdateDescription:@"汉富新生活"];
        }
        // 是否强制更新
        BOOL isForce = [dataDict[@"force_update"] boolValue];
        [CommonTools setIsForce:isForce];
        
        BOOL hasNewVersion = [dataDict[@"is_update"] boolValue];
        [CommonTools setIsHasNewVersion:hasNewVersion];
        NSString *version = [NSString stringWithFormat:@"%@",dataDict[@"ver_nod"]];
        
        
        
        
        [CommonTools setVersionString:version];
        if (![NSString isNOTNull:[NSString stringWithFormat:@"%@",dataDict[@"url"]]]) {
            [CommonTools setUpdateVersionAddress:[NSString stringWithFormat:@"%@",dataDict[@"url"]]];
        }
        //测试
//        version = @"1.0.2";
//        [CommonTools setUpdateVersionAddress:[NSString stringWithFormat:@"%@",@"http://www.baidu.com"]];
        
        if (hasNewVersion) {
            if (updateAlert == nil) {
                [self VersionBounced];
            }else{
                if (isForce) {
                    updateAlert.isMandatory = YES;
                }else{
                    updateAlert.isMandatory = NO;
                }
            }
            
        }else{
            if (updateAlert != nil) {
                [updateAlert removeFromSuperview];
            }
        }
        
    }
}




#pragma mark APP展示更新控件
-(void)VersionBounced{
    __weak __typeof(&*self)weakSelf = self;
    
#warning 临时添加
//    [CommonTools setUpdateDescription:@"汉富新生活"];
//    [CommonTools setVersionString:@"1.0.5"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    CFShow((__bridge CFTypeRef)(infoDictionary));
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if (![app_Version isEqualToString:[CommonTools getVersionString]]&&![NSString isNOTNull:[CommonTools getVersionString]]) {
        BOOL hasNewVersion = [CommonTools IsHasNewVersion] ;
        BOOL isForce =  [CommonTools IsForce] ;
        if (hasNewVersion) {
            if (isForce) {
                //强制更新
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    self->updateAlert = [SELUpdateAlert showUpdateAlertWithVersion:[CommonTools getVersionString] Description:[CommonTools getUpdateDescription]];
                    self->updateAlert.isMandatory = YES;
                    [self->updateAlert setUpdateNow:^{
                        if (![NSString isNOTNull:[CommonTools getVersionAddress]]) {
                            //                            SFSafariViewController * safari = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:[CommonTools getVersionAddress]]];
                            //                            [weakSelf presentViewController:safari animated:YES completion:nil];
                            //                            [self->updateAlert dismissAlert];
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[CommonTools getVersionAddress]]];
                        }else{
                            [WXZTipView showCenterWithText:@"更新地址错误"];
                        }
                    }];
                    
                });
                
            }else{
                if (IsUpdateRemind) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // UI更新代码
                        self->updateAlert = [SELUpdateAlert showUpdateAlertWithVersion:[CommonTools getVersionString] Description:[CommonTools getUpdateDescription]];
                        [self->updateAlert setUpdateNow:^{
                            IsUpdateRemind = YES;
                            //                            SFSafariViewController * safari = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:[CommonTools getVersionAddress]]];
                            //                            [weakSelf presentViewController:safari animated:YES completion:nil];
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[CommonTools getVersionAddress]]];
                        }];
                        [self->updateAlert setDismissBlock:^{
                            IsUpdateRemind = NO;
                        }];
                    });
                    
                    
                }
                
            }
        }
    }
    
}

#pragma mark - 判断是不是首次登录或者版本更新
-(BOOL )isFirstLauch{
    //获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
    //获取上次启动应用保存的appVersion
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:HFAppVersion];
    //版本升级或首次登录
    if (version == nil || ![version isEqualToString:currentAppVersion]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentAppVersion forKey:HFAppVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
}



//手续费计算
-(NSString *)computingCharge:(NSString *)percentage amount:(NSString *)amount{
    NSString *poundage = @"";
    CGFloat percen = [percentage floatValue] / 100;
    poundage = MMNSStringFormat(@"%.4f",percen*[amount floatValue]);
    return poundage;
}

/**
 获取密码
 */
-(BOOL)TransactionPasswordProcessing{
    //    if (![UserCache getUserTradePassword]) {
    //        LXAlertView *alert=[[LXAlertView alloc] initWithTitle:ChooseWord(@"温馨提示", self.languageFile) message:ChooseWord(@"您还为设置交易密码，请设置您的交易密码", self.languageFile) cancelBtnTitle:ChooseWord(@"取消",self.languageFile) otherBtnTitle:ChooseWord(@"确定",self.languageFile) clickIndexBlock:^(NSInteger clickIndex) {
    //            if (clickIndex == 1) {
    //                ForgetTradePasswordVC *forget = [[ForgetTradePasswordVC alloc]init];
    //                forget.isForgotPassword = NO;
    //                [self.navigationController pushViewController:forget animated:YES];
    //            }else{
    //                [self.navigationController popViewControllerAnimated:YES];
    //            }
    //        }];
    //        alert.animationStyle=LXASAnimationTopShake;
    //        [alert showLXAlertView];
    //    }
//    return [UserCache getUserTradePassword];
    return NO ;
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
//网络状态通知
- (void) netStatus:(NSNotification *)notification{
    NSLog(@"--网络状态%@" , notification.object);
    switch ([notification.object integerValue]) {
        case WIFI:
            
            break;
        case MOBEL:
            
            break;
        case BASY:
            
            break;
        case NONET:
            
            break;
        default:
            break;
    }
}














//通过rgb创建图片
- (UIImage *)imageWithRGBColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    NSLog(@"%@ dealloc-----------", NSStringFromClass([self class]));
}

@end
