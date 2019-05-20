
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
    
    [self addSubview:self.headerBgView];
    [self.headerBgView addSubview:self.bgImageV];
    [self.headerBgView addSubview:self.headerImageV];
    [self.headerBgView addSubview:self.userNameLb];
    [self.headerBgView addSubview:self.userLeveLb];
    [self.headerBgView addSubview:self.bottomBarView];
    [self.bottomBarView addSubview:self.myJoinTitleLb];
    [self.bottomBarView addSubview:self.getTextBtn];
    
    
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
    
    
    self.headerImageV.image = MY_IMAHE(@"head_icon");
    self.userNameLb.text = @"sxf";
    self.userLeveLb.text = @"LV：VIP1";
    self.myJoinTitleLb.text = @"我的邀请码：X34FV";
    
}
- (void)clickHeaderImageV{
   
    [[self getCurrentViewController].navigationController pushViewController:[[NSClassFromString(@"PersonalDataVC") alloc]init] animated:YES];
}
- (void)copyText{
    [UIPasteboard generalPasteboard].string = self.myJoinTitleLb.text;
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
    
}
@end
