
//
//  SXF_HF_MainTableHeaderView.m
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_MainTableHeaderView.h"

@interface SXF_HF_MainTableHeaderView()

@property (nonatomic, strong)UIView *headerBgView;
@property (nonatomic, strong)UIImageView *bgImageV;
@property (nonatomic, strong)UIImageView *headerImageV;
@property (nonatomic, strong)UILabel *userNameLb;
@property (nonatomic, strong)UILabel *userLeveLb;
@property (nonatomic, strong)UIView *bottomBarView;

/**
 我的邀请
 */
@property (nonatomic, strong)UILabel *myJoinTitleLb;

/**
 赋值到剪切板
 */
@property (nonatomic, strong)UIButton *getTextBtn;

@property (nonatomic, strong)UIView *vipBgView;
@property (nonatomic, strong)UIView *vipBgColorView;
@property (nonatomic, strong)UILabel *moneyLb1;
@property (nonatomic, strong)UILabel *moneyLb2;
@property (nonatomic, strong)UILabel *moneyTitle1;
@property (nonatomic, strong)UILabel *moneyTitle2;
@property (nonatomic, strong)UIView *bottomColorView;
@property (nonatomic, strong)UIImageView *leftImageV;
@property (nonatomic, strong)UILabel *bottomLb;
@end


@implementation SXF_HF_MainTableHeaderView

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
    self.headerBgView           = [UIView new];
    self.userNameLb             = [UILabel new];
    self.userLeveLb             = [UILabel new];
    self.headerImageV           = [UIImageView new];
    self.bgImageV               = [UIImageView new];
    self.bottomBarView          = [UIView new];
    self.myJoinTitleLb          = [UILabel new];
    self.getTextBtn             = [UIButton new];
    
    //vip模块
    self.vipBgView              = [UIView new];
    self.vipBgColorView         = [UIView new];
    self.moneyLb1               = [UILabel new];
    self.moneyLb2               = [UILabel new];
    self.moneyTitle1            = [UILabel new];
    self.moneyTitle2            = [UILabel new];
    self.bottomColorView        = [UIView new];
    self.leftImageV             = [UIImageView new];
    self.bottomLb               = [UILabel new];
    
    
    [self addSubview:self.headerBgView];
    
    [self.headerBgView addSubview:self.bgImageV];
    [self.headerBgView addSubview:self.headerImageV];
    [self.headerBgView addSubview:self.userNameLb];
    [self.headerBgView addSubview:self.userLeveLb];
    [self.headerBgView addSubview:self.bottomBarView];
    [self.bottomBarView addSubview:self.myJoinTitleLb];
    [self.bottomBarView addSubview:self.getTextBtn];
    [self.headerBgView addSubview:self.vipBgView];
    
    [self.vipBgView addSubview:self.vipBgColorView];
    [self.vipBgView addSubview:self.moneyLb1];
    [self.vipBgView addSubview:self.moneyLb2];
    [self.vipBgView addSubview:self.moneyTitle1];
    [self.vipBgView addSubview:self.moneyTitle2];
    [self.vipBgView addSubview:self.bottomColorView];
    [self.vipBgView addSubview:self.leftImageV];
    [self.vipBgView addSubview:self.bottomLb];
    
    
    self.bgImageV.image = MY_IMAHE(@"我的headerBg");
    
    self.headerImageV.layer.cornerRadius = ScreenScale(35);
    self.headerImageV.layer.borderWidth = 1;
    self.headerImageV.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headerImageV.clipsToBounds = YES;
    
    self.userNameLb.font = FONT(18);
    self.userNameLb.textColor = [UIColor whiteColor];

    self.userLeveLb.font = FONT(14);
    self.userLeveLb.textColor = [UIColor whiteColor];
    
    self.bottomBarView.layer.cornerRadius = ScreenScale(5);
    self.bottomBarView.layer.masksToBounds = YES;
    self.bottomBarView.backgroundColor = [UIColor whiteColor];
    
    self.myJoinTitleLb.font = FONT(14);
    self.myJoinTitleLb.textColor = [UIColor blackColor];
    
    self.getTextBtn
    .setTitle(@"复制邀请码", UIControlStateNormal)
    .setTitleFont(FONT(14))
    .setTitleColor(HEX_COLOR(0xCA1400), UIControlStateNormal);
    [self.getTextBtn addTarget:self action:@selector(copyText)];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeaderImageV)];
    self.headerImageV.userInteractionEnabled = YES;
    [self.headerImageV addGestureRecognizer:tap];
    
    
    //vip模块
    self.moneyLb1.font = self.moneyLb2.font = FONT(14);
    self.moneyLb1.textColor = self.moneyLb2.textColor = colorCA1400;
    self.moneyTitle1.font = self.moneyTitle2.font = FONT(10);
    self.moneyTitle1.textColor = self.moneyTitle2.textColor = [UIColor whiteColor];
    self.bottomLb.textColor = [UIColor whiteColor];
    self.bottomLb.font = FONT(10);
    self.leftImageV.image = MY_IMAHE(@"皇冠");
    self.vipBgView.cornerRadius = ScreenScale(5);
    self.vipBgView.masksToBounds = YES;
    self.moneyLb1.textAlignment = self.moneyLb2.textAlignment = NSTextAlignmentCenter;
    self.bottomColorView.layer.cornerRadius = ScreenScale(5);
    self.bottomColorView.layer.masksToBounds = YES;
    
    
    
    
    
    [self.headerImageV sd_setImageWithURL:[NSURL URLWithString:[userInfoModel sharedUser].member_avatar] placeholderImage:MY_IMAHE(@"logo")];
    NSString *nameStr = [userInfoModel sharedUser].nickname;
    self.userNameLb.text = nameStr ? nameStr : @"";
    self.userLeveLb.text = @"LV：";
    self.myJoinTitleLb.text = @"我的邀请码:6666";
    
    self.moneyLb1.text = @"";
    self.moneyLb2.text = @"";
    self.moneyTitle1.text = @"昨日营业额(元)";
    self.moneyTitle2.text = @"昨日商家让利(元)";
    self.bottomLb.text = @"";
    
}

