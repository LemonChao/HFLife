
//
//  SXF_HF_RecommentCollectionCell.m
//  HFLife
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_RecommentCollectionCell.h"

@interface SXF_HF_RecommentCollectionCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *colorsView;

/**
 标题
 */
@property (nonatomic, strong) UILabel *titleLb;

/**
 邀请人数
 */
@property (nonatomic, strong) UILabel *inviteesNumberLb;
@property (nonatomic, strong) UILabel *subTitleLb;

/**
 邀请按钮
 */
@property (nonatomic, strong) UIButton *inviteeButton;

@property (nonatomic, strong) UIImageView *rightIncoderImgV;
@end


@implementation SXF_HF_RecommentCollectionCell

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
    self.backgroundColor = [UIColor whiteColor];
    
    self.colorsView = [UIView new];
    self.bgView = [UIView new];
    self.bgView.backgroundColor = [UIColor clearColor];
    
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.colorsView];
    
    self.titleLb = [UILabel new];
    self.inviteesNumberLb = [UILabel new];
    self.subTitleLb = [UILabel new];
    self.inviteeButton = [UIButton new];
    self.rightIncoderImgV = [UIImageView new];
    self.rightIncoderImgV.tintColor = [UIColor whiteColor];
    self.rightIncoderImgV.image = [UIImage imageNamed:@"homePage更多"];
    
    [self.bgView addSubview:self.titleLb];
    [self.bgView addSubview:self.inviteesNumberLb];
    [self.bgView addSubview:self.subTitleLb];
    [self.bgView addSubview:self.inviteeButton];
    [self.bgView addSubview:self.rightIncoderImgV];
    
    
    
    self.titleLb.font = FONT(ScreenScale(13));
    self.titleLb.textColor = [UIColor whiteColor];
    
    self.inviteesNumberLb.textColor = [UIColor whiteColor];
    self.inviteesNumberLb.font = FONT(ScreenScale(18));
    
    self.subTitleLb.textColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    self.subTitleLb.font = FONT(ScreenScale(11));
    [self.inviteeButton setTitle:@"继续邀请" forState:UIControlStateNormal];
    self.inviteeButton.titleLabel.font = FONT(ScreenScale(14));
    [self.inviteeButton setTitleColor:HEX_COLOR(0x3E874F) forState:UIControlStateNormal];
    [self.inviteeButton addTarget:self action:@selector(inviteeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.inviteeButton.backgroundColor = [UIColor whiteColor];
    self.titleLb.text = @"汉富新生活 | 邀请有礼";
    self.inviteesNumberLb.text = @"已邀请88位好友";
    self.subTitleLb.text = @"收益奖励可兑富权";
    
}
- (void) inviteeButtonClick{
    NSLog(@"点击邀请");
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenScale(4));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(4));
        make.bottom.right.mas_equalTo(self.contentView).offset(ScreenScale(-4));
    }];
    
    [self.colorsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.bgView);
    }];
    
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(ScreenScale(26));
        make.left.mas_equalTo(self.bgView.mas_left).offset(ScreenScale(23));
        make.height.mas_equalTo(ScreenScale(13));
    }];
    
    [self.inviteesNumberLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLb.mas_leading);
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(ScreenScale(17));
        make.height.mas_equalTo(ScreenScale(17));
    }];
    
    [self.subTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLb.mas_leading);
        make.top.mas_equalTo(self.inviteesNumberLb.mas_bottom).offset(ScreenScale(13));
        make.height.mas_equalTo(ScreenScale(11));
    }];
    
    [self.inviteeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleLb.mas_leading);
        make.top.mas_equalTo(self.subTitleLb.mas_bottom).offset(ScreenScale(22));
        make.height.mas_equalTo(ScreenScale(27));
        make.width.mas_equalTo(ScreenScale(115));
    }];
    
    [self.rightIncoderImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).offset(-ScreenScale(13));
        make.height.mas_equalTo(ScreenScale(12));
        make.width.mas_equalTo(ScreenScale(7));
        make.centerY.mas_equalTo(self.titleLb.mas_centerY);
    }];
    
    [self layoutIfNeeded];
    self.inviteeButton.layer.cornerRadius = self.inviteeButton.bounds.size.height * 0.5;
    self.inviteeButton.layer.masksToBounds = YES;
    
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.clipsToBounds = YES;
    
    [self.colorsView changeBgView:@[HEX_COLOR(0x54B56B), HEX_COLOR(0xA7FABA)] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1)];
    
    self.colorsView.layer.cornerRadius = 8;
    self.colorsView.layer.masksToBounds = YES;
}






@end
