//
//  DHGuidePageHUD.m
//  DHGuidePageHUD
//
//  Created by Apple on 16/7/14.
//  Copyright © 2016年 dingding3w. All rights reserved.
//

#import "DHGuidePageHUD.h"
#import "DHGifImageOperation.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "UIImage+Developer.h"
#import "WGButtnAniView.h"
#import "WGCircleAniView.h"
#define DDHidden_TIME   3.0
#define DDScreenW   [UIScreen mainScreen].bounds.size.width
#define DDScreenH   [UIScreen mainScreen].bounds.size.height

@interface DHGuidePageHUD ()<UIScrollViewDelegate, CAAnimationDelegate>
@property (nonatomic, strong) NSArray                 *imageArray;
@property (nonatomic, strong) UIPageControl           *imagePageControl;
@property (nonatomic, assign) NSInteger               slideIntoNumber;
@property (nonatomic, strong) MPMoviePlayerController *playerController;
@property (nonatomic, strong)UIButton *cycleBtn;
@property (nonatomic, strong)CAShapeLayer *shapeLayer;
@end

@implementation DHGuidePageHUD

- (instancetype)dh_initWithFrame:(CGRect)frame imageNameArray:(NSArray<NSString *> *)imageNameArray buttonIsHidden:(BOOL)isHidden {
    if ([super initWithFrame:frame]) {
        self.slideInto = NO;
        if (isHidden == YES) {
            self.imageArray = imageNameArray;
        }
        
        // 设置引导视图的scrollview
        UIScrollView *guidePageView = [[UIScrollView alloc]initWithFrame:frame];
        [guidePageView setBackgroundColor:[UIColor lightGrayColor]];
        [guidePageView setContentSize:CGSizeMake(DDScreenW*imageNameArray.count, DDScreenH)];
        [guidePageView setBounces:NO];
        [guidePageView setPagingEnabled:YES];
        [guidePageView setShowsHorizontalScrollIndicator:NO];
        [guidePageView setDelegate:self];
        [self addSubview:guidePageView];
        
        // 设置引导页上的跳过按钮
        UIButton *skipButton = [[UIButton alloc]initWithFrame:CGRectMake(DDScreenW*0.8, DDScreenW*0.1, 50, 25)];
        [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
        [skipButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [skipButton setBackgroundColor:[UIColor grayColor]];
        // [skipButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        // [skipButton.layer setCornerRadius:5.0];
        [skipButton.layer setCornerRadius:(skipButton.frame.size.height * 0.5)];
        [skipButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:skipButton];
        
        // 添加在引导视图上的多张引导图片
        for (int i=0; i<imageNameArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(DDScreenW*i, 0, DDScreenW, DDScreenH)];
            if ([[DHGifImageOperation dh_contentTypeForImageData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageNameArray[i] ofType:nil]]] isEqualToString:@"gif"]) {
                NSData *localData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageNameArray[i] ofType:nil]];
                imageView = (UIImageView *)[[DHGifImageOperation alloc] initWithFrame:imageView.frame gifImageData:localData];
                [guidePageView addSubview:imageView];
            } else {
                imageView.image = [UIImage imageNamed:imageNameArray[i]];
                [guidePageView addSubview:imageView];
            }
            
            // 设置在最后一张图片上显示进入体验按钮
            if (i == imageNameArray.count-1 && isHidden == NO) {
                [imageView setUserInteractionEnabled:YES];
                UIButton *startButton = [[UIButton alloc]initWithFrame:CGRectMake(DDScreenW*0.3, ScreenScale(DDScreenH*0.95), WidthRatio(250), HeightRatio(100))];
                [startButton setTitle:@"立即体验" forState:UIControlStateNormal];
#warning 使用图片上的按钮
                [startButton setTitle:@"" forState:UIControlStateNormal];
                
                
                
                [startButton setTitleColor:[UIColor whiteColor ] forState:UIControlStateNormal];
                [startButton.titleLabel setFont:[UIFont systemFontOfSize:WidthRatio(25)]];
                startButton.backgroundColor = [UIColor clearColor];
//                [startButton setBackgroundImage:[UIImage imageNamed:@"GuideImage.bundle/guideImage_button_backgound"] forState:UIControlStateNormal];
//                [startButton setImage:[[UIImage imageNamed:@"GuideImage.bundle/guideImage_button_backgound"] imageWithColor:HEX_COLOR(0x54a8dd)] forState:UIControlStateNormal];
                [startButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [imageView addSubview:startButton];
                [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(imageView.mas_centerX);
                    make.bottom.mas_equalTo(imageView.mas_bottom).offset(-(DDScreenH - DDScreenH*0.95));
                    make.width.mas_equalTo(WidthRatio(250));
                    make.height.mas_equalTo(HeightRatio(100));
                }];
                MMViewBorderRadius(startButton, 5, 0, [UIColor clearColor]);
            }
        }
        
        // 设置引导页上的页面控制器
        self.imagePageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(DDScreenW*0.0, DDScreenH*0.9, DDScreenW*1.0, DDScreenH*0.1)];
        self.imagePageControl.currentPage = 0;
        self.imagePageControl.numberOfPages = imageNameArray.count;
        self.imagePageControl.pageIndicatorTintColor = [UIColor grayColor];
        self.imagePageControl.currentPageIndicatorTintColor = HEX_COLOR(0x9A58D2);
        [self addSubview:self.imagePageControl];
        
        
        self.imagePageControl.hidden = YES;
        
    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollview {
    int page = scrollview.contentOffset.x / scrollview.frame.size.width;
    [self.imagePageControl setCurrentPage:page];
    if (self.imageArray && page == self.imageArray.count-1 && self.slideInto == NO) {
        [self buttonClick:nil];
    }
    if (self.imageArray && page < self.imageArray.count-1 && self.slideInto == YES) {
        self.slideIntoNumber = 1;
    }
    if (self.imageArray && page == self.imageArray.count-1 && self.slideInto == YES) {
        UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:nil action:nil];
        if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight){
            self.slideIntoNumber++;
            if (self.slideIntoNumber == 3) {
                [self buttonClick:nil];
            }
        }
    }
}

