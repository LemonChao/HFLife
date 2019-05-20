
//
//  SXF_HF_vipCardCellTableViewCell.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_vipCardCellTableViewCell.h"

@interface SXF_HF_vipCardCellTableViewCell ()

@property (nonatomic, strong)UIImageView *rightIncoderV;

@end

@implementation SXF_HF_vipCardCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addChildrenViews];
    }
    return self;
}
- (void)addChildrenViews{
    self.titleLb = [UILabel new];
    self.rightIncoderV = [UIImageView new];
    self.subTitleLb = [UILabel new];
    
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.rightIncoderV];
    [self.contentView addSubview:self.subTitleLb];
    self.titleLb.font = FONT(14);
    self.titleLb.textColor = HEX_COLOR(0x1E1D1E);
    self.rightIncoderV.image = MY_IMAHE(@"资源 36");
    self.subTitleLb.font = FONT(12);
    self.subTitleLb.textColor = HEX_COLOR(0xCA1400);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenScale(12));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.rightIncoderV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(ScreenScale(-12));
        make.centerY.mas_equalTo(self.titleLb.mas_centerY);
        make.width.mas_equalTo(ScreenScale(7));
        make.height.mas_equalTo(ScreenScale(11));
    }];
    [self.subTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightIncoderV.mas_left).offset(ScreenScale(-5));
        make.centerY.mas_equalTo(self.rightIncoderV.mas_centerY);
    }];
}
@end
