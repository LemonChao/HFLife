//
//  SELUpdateAlert.m
//  SelUpdateAlert
//
//  Created by zhuku on 2018/2/7.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import "SELUpdateAlert.h"
#import "SELUpdateAlertConst.h"

// SCREEN_HEIGHT/3*2
#define DEFAULT_MAX_HEIGHT ScreenScale(395)

@interface SELUpdateAlert()
{
    UIButton *cancelButton;
}
/** 版本号 */
@property (nonatomic, copy) NSString *version;
/** 版本更新内容 */
@property (nonatomic, copy) NSString *desc;

@end

@implementation SELUpdateAlert

/**
 添加版本更新提示

 @param version 版本号
 @param descriptions 版本更新内容（数组）
 
 descriptions 格式如 @[@"1.xxxxxx",@"2.xxxxxx"]
 */
+ (id)showUpdateAlertWithVersion:(NSString *)version Descriptions:(NSArray *)descriptions
{
    if (!descriptions || descriptions.count == 0) {
        return nil;
    }
    
    //数组转换字符串，动态添加换行符\n
    NSString *description = @"";
    for (NSInteger i = 0;  i < descriptions.count; ++i) {
        id desc = descriptions[i];
        if (![desc isKindOfClass:[NSString class]]) {
            return nil;
        }
        description = [description stringByAppendingString:desc];
        if (i != descriptions.count-1) {
            description = [description stringByAppendingString:@"\n"];
        }
    }
    NSLog(@"====%@",description);
    SELUpdateAlert *updateAlert = [[SELUpdateAlert alloc]initVersion:version description:description];
    
    return updateAlert;
}

/**
 添加版本更新提示

 @param version 版本号
 @param description 版本更新内容（字符串）
 
description 格式如 @"1.xxxxxx\n2.xxxxxx"
 */
+ (id)showUpdateAlertWithVersion:(NSString *)version Description:(NSString *)description
{
    SELUpdateAlert *updateAlert = [[SELUpdateAlert alloc]initVersion:version description:description];
//    [[UIApplication sharedApplication].delegate.window addSubview:updateAlert];
    return updateAlert;
}

- (instancetype)initVersion:(NSString *)version description:(NSString *)description
{
    self = [super init];
    if (self) {
        self.version = version;
        self.desc = description;
        
        [self _setupUI];
    }
    return self;
}

- (void)_setupUI
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3/1.0];
    
    //获取更新内容高度
    CGFloat descHeight = [self _sizeofString:self.desc font:[UIFont systemFontOfSize:SELDescriptionFont] maxSize:CGSizeMake(self.frame.size.width - Ratio(80) - Ratio(56), 1000)].height;
    
    //bgView实际高度
    CGFloat realHeight = descHeight + Ratio(314);
    
    //bgView最大高度
