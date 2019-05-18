//
//  SXF_HF_leftRightAlert.m
//  HFLife
//
//  Created by mac on 2019/5/18.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_leftRightAlert.h"

@interface SXF_HF_leftRightAlert()
@property (nonatomic, strong)UIImageView *bgImgeV;

@property (nonatomic, strong)UIButton *btn1;
@property (nonatomic, strong)UIView *lineV;
@property (nonatomic, strong)UIButton *btn2;
@end



@implementation SXF_HF_leftRightAlert

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    self.bgImgeV = [UIImageView new];
    self.btn1  = [[UIButton alloc] init];
    self.btn2  = [UIButton new];
    self.lineV = [UIView new];
    
    [self addSubview:_bgImgeV];
    [self addSubview:_btn1];
    [self addSubview:_btn2];
    [self addSubview:self.lineV];
    self.lineV.backgroundColor = HEX_COLOR(0xF5F5F5);
    _btn1.setTitle(@"开启到账语音提醒", UIControlStateNormal).setTitleFontSize(14).setTitleColor(HEX_COLOR(0x0C0B0B), UIControlStateNormal);
    _btn2.setTitle(@"收款码介绍", UIControlStateNormal).setTitleFontSize(14).setTitleColor(HEX_COLOR(0x0C0B0B), UIControlStateNormal);
    _bgImgeV.image = MY_IMAHE(@"右上弹窗");
    [_btn1 addTarget:self action:@selector(clickAkertBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(clickAkertBtn:) forControlEvents:UIControlEventTouchUpInside];
    _btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _btn1.tag = 399;
    _btn2.tag = 400;
}
- (void)clickAkertBtn:(UIButton *)sender{
    NSInteger index = sender.tag - 399;
    !self.clickAlertBtn ? : self.clickAlertBtn(index);
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.bgImgeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
    
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(13));
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(4));
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(ScreenScale(43));
    }];
    
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-12));
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(12));
        make.top.mas_equalTo(self.btn1.mas_bottom);
        
    }];
    
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(13));
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.lineV.mas_bottom);
    }];
}

@end
