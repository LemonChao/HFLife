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
@property(nonatomic, strong) UILabel *setingL;//去设置
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
    self.actiView = view;
    
    [self addSubview:view];
    [self.actiView addSubview:self.imageV];
    [self.actiView addSubview:self.delV];
    [self.actiView addSubview:self.failL];
    [self.actiView addSubview:self.lessL];
    [self.actiView addSubview:self.setingL];
    
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
    
    self.setingL.text = @" 手动设置 ";
    self.setingL.font = FONT(15);
    self.setingL.textColor = HEX_COLOR(0xCA1400);
    self.setingL.layer.cornerRadius = 14.5;
    self.setingL.clipsToBounds = YES;
    self.setingL.layer.borderWidth = 1.0;
    self.setingL.layer.borderColor = HEX_COLOR(0xCA1400).CGColor;
    self.setingL.textAlignment = NSTextAlignmentCenter;
    
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
    
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remove:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
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
        make.height.mas_equalTo(ScreenScale(268));
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
        make.width.mas_equalTo(ScreenScale(109));
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
        }
    }
}


@end