//    CGFloat maxHeight = DEFAULT_MAX_HEIGHT;
    CGFloat maxHeight = DEFAULT_MAX_HEIGHT;
    //更新内容可否滑动显示
    BOOL scrollEnabled = NO;
    
    //重置bgView最大高度 设置更新内容可否滑动显示
    if (realHeight > DEFAULT_MAX_HEIGHT) {
        scrollEnabled = YES;
        descHeight = DEFAULT_MAX_HEIGHT - Ratio(314);
    }else
    {
        maxHeight = realHeight;
    }
    
    //backgroundView
    UIView *bgView = [[UIView alloc]init];
    bgView.center = self.center;
    bgView.bounds = CGRectMake(0, 0, self.frame.size.width - Ratio(40), maxHeight+ScreenScale(70));
    [self addSubview:bgView];
    
    bgView.backgroundColor = [UIColor clearColor];
    
    //添加更新提示
    UIView *updateView = [[UIView alloc]initWithFrame:CGRectMake(Ratio(20), Ratio(0), bgView.frame.size.width - Ratio(40), maxHeight + ScreenScale(40))];
    updateView.backgroundColor = [UIColor whiteColor];
    updateView.layer.masksToBounds = YES;
    updateView.layer.cornerRadius = 4.0f;
    [bgView addSubview:updateView];
    
    //20+166+10+28+10+descHeight+20+40+20 = 314+descHeight 内部元素高度计算bgView高度
    UIImageView *updateIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, updateView.frame.size.width, updateView.frame.size.width / 300.0 * 216.0)];
    updateIcon.image = [UIImage imageNamed:@"VersionUpdate_Icon"];
    [updateView addSubview:updateIcon];
    
    //版本号
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Ratio(-10) + CGRectGetMaxY(updateIcon.frame), updateView.frame.size.width, Ratio(28))];
    versionLabel.font = [UIFont systemFontOfSize:18];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.text = [NSString stringWithFormat:@"发现新版本 V%@",self.version];
    [updateView addSubview:versionLabel];
    versionLabel.textColor = HEX_COLOR(0xCA1400);
    
    //更新内容
    UITextView *descTextView = [[UITextView alloc]initWithFrame:CGRectMake(Ratio(28), Ratio(10) + CGRectGetMaxY(versionLabel.frame), updateView.frame.size.width - Ratio(56), descHeight)];
    descTextView.font = [UIFont systemFontOfSize:SELDescriptionFont];
    descTextView.textContainer.lineFragmentPadding = 0;
    descTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    descTextView.text = self.desc;
    descTextView.editable = NO;
    descTextView.selectable = NO;
    descTextView.scrollEnabled = scrollEnabled;
    descTextView.showsVerticalScrollIndicator = scrollEnabled;
    descTextView.showsHorizontalScrollIndicator = NO;
    descTextView.textAlignment = NSTextAlignmentCenter;
    [updateView addSubview:descTextView];
    
    if (scrollEnabled) {
        //若显示滑动条，提示可以有滑动条
        [descTextView flashScrollIndicators];
    }
    
    //更新按钮
    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    updateButton.backgroundColor = HEX_COLOR(0xCA1400);
    updateButton.frame = CGRectMake(ScreenScale(35), CGRectGetMaxY(descTextView.frame) + Ratio(20), updateView.frame.size.width - ScreenScale(70), ScreenScale(44));
    updateButton.clipsToBounds = YES;
    updateButton.layer.cornerRadius = updateButton.frame.size.height * 0.5;
    [updateButton addTarget:self action:@selector(updateVersion) forControlEvents:UIControlEventTouchUpInside];
    [updateButton setTitle:@"立即更新" forState:UIControlStateNormal];
    [updateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [updateView addSubview:updateButton];
    
    //取消按钮
    cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    cancelButton.center = CGPointMake(CGRectGetMaxX(updateView.frame), CGRectGetMinY(updateView.frame));
    cancelButton.frame = CGRectMake(0, 0, ScreenScale(36), ScreenScale(36));
    cancelButton.center = CGPointMake(bgView.center.x, CGRectGetMaxY(bgView.frame) + ScreenScale(20));
    cancelButton.backgroundColor = [UIColor clearColor];
//    cancelButton.bounds = CGRectMake(0, 0, Ratio(36), Ratio(36));
    [cancelButton setImage:[[UIImage imageNamed:@"VersionUpdate_Cancel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    //显示更新
    [self showWithAlert:bgView];
    
    [self addSubview:cancelButton];
}

/** 更新按钮点击事件 跳转AppStore更新 */
- (void)updateVersion
{
//    NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@", APP_ID];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    if (self.updateNow) {
        self.updateNow();
    }
    if (!self.isMandatory) {
        [self dismissAlert];
    }
    
}

/** 取消按钮点击事件 */
- (void)cancelAction
{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    [self dismissAlert];
}

/**
 添加Alert入场动画
 @param alert 添加动画的View
 */
- (void)showWithAlert:(UIView*)alert{
    
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = SELAnimationTimeInterval;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [alert.layer addAnimation:animation forKey:nil];
}


/** 添加Alert出场动画 */
- (void)dismissAlert{
    
    [UIView animateWithDuration:SELAnimationTimeInterval animations:^{
        self.transform = (CGAffineTransformMakeScale(1.5, 1.5));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
    
}

/**
 计算字符串高度
 @param string 字符串
 @param font 字体大小
 @param maxSize 最大Size
 @return 计算得到的Size
 */
- (CGSize)_sizeofString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize
{
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
}


-(void)setIsMandatory:(BOOL)isMandatory{
    _isMandatory = isMandatory;
    cancelButton.hidden = _isMandatory;
}

@end
