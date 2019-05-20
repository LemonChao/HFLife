
//
//  SXF_HF_vipCardHeaderV.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_vipCardHeaderV.h"

@interface SXF_HF_vipCardHeaderV ()

@property (nonatomic, strong)UIImageView *bgImageView;
@property (nonatomic, strong)UIImageView *headerImageV;
@property (nonatomic, strong)UILabel *nameLb;
@property (nonatomic, strong)UILabel *subTitleLb;
@property (nonatomic, strong)UILabel *integralLb;
@property (nonatomic, strong)UILabel *integralTitleLb;
@property (nonatomic, strong)UILabel *leveLb;
@property (nonatomic, strong)UILabel *leveTitleLb;
@property (nonatomic, strong)UILabel *phoneLb;
@property (nonatomic, strong)UIView *bottomLineV;
@end


@implementation SXF_HF_vipCardHeaderV


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
    self.bgImageView = [UIImageView new];
    self.headerImageV = [UIImageView new];
    self.nameLb = [UILabel new];
    self.subTitleLb = [UILabel new];
    self.integralLb = [UILabel new];
    self.integralTitleLb = [UILabel new];
    self.leveLb = [UILabel new];
    self.leveTitleLb = [UILabel new];
    self.phoneLb = [UILabel new];
    self.bottomLineV = [UIView new];
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.headerImageV];
    [self addSubview:self.nameLb];
    [self addSubview:self.subTitleLb];
    [self addSubview:self.integralLb];
    [self addSubview:self.integralTitleLb];
    [self addSubview:self.leveLb];
    [self addSubview:self.leveTitleLb];
    [self addSubview:self.phoneLb];
    [self addSubview:self.bottomLineV];
    
    self.headerImageV.layer.cornerRadius = ScreenScale(22);
    self.headerImageV.clipsToBounds = YES;
    
    self.nameLb.textColor = [UIColor whiteColor];
    self.nameLb.font = FONT(18);
    
    self.subTitleLb.textColor = [UIColor whiteColor];
    self.subTitleLb.font = FONT(14);
    
    self.phoneLb.textColor = [UIColor whiteColor];
    self.phoneLb.font = FONT(18);
    
    self.leveTitleLb.font = self.integralTitleLb.font = FONT(11);
    self.leveTitleLb.textColor = self.integralTitleLb.textColor = HEX_COLOR(0x0C0B0B);
    self.leveLb.textAlignment = NSTextAlignmentCenter;
    self.integralLb.textAlignment = NSTextAlignmentCenter;
    self.leveLb.font = self.integralLb.font = FONT(18);
    self.leveLb.textColor = self.integralLb.textColor = HEX_COLOR(0x0C0B0B);
    self.leveTitleLb.text = @"等级";
    self.integralTitleLb.text = @"积分";
    self.bottomLineV.backgroundColor = HEX_COLOR(0xF5F5F5);
    
    self.bgImageView.backgroundColor = HEX_COLOR(0x1E1D1E);
    self.bgImageView.layer.cornerRadius = 5;
    self.bgImageView.clipsToBounds = YES;
    
    self.headerImageV.image = MY_IMAHE(@"logo");
    self.nameLb.text = @"星巴克";
    self.subTitleLb.text = @"星巴克星享会员";
    self.phoneLb.text = @"18203626905";
    self.integralLb.text = @"8888";
    self.leveLb.text = @"白银会员";
    
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(17));
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(12));
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-12));
        make.height.mas_equalTo(ScreenScale(200));
    }];
    
    [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.bgImageView).offset(ScreenScale(20));
        make.width.height.mas_equalTo(ScreenScale(44));
    }];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImageV.mas_top);
        make.left.mas_equalTo(self.headerImageV.mas_right).offset(ScreenScale(10));
        make.height.mas_equalTo(ScreenScale(18));
    }];
    
    [self.subTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.headerImageV.mas_bottom);
        make.left.mas_equalTo(self.headerImageV.mas_right).offset(ScreenScale(10));
        make.height.mas_equalTo(ScreenScale(14));
    }];
    
    [self.integralLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(ScreenScale(18));
        make.top.mas_equalTo(self.bgImageView.mas_bottom).offset(ScreenScale(22));
    }];
    [self.integralTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.integralLb.mas_centerX);
        make.height.mas_equalTo(ScreenScale(11));
        make.top.mas_equalTo(self.integralLb.mas_bottom).offset(ScreenScale(8));
    }];
    [self.leveLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.integralLb.mas_centerY);
        make.left.mas_equalTo(self.integralLb.mas_right);
        make.right.mas_equalTo(self.mas_right);
    }];
    
    [self.leveTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.leveLb.mas_centerX);
        make.centerY.mas_equalTo(self.integralTitleLb.mas_centerY);
    }];
    
    [self.phoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView.mas_left).offset(ScreenScale(20));
        make.bottom.mas_equalTo(self.bgImageView.mas_bottom).offset(ScreenScale(-20));
        make.height.mas_equalTo(ScreenScale(14));
    }];
    
    [self.bottomLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.bgImageView);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(1);
    }];
}

@end