- (void)buttonClick:(UIButton *)button {
    [UIView animateWithDuration:DDHidden_TIME animations:^{
        self.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DDHidden_TIME * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self performSelector:@selector(removeGuidePageHUD) withObject:nil afterDelay:0.1];
        });
    }];
}

- (void)removeGuidePageHUD {
    [self removeFromSuperview];
}

/**< APP视频新特性页面(新增测试模块内容) */
- (instancetype)dh_initWithFrame:(CGRect)frame videoURL:(NSURL *)videoURL {
    if ([super initWithFrame:frame]) {
        self.playerController = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
        [self.playerController.view setFrame:frame];
        [self.playerController.view setAlpha:1.0];
        [self.playerController setControlStyle:MPMovieControlStyleNone];
        [self.playerController setRepeatMode:MPMovieRepeatModeOne];
        [self.playerController setShouldAutoplay:YES];
        [self.playerController prepareToPlay];
        self.playerController.scalingMode = MPMovieScalingModeAspectFill;
        self.playerController.repeatMode = MPMovieRepeatModeNone;
        [self addSubview:self.playerController.view];
        self.playerController.fullscreen = YES;
        // 视频引导页进入按钮
        UIButton *movieStartButton = [[UIButton alloc] initWithFrame:CGRectMake(20, DDScreenH-30-40, DDScreenW-40, 40)];
        [movieStartButton.layer setBorderWidth:1.0];
        [movieStartButton.layer setCornerRadius:20.0];
        [movieStartButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        [movieStartButton setTitle:@"开始体验" forState:UIControlStateNormal];
        [movieStartButton setAlpha:0.0];
        [self.playerController.view addSubview:movieStartButton];
        [movieStartButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [UIView animateWithDuration:DDHidden_TIME animations:^{
            [movieStartButton setAlpha:1.0];
        }];
        
        movieStartButton.hidden = YES;
        
        
        
        
        
        
        
    }
    return self;
}

- (void)startCycleAnimation{
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(self.frame.size.width - 50, HeightStatus, 40, 40);
    btn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    [btn setTitle:@"跳过" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:colorCA1400 forState:UIControlStateNormal];
    [self addSubview:btn];
    self.cycleBtn = btn;
    [self.cycleBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cycleBtn.layer.cornerRadius = self.cycleBtn.frame.size.width * 0.5;
    self.cycleBtn.layer.masksToBounds = YES;
    
    
    self.shapeLayer = [[CAShapeLayer alloc] init];
    
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter:CGPointMake(self.cycleBtn.frame.size.width * 0.5, self.cycleBtn.frame.size.width * 0.5) radius:self.cycleBtn.frame.size.height/2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    
    
    _shapeLayer.path = circlePath.CGPath;
    _shapeLayer.lineWidth = 5;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.cycleBtn.layer addSublayer:_shapeLayer];
    [self startCircleAniColor:colorCA1400 duation:self.videoDuration];
    
}

- (void)startCircleAniColor:(UIColor *)color duation:(CGFloat)duation{
    
    self.hidden = NO;
    self.shapeLayer.strokeColor = color.CGColor;
    
    CABasicAnimation *ani = [[CABasicAnimation alloc] init];
    ani.keyPath = @"strokeEnd";
    ani.duration = duation;
    ani.fromValue = @(0);
    ani.toValue = @(1);
    ani.delegate = self;
    ani.fillMode = kCAFillModeForwards;
    [ani setRemovedOnCompletion:NO];
    [self.shapeLayer addAnimation:ani forKey:nil];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if (flag) {
        //进度动画完成,回调
//        if (self.circleAniViewDelegate && [self.circleAniViewDelegate respondsToSelector:@selector(aniDidStop:finished:)]) {
//
//            self.hidden = YES;
//            [self.circleAniViewDelegate aniDidStop:anim finished:flag];
//        }
        [self buttonClick:self.cycleBtn];
    }
    
}



- (void) stopCycleAnimation{
    
}


- (void)setVideoDuration:(CGFloat)videoDuration{
    _videoDuration = videoDuration;
//    [self performSelector:@selector(buttonClick:) withObject:nil afterDelay:(videoDuration - 0.1)];
    //圆环f动画
    [self startCycleAnimation];
}
@end
