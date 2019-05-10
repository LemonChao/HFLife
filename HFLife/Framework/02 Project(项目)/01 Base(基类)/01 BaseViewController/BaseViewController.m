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

@implementation BaseViewController
{
    BOOL isHaveDian;
    //首字母是否为0
    BOOL isFirstLetter;
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
//    self.navigationController.navigationBarHidden = YES;
    [self setupNavBar];
}

- (void)setupNavBar
{
    [self.view addSubview:self.customNavBar];
    
    // 设置自定义导航栏背景图片
//    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"navi_bg"];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    // 设置自定义导航栏标题颜色
    self.customNavBar.titleLabelColor = HEX_COLOR(0x0C0B0B);
    
    if (self.navigationController.childViewControllers.count != 1) {
        for (UIViewController *vc in self.navigationController.childViewControllers) {
            NSLog(@"vc = %@", NSStringFromClass([vc class]));
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



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.view addSubview:self.customNavBar];
    self.navigationController.navigationBar.hidden = YES;
    //百度单页面统计
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   self.navigationController.navigationBar.hidden = NO;
    
    //百度单页面统计
//    [[BaiduMobStat defaultStat] pageviewEndWithName:self.title];
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
    return [UserCache getUserTradePassword];
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


@end
