//
//  ZRToastWindow.m
//  geqw
//
//  Created by Mr.z on 16/6/21.
//  Copyright © 2016年 Obgniyum. All rights reserved.
//

#import "JQToastWindow.h"

@interface JQToastWindow ()

@property (weak, nonatomic) IBOutlet UIImageView *circleImageView;

@property (nonatomic, assign) NSInteger showCount;
@property (nonatomic ,strong) NSTimer *timer;

@property (nonatomic ,strong) NSTimer *autoReleaseTimer;//自动释放计时器

@end

@implementation JQToastWindow

+ (instancetype)shareInstance {
    static JQToastWindow * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL]init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [JQToastWindow shareInstance];
}
- (instancetype)copyWithZone:(struct _NSZone *)zone{
    return [JQToastWindow shareInstance];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _showCount = 0;
        self.rootViewController = [[UIViewController alloc] init];
        self.windowLevel = self.rootViewController.view.window.windowLevel;
        
       
        
    }
    return self;
}
- (void)layoutSubviews {
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 4.0];
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.speed = 4.0;
    rotationAnimation.duration = 3;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1000000000;
    [self.circleImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)showToast {
    self.showCount++;
    [self makeKeyAndVisible];
}

- (void)hiddenToast {
    self.showCount--;
    NSLog(@"%ld已经加载的个数----ld" , self.showCount);
    if (!self.showCount) {
        NSLog(@"释放了---------------");
        self.hidden = YES;
    }
}






@end
