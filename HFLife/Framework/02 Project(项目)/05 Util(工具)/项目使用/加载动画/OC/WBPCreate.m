//
//  WBProgressHUD+WBPCreate.m
//  HFLife
//
//  Created by mac on 2019/1/30.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "WBPCreate.h"
#import "UIImage+GIF.h"
@implementation WBPCreate
{
    WBLoadingHUD *loading;
    UIImageView *lodingImage;
    UIView *bgView;
    UIView *imageBgView;
    BOOL _isGIF;

}
+(instancetype)sharedInstance{
    static WBPCreate *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WBPCreate new];
    });
    return instance;
}
-(void)showWBProgress{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    if (!loading) {
//        loading = [[WBLoadingHUD alloc] initWithFrame:CGRectMake(window.centerX-25, window.centerY-25, 50, 50)];
//    }
//    [window addSubview:loading];
//    [loading start];
    if (!bgView) {
        bgView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAnimated)];
        tap.delegate = self;
        [bgView addGestureRecognizer:tap];
    }
    
    if (!imageBgView) {
      imageBgView = [[UIView alloc] initWithFrame:CGRectMake(bgView.centerX-25, bgView.centerY-25 + 40, 50, 50)];
    }
    imageBgView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0];
    MMViewBorderRadius(imageBgView, 10, 0, [UIColor colorWithWhite:0.3 alpha:0.7]);
    [bgView addSubview:imageBgView];
    
    if (!lodingImage) {
        lodingImage = [[UIImageView alloc]initWithFrame:CGRectMake(bgView.centerX-25, bgView.centerY-25 + 40, 50, 50)];
//        lodingImage.image = MMGetImage(@"barCode_icon");
        NSString *path = [[NSBundle mainBundle] pathForResource:@"load_GIF" ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        lodingImage.image = [UIImage sd_animatedGIFWithData:data];
        if ([path hasSuffix:@".gif"] || [path hasSuffix:@".GIF"]) {
            _isGIF = YES;
        }else {
            _isGIF = NO;
            lodingImage.image = MMGetImage(@"logo");
        }
    }
    [window addSubview:bgView];
    [bgView addSubview:lodingImage];
    if (!_isGIF) {
        CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
        animation.duration  = 1;
        animation.autoreverses = NO;
        animation.fillMode =kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
        [lodingImage.layer addAnimation:animation forKey:nil];;
    }
   
}
-(void)hideAnimated{
    NSLog(@"hideAnimated");
    if (lodingImage != nil) {
        [lodingImage.layer removeAllAnimations];
        [lodingImage removeFromSuperview];
        lodingImage = nil;
        
        [bgView removeFromSuperview];
        bgView = nil;
        [imageBgView removeFromSuperview];
        imageBgView = nil;
        
//        [loading hideAnimated:YES];
//        [loading removeFromSuperview];
//        loading = nil;
    }
    

}
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    CGPoint point = [touch locationInView:bgView];
    
    CGRect rect = CGRectMake(0, IS_IPHONE_X ? 34 : 20, 50, 50);
    
    if (CGRectContainsPoint( rect,  point)) {
        
        [[self topViewController].navigationController popViewControllerAnimated:YES];
        [self hideAnimated];
        return NO;
    }
    
    
    if ([touch.view isDescendantOfView:bgView]) {
        return NO;
    }
    
    if ([touch.view isKindOfClass:[UITextField class]]){
        return NO;
    }
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    // NSLog(NSStringFromClass([touch.view class]));
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    
    return YES;
}
@end