#pragma mark - 设置信息
- (void)setMemberInfoModel:(userInfoModel *)memberInfoModel {
    [self.headerImageV sd_setImageWithURL:[NSURL URLWithString:memberInfoModel.member_avatar] placeholderImage:MY_IMAHE(@"logo")];
    NSString *nameStr = memberInfoModel.nickname;
    self.userNameLb.text = nameStr ? nameStr : @"昵称名称";
    self.userLeveLb.text = memberInfoModel.level_name ? StringFormat(@"LV:%@",memberInfoModel.level_name) : @"无等级信息";
    self.myJoinTitleLb.text = memberInfoModel.invite_code ? [NSString stringWithFormat:@"我的邀请码:%@",memberInfoModel.invite_code] : @"";
    if (memberInfoModel.i_agent_level.intValue > 0) {
        self.moneyLb1.text = Format(memberInfoModel.yesterday_turnover) ? Format(memberInfoModel.yesterday_turnover) : @"0";
        self.moneyLb2.text = Format(memberInfoModel.yesterday_benefit) ? Format(memberInfoModel.yesterday_benefit) : @"0";
        self.moneyTitle1.text = @"昨日营业额(元)";
        self.moneyTitle2.text = @"昨日商家让利(元)";
        self.bottomLb.text = memberInfoModel.i_agent_name ? memberInfoModel.i_agent_name : @"代理区域";
    }else {
        self.vipBgView.hidden = YES;
    }
}

- (void)clickHeaderImageV{
   
    [[self getCurrentViewController].navigationController pushViewController:[[NSClassFromString(@"PersonalDataVC") alloc]init] animated:YES];
}
- (void)copyText{
    if ([self.myJoinTitleLb.text componentsSeparatedByString:@":"].lastObject) {
        [UIPasteboard generalPasteboard].string = [self.myJoinTitleLb.text componentsSeparatedByString:@":"].lastObject;
        [WXZTipView showCenterWithText:@"邀请码已复制"];
    }else {
        [WXZTipView showCenterWithText:@"邀请码不存在"];
    }
    
    NSLog(@"剪切板数据 : %@", [UIPasteboard generalPasteboard].string);
}




















- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.headerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
    
    [self.bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.headerBgView);
        make.height.mas_equalTo(ScreenScale(170));
        
    }];
    [self.bottomBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgImageV.mas_bottom).offset(ScreenScale(-17));
        make.left.mas_equalTo(self.headerBgView.mas_left).offset(ScreenScale(12));
        make.right.mas_equalTo(self.headerBgView.mas_right).offset(ScreenScale(-12));
        make.bottom.mas_equalTo(self.headerBgView.mas_bottom).offset(ScreenScale(-7));
        
    }];
    
    [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerBgView.mas_top).offset(ScreenScale(42));
        make.left.mas_equalTo(self.headerBgView.mas_left).offset(ScreenScale(12));
        make.width.height.mas_equalTo(ScreenScale(70));
    }];
    
    [self.userNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImageV.mas_top).offset(ScreenScale(14));
        make.left.mas_equalTo(self.headerImageV.mas_right).offset(ScreenScale(12));
        make.height.mas_equalTo(ScreenScale(17));
        if (self.vipBgView.hidden == NO) {
            make.right.lessThanOrEqualTo(self.vipBgView.mas_left);
        }
    }];
    
    [self.userLeveLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameLb.mas_left);
        make.bottom.mas_equalTo(self.headerImageV.mas_bottom).offset(ScreenScale(-16));
        make.height.mas_equalTo(ScreenScale(14));
    }];
    
    [self.myJoinTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomBarView.mas_left).offset(ScreenScale(12));
        make.top.bottom.mas_equalTo(self.bottomBarView);
    }];
    
    [self.getTextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bottomBarView.mas_right).offset(ScreenScale(-12));
        make.centerY.mas_equalTo(self.myJoinTitleLb.mas_centerY);
        make.top.bottom.mas_equalTo(self.bottomBarView);
    }];
    
    
    [self.vipBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.headerBgView.mas_right).offset(ScreenScale(-12));
        make.bottom.mas_equalTo(self.bottomBarView.mas_top).offset(ScreenScale(-27));
        make.width.mas_equalTo(ScreenScale(170));
        make.height.mas_equalTo(ScreenScale(99));
    }];
    
    [self.vipBgColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.vipBgView);
    }];
    
    [self.moneyLb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.vipBgView.mas_left);
        make.top.mas_equalTo(self.vipBgView.mas_top).offset(ScreenScale(16));
        make.height.mas_equalTo(ScreenScale(14));
        make.width.mas_equalTo(self.vipBgView.mas_width).multipliedBy(0.5);
    }];
    [self.moneyLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.vipBgView.mas_right);
        make.centerY.mas_equalTo(self.moneyLb1.mas_centerY);
        make.width.mas_equalTo(self.moneyLb1.mas_width);
    }];
    
    [self.moneyTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.moneyLb1.mas_bottom).offset(ScreenScale(8));
        make.height.mas_equalTo(ScreenScale(10));
        make.centerX.mas_equalTo(self.moneyLb1.mas_centerX);
    }];
    
    [self.moneyTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.moneyLb2.mas_centerX);
        make.centerY.mas_equalTo(self.moneyTitle1.mas_centerY);
    }];
    
    [self.bottomColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.vipBgView.mas_right).offset(ScreenScale(-10));
        make.left.mas_equalTo(self.vipBgView.mas_left).offset(ScreenScale(10));
        make.top.mas_equalTo(self.moneyTitle1.mas_bottom).offset(ScreenScale(19));
        make.height.mas_equalTo(ScreenScale(16));
    }];
    
    [self.leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.vipBgView.mas_left);
        make.bottom.mas_equalTo(self.bottomColorView.mas_bottom);
        make.width.mas_equalTo(ScreenScale(30));
        make.height.mas_equalTo(ScreenScale(24));
    }];
    [self.bottomLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bottomColorView.mas_centerX);
        make.centerY.mas_equalTo(self.bottomColorView.mas_centerY);
    }];
    
    [self layoutIfNeeded];
    [self.vipBgColorView changeBgView:@[HEX_COLOR(0xFEC436), HEX_COLOR(0xD12D08)] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1.0, 1.0)];
    [self.bottomColorView changeBgView:@[HEX_COLOR(0xF8B331), HEX_COLOR(0xD12D08)] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1.0, 0.0)];
    
}
@end
