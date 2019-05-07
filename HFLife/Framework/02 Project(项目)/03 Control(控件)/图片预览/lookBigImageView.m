//
//  lookBigImageView.m
//  huzhu
//
//  Created by CTD－JJP on 17/3/18.
//  Copyright © 2017年 sxf. All rights reserved.
//

#import "lookBigImageView.h"

@interface lookBigImageView()


@end
@implementation lookBigImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame])
    {
        [self layoutMySubViews];
    }
    
    return self;
    
    
}

- (void) setBgViewColor:(UIColor *)color;
{
    self.bgView.backgroundColor = color;
}
- (UIView *)getColor:(UIColor *)color
{
    _bgView.backgroundColor = color;
    return _bgView;
}
- (void) layoutMySubViews
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, self.frame.size.width - 20, self.frame.size.height - 30)];
//    self.imageView.layer.cornerRadius = 5;
//    self.imageView.clipsToBounds = YES;
//    self.imageView.layer.borderWidth = 1;
    self.imageView.userInteractionEnabled = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"关闭1"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.center = CGPointMake(self.imageView.frame.size.width * 0.5, self.frame.size.height - 55);
    

    
    self.alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.alertLabel.center = self.imageView.center;
    self.alertLabel.textAlignment = NSTextAlignmentCenter;
//    self.alertLabel.text = @"正在加载，请稍后...";
    self.alertLabel.textColor = [UIColor whiteColor];
    self.alertLabel.layer.cornerRadius = 5;
    [self addSubview:self.alertLabel];
    [self addSubview:self.imageView];
    [self.imageView addSubview:closeBtn];
}





- (void)show
{
    if (self.bgView) return;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.bgView.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.imageView addGestureRecognizer:tap];
    
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.0;
    self.imageView.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.alpha = 0.8;
         self.imageView.transform = CGAffineTransformMakeScale(1, 1);
    }];
    [window addSubview:self.bgView];
    [window addSubview:self];
    
}
- (void)close
{
    self.bgView.alpha = 0.8;
    self.imageView.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.alpha = 0.0;
        self.imageView.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        self.bgView = nil;
        [self removeFromSuperview];
    }];
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    [self close];
}




@end
