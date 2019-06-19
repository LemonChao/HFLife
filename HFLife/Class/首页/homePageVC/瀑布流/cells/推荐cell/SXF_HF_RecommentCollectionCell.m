
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


@property (nonatomic, strong)UIImageView *bgImageV;
//cell类型

@property (nonatomic, strong)UIButton *goBuyBtn;//购买按钮
@property (nonatomic, strong)UIImageView *leftImageV;

@property (nonatomic, strong)homeActivityModel *model;
@end


@implementation SXF_HF_RecommentCollectionCell
{
    NSString *goUrlStr;//点击的url
}
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
    
    
    self.titleLb = [UILabel new];
    self.inviteesNumberLb = [UILabel new];
    self.subTitleLb = [UILabel new];
    self.inviteeButton = [UIButton new];
    self.rightIncoderImgV = [UIImageView new];
    self.rightIncoderImgV.tintColor = [UIColor whiteColor];
    self.rightIncoderImgV.image = [UIImage imageNamed:@"right_white"];
    self.goBuyBtn = [UIButton new];
    self.bgImageV = [UIImageView new];
    self.leftImageV = [UIImageView new];
    [self.bgView addSubview:self.bgImageV];
    [self.bgView addSubview:self.colorsView];
    [self.bgView addSubview:self.leftImageV];
    [self.bgView addSubview:self.titleLb];
    [self.bgView addSubview:self.inviteesNumberLb];
    [self.bgView addSubview:self.subTitleLb];
    [self.bgView addSubview:self.inviteeButton];
    [self.bgView addSubview:self.rightIncoderImgV];
    [self.bgView addSubview:self.goBuyBtn];
    
    
    
    self.titleLb.font = FONT(ScreenScale(13));
    self.titleLb.textColor = [UIColor whiteColor];
    
    self.inviteesNumberLb.textColor = [UIColor whiteColor];
    self.inviteesNumberLb.font = FONT(ScreenScale(18));
    
    self.subTitleLb.textColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    self.subTitleLb.font = FONT(ScreenScale(11));
    [self.inviteeButton setTitle:@"继续邀请" forState:UIControlStateNormal];
    self.inviteeButton.titleLabel.font = FONT(ScreenScale(14));
    [self.inviteeButton setTitleColor:HEX_COLOR(0x3E874F) forState:UIControlStateNormal];
    [self.inviteeButton addTarget:self action:@selector(inviteeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.goBuyBtn.setTitle(@"购买", UIControlStateNormal).setTitleFontSize(14).setTitleColor([UIColor whiteColor], UIControlStateNormal);
    [self.goBuyBtn addTarget:self action:@selector(inviteeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.inviteeButton.backgroundColor = [UIColor clearColor];
    
    self.goBuyBtn.tag = 50;
    self.inviteeButton.tag = 51;
    
    self.titleLb.text = @"";
    self.inviteesNumberLb.text = @"";
    self.subTitleLb.text = @"";
    
    
}

- (void)setDataForCell:(homeActivityModel *)model{
    self.model = model;
//    self.titleLb.text = [NSString stringWithFormat:@"%@ | 邀请有礼"];
    if ([model.type integerValue] == 1) {
        self.cellType = itemType_first;
        
        [self.inviteeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.titleLb.mas_leading);
            make.top.mas_equalTo(self.subTitleLb.mas_bottom).offset(ScreenScale(22));
            make.height.mas_equalTo(ScreenScale(27));
            make.width.mas_equalTo(ScreenScale(115));
        }];
        //
        [self.inviteeButton setTitle:model.btn_msg forState:UIControlStateNormal];
        [self.inviteeButton sd_setBackgroundImageWithURL:MY_URL_IMG(model.btn_image) forState:UIControlStateNormal];
        
        
        
    }else{
        self.cellType = itemType_two;
        
        [self.goBuyBtn sd_setBackgroundImageWithURL:MY_URL_IMG(model.left_image) forState:UIControlStateNormal];
        [self.inviteeButton sd_setBackgroundImageWithURL:MY_URL_IMG(model.right_image) forState:UIControlStateNormal];
        
        [self.goBuyBtn setTitle:model.left_msg forState:UIControlStateNormal];
        [self.inviteeButton setTitle:model.right_msg forState:UIControlStateNormal];
        
        
        
        [self.goBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.titleLb.mas_leading);
            make.top.mas_equalTo(self.subTitleLb.mas_bottom).offset(ScreenScale(22));
            make.height.mas_equalTo(ScreenScale(27));
            make.width.mas_equalTo(ScreenScale(65));
        }];
        [self.inviteeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goBuyBtn.mas_right);
            make.top.mas_equalTo(self.subTitleLb.mas_bottom).offset(ScreenScale(22));
            make.height.mas_equalTo(ScreenScale(27));
            make.width.mas_equalTo(self.goBuyBtn.mas_width);
        }];
        
        
    }
    
    [self.bgImageV sd_setImageWithURL:MY_URL_IMG(model.body_image)];
    self.titleLb.text = model.title_msg;
    self.inviteesNumberLb.text = model.body_msg;
    self.subTitleLb.text = model.foot_msg;
    self.titleLb.textColor = self.inviteesNumberLb.textColor = self.subTitleLb.textColor = [UIColor colorWithHexString:model.body_color];
    [self.inviteeButton setTitleColor:[UIColor colorWithHexString:model.btn_color] forState:UIControlStateNormal];
   
//    [self.colorsView changeBgView:@[HEX_COLOR(0x54B56B), HEX_COLOR(0xA7FABA)] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1)];
}



- (void) inviteeButtonClick:(UIButton *)sender{
    NSLog(@"点击邀请");
    if ([self.model.type integerValue] == 1) {
        goUrlStr = self.model.btn_url;
    }else{
        if (sender.tag == 50) {
            //购买
            goUrlStr = self.model.left_url;
        }else{
            //邀请
            goUrlStr = self.model.right_url;
        }
    }
    
    !self.clickItemBtn ? : self.clickItemBtn(goUrlStr);
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenScale(4));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(4));
        make.bottom.right.mas_equalTo(self.contentView).offset(ScreenScale(-4));
    }];
    
    [self.bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.left.bottom.top.mas_equalTo(self.bgView);
    }];
    
    [self.colorsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.bgView);
    }];
    [self.leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).offset(-ScreenScale(7));
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(ScreenScale(-20));
        make.width.mas_equalTo(ScreenScale(119));
        make.height.mas_equalTo(ScreenScale(115));
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
    
    
    [self.rightIncoderImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).offset(-ScreenScale(13));
        make.height.mas_equalTo(ScreenScale(15));
        make.width.mas_equalTo(ScreenScale(15));
        make.centerY.mas_equalTo(self.titleLb.mas_centerY);
    }];
    
    
    
    
    [self layoutIfNeeded];
//    self.inviteeButton.layer.cornerRadius = self.inviteeButton.bounds.size.height * 0.5;
//    self.inviteeButton.layer.masksToBounds = YES;
    
    self.bgView.layer.cornerRadius = 8;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.clipsToBounds = YES;
    
    
    
    self.colorsView.layer.cornerRadius = 8;
    self.colorsView.layer.masksToBounds = YES;
}






@end
