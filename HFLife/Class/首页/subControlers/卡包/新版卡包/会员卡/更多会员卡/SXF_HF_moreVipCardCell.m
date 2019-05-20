
//
//  SXF_HF_moreVipCardCell.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_moreVipCardCell.h"

@interface SXF_HF_moreVipCardCell ()

@property (nonatomic, strong)UIImageView *cardImageV;
@property (nonatomic, strong)UILabel *titleLb;
@property (nonatomic, strong)UILabel *subTitleLb;
@property (nonatomic, strong)UIButton *jionInVipBtn;

@end

@implementation SXF_HF_moreVipCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addChildrenViews];
    }
    return self;
}
- (void)addChildrenViews{
    self.cardImageV = [UIImageView new];
    self.titleLb = [UILabel new];
    self.subTitleLb = [UILabel new];
    self.jionInVipBtn = [UIButton new];
    
    [self.contentView addSubview:self.cardImageV];
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.subTitleLb];
    [self.contentView addSubview:self.jionInVipBtn];
    
    self.cardImageV.layer.cornerRadius = 5;
    self.cardImageV.clipsToBounds = YES;
    
    self.titleLb.font = FONT(14);
    self.titleLb.textColor = colorCA1400;
    self.subTitleLb.font = FONT(12);
    self.subTitleLb.textColor = colorAAAAAA;
    self.jionInVipBtn.setTitle(@"加入会员", UIControlStateNormal).setTitleFontSize(14).setTitleColor(colorCA1400, UIControlStateNormal).layer.borderWidth = 1;
    self.jionInVipBtn.layer.borderColor = colorCA1400.CGColor;
    self.jionInVipBtn.layer.masksToBounds = YES;
    self.jionInVipBtn.layer.cornerRadius = 5;
    [self.jionInVipBtn addTarget:self action:@selector(joinInBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.cardImageV.backgroundColor = colorAAAAAA;
    
}
- (void)joinInBtnClick{
    
}
- (void)setDataForCell:(id)data{
    self.titleLb.text = @"舒服人生优享生活";
    self.subTitleLb.text = @"优衣库会员卡";
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.cardImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12);
        make.top.mas_equalTo(self.contentView.mas_top).offset(17);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.mas_equalTo(ScreenScale(105));
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cardImageV.mas_right).offset(ScreenScale(10));
        make.height.mas_equalTo(ScreenScale(14));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(27));
    }];
    [self.subTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLb.mas_left);
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(ScreenScale(8));
        make.height.mas_equalTo(ScreenScale(12));
    }];
    
    [self.jionInVipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(ScreenScale(74));
        make.height.mas_equalTo(ScreenScale(32));
    }];
}

@end
