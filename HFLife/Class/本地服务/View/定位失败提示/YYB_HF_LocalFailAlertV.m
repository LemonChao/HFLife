//
//  YYB_HF_LocalFailAlertV.m
//  HFLife
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_LocalFailAlertV.h"
@interface YYB_HF_LocalFailAlertV()<UIGestureRecognizerDelegate>
@property(nonatomic, strong) UIView *actiView;//底视图
@property(nonatomic, strong) UIImageView *imageV;//图片
@property(nonatomic, strong) UIImageView *delV;//取消图片
@property(nonatomic, strong) UILabel *failL;//错误提示
@property(nonatomic, strong) UILabel *lessL;//
@property(nonatomic, strong) UILabel *setingL;//去设置定位
@property(nonatomic, strong) UILabel *seting2L;//去设置位置

@end

@implementation YYB_HF_LocalFailAlertV

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
+ (instancetype)shareInstance {
    static YYB_HF_LocalFailAlertV *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[YYB_HF_LocalFailAlertV alloc]init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self openLocalView];
    }
    return self;
}


- (void)openLocalView {
    
    UIView *view = [UIView new];
    self.imageV = [UIImageView new];
    self.delV = [UIImageView new];
    self.failL = [UILabel new];
    self.lessL = [UILabel new];
    
    self.setingL = [UILabel new];
    self.seting2L = [UILabel new];

    self.actiView = view;
    
    [self addSubview:view];
    [self.actiView addSubview:self.imageV];
    [self.actiView addSubview:self.delV];
    [self.actiView addSubview:self.failL];
    [self.actiView addSubview:self.lessL];
    [self.actiView addSubview:self.setingL];
    [self.actiView addSubview:self.seting2L];

    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.actiView.backgroundColor = [UIColor whiteColor];
    self.actiView.clipsToBounds = YES;
    self.actiView.layer.cornerRadius = 5;
    self.imageV.image = image(@"local_no");
    self.delV.image = image(@"关闭");
    
    self.failL.text = @"定位失败";
    self.failL.textColor = HEX_COLOR(0x0C0B0B);
    self.failL.font = FONT(15);
    
    self.lessL.text = @"缺少定位服务";
    self.lessL.textColor = HEX_COLOR(0xAAAAAA);
    self.lessL.font = FONT(11);
    
    self.setingL.text = @" 前往开启定位服务 ";
    self.setingL.font = FONT(15);
    self.setingL.textColor = HEX_COLOR(0xCA1400);
    self.setingL.layer.cornerRadius = 14.5;
    self.setingL.clipsToBounds = YES;
    self.setingL.layer.borderWidth = 1.0;
    self.setingL.layer.borderColor = HEX_COLOR(0xCA1400).CGColor;
    self.setingL.textAlignment = NSTextAlignmentCenter;
    
    self.seting2L.text = @" 手动选取定位服务 ";
    self.seting2L.font = FONT(15);
    self.seting2L.textColor = HEX_COLOR(0xCA1400);
    self.seting2L.layer.cornerRadius = 14.5;
    self.seting2L.clipsToBounds = YES;
    self.seting2L.layer.borderWidth = 1.0;
    self.seting2L.layer.borderColor = HEX_COLOR(0xCA1400).CGColor;
    self.seting2L.textAlignment = NSTextAlignmentCenter;
    
    [self.delV setUserInteractionEnabled:YES];
    [self.delV wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self removeFromSuperview];
    }];
   
    [self.setingL setUserInteractionEnabled:YES];
    [self.setingL wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        
        NSURL *url = [[NSURL alloc] initWithString:UIApplicationOpenSettingsURLString];
        
        if( [[UIApplication sharedApplication] canOpenURL:url])
        {
            [self removeFromSuperview];
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:nil completionHandler:^(BOOL success) {
                    
                }];
            }else {
                [[UIApplication sharedApplication] openURL:url];
            }
        }else {
            
        }
    }];
    
    [self.seting2L setUserInteractionEnabled:YES];
    [self.seting2L wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
            //去选择位置
            //地址选择
            dispatch_async(dispatch_get_main_queue(), ^{
                YYB_HF_WKWebVC *vc = [[YYB_HF_WKWebVC alloc]init];
                vc.urlString = kH5LocaAdress(kChoiceCity);
                
                vc.choiceCity = ^(NSString * _Nonnull city) {
                    [YYB_HF_LocalFailAlertV uploadBackLocation:city];
                };
                [self.getCurrentViewController.navigationController pushViewController:vc animated:YES];
                [self removeFromSuperview];

            });
    }];
    
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remove:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
}

#pragma mark - 上传定位
+ (void)uploadBackLocation:(NSString *)city{
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
    }
}

- (void)remove:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch
{
    if ([touch.view isDescendantOfView:self.actiView])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}
//

- (void)show {
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    self.frame = rootWindow.bounds;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
    
}

- (void)creatShowAnimation {
    self.actiView.layer.position = self.center;
    self.actiView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.actiView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.actiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(ScreenScale(205));
        make.height.mas_equalTo(ScreenScale(268 + 40));
    }];
    
    [self.delV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.actiView).mas_equalTo(ScreenScale(10));
        make.right.mas_equalTo(self.actiView).mas_equalTo(ScreenScale(-10));
        make.width.height.mas_equalTo(ScreenScale(16));
    }];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.actiView).mas_offset(ScreenScale(25));
        make.centerX.mas_equalTo(self.actiView);
        make.width.mas_equalTo(ScreenScale(129));
        make.height.mas_equalTo(ScreenScale(114));
    }];
    
    [self.failL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageV.mas_bottom).mas_offset(ScreenScale(23));
        make.centerX.mas_equalTo(self.actiView);
        make.height.mas_equalTo(ScreenScale(15));
    }];
    
    [self.lessL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.failL.mas_bottom).mas_offset(ScreenScale(7));
        make.centerX.mas_equalTo(self.actiView);
        make.height.mas_equalTo(ScreenScale(11));
    }];
    
    [self.setingL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lessL.mas_bottom).mas_offset(ScreenScale(20));
        make.centerX.mas_equalTo(self.actiView);
        make.height.mas_equalTo(ScreenScale(29));
    }];
    
    [self.seting2L mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.setingL.mas_bottom).mas_offset(ScreenScale(10));
        make.centerX.mas_equalTo(self.actiView);
        make.height.mas_equalTo(ScreenScale(29));
    }];
}

//检查定位权限
+ (void)detectionLocationState:(void(^)(int type))authorizedBlock
{
    //type 0可以使用 ，1开启app权限 ，2 开启系统服务
    
    CLAuthorizationStatus  authStatus = [CLLocationManager authorizationStatus];
    int type = 0;
    if (@available(iOS 8.0, *)) {
        
        //检测位置服务是否可用
        if([CLLocationManager locationServicesEnabled]) {
            //用户尚未授权
            if (authStatus == kCLAuthorizationStatusNotDetermined) {
                
            }
            //用户已经授权
            else if (authStatus == kCLAuthorizationStatusAuthorizedAlways||authStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
                
            }
            //用户决绝授权
            else {
                //提示用户打开定位权限
                type = 1;
            }
        }
        else {
            //提示用户打开定位权限
            type = 2;
        }
        
        if (authorizedBlock)
        {
            authorizedBlock(type);
            if (type == 0) {
                //app 已开启定位
            }else {
                //系统 未开启定位
                authorizedBlock(type);
            }
        }
    }
}


@end
