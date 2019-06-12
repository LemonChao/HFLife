//
//  YYB_HF_SearchResultCell.m
//  HFLife
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_SearchResultCell.h"

@implementation YYB_HF_SearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.imageV = [UIImageView new];
    self.titleL = [UILabel new];
    self.priceL = [UILabel new];
    self.addressL = [UILabel new];
    self.cashL = [UILabel new];
    self.cashB = [UIButton new];
    self.distanceL = [UILabel new];
    
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.titleL];
    [self.contentView addSubview:self.priceL];
    [self.contentView addSubview:self.addressL];
    [self.contentView addSubview:self.cashL];
    [self.contentView addSubview:self.cashB];
    [self.contentView addSubview:self.distanceL];
    
    [self.contentView addSubview:self.starBg];
    [self.contentView addSubview:self.starSel];
    
    
    self.imageV.image = image(@"image1");
    self.titleL.text = @"xxxx";
    self.priceL.text = @"xxxx";
    self.addressL.text = @"xxxx";
    self.cashL.text = @"xxxx";
    self.titleL.textColor = HEX_COLOR(0x0C0B0B);
    self.titleL.font = FONT(14);
    self.priceL.textColor = HEX_COLOR(0x0C0B0B);
    self.priceL.font = FONT(12);
    self.addressL.textColor = HEX_COLOR(0xAAAAAA);
    self.addressL.font = FONT(12);
    self.cashL.textColor = HEX_COLOR(0x0C0B0B);
    self.cashL.font = FONT(11);

    self.imageV.clipsToBounds = YES;
    self.imageV.layer.cornerRadius = 5;
    
    self.cashB.clipsToBounds = YES;
    self.cashB.layer.cornerRadius = 4;
    [self.cashB setTitle:@"券" forState:UIControlStateNormal];
    self.cashB.titleColor = [UIColor whiteColor];
    self.cashB.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.cashB setBackgroundColor:HEX_COLOR(0xFFBF24)];
    
    self.distanceL.textColor = HEX_COLOR(0xAAAAAA);
    self.distanceL.font = FONT(12);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(ScreenScale(12));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(ScreenScale(110));
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageV).mas_offset(5);
        make.height.mas_equalTo(ScreenScale(15));
        make.left.mas_equalTo(self.imageV.mas_right).mas_offset(ScreenScale(12));
        make.right.mas_equalTo(self.contentView).mas_offset(ScreenScale(-60));
    }];
    
    [self.starBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleL.mas_bottom).mas_offset(ScreenScale(10));
        make.left.mas_equalTo(self.titleL);
        make.height.mas_equalTo(ScreenScale(13));
        make.width.mas_equalTo(13 * 5);
    }];
    [self.starSel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleL.mas_bottom).mas_offset(ScreenScale(10));
        make.left.mas_equalTo(self.titleL);
        make.height.mas_equalTo(ScreenScale(12));
        make.width.mas_equalTo(13 * 5);
    }];
    
    [self.priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleL.mas_bottom).mas_offset(ScreenScale(10));
        make.left.mas_equalTo(self.starBg.mas_right).mas_offset(10);
        make.height.mas_equalTo(ScreenScale(12));
    }];
    
    [self.distanceL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.priceL);
        make.right.mas_equalTo(self.contentView).mas_equalTo(-12);
        make.height.mas_equalTo(ScreenScale(12));
    }];
    
    [self.addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceL.mas_bottom).mas_offset(ScreenScale(10));
        make.left.mas_equalTo(self.titleL);
        make.height.mas_equalTo(ScreenScale(14));
    }];
    [self.cashB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressL.mas_bottom).mas_offset(ScreenScale(14));
        make.left.mas_equalTo(self.titleL);
        make.height.width.mas_equalTo(ScreenScale(15));
    }];
    [self.cashL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.cashB);
        make.left.mas_equalTo(self.cashB.mas_right).mas_offset(10);
        make.height.mas_equalTo(ScreenScale(12));
    }];
    
}

- (void)setStarNum:(NSInteger)starNum {
    [self.starSel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleL.mas_bottom).mas_offset(ScreenScale(10));
        make.left.mas_equalTo(self.titleL);
        make.height.mas_equalTo(ScreenScale(12));
        make.width.mas_equalTo(13 * (starNum > 5 ? 5 : starNum));
    }];
}

- (UIView *)starBg {
    if (!_starBg) {
        _starBg = [UIView new];
        for (int i = 0; i < 5; i ++) {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i * 13, 0, 13, 13)];
            imageV.image = image(@"icon_star_usel");
            [_starBg addSubview:imageV];
        }
    }
    return _starBg;
}

- (UIView *)starSel {
    if (!_starSel) {
        _starSel = [UIView new];
        _starSel.clipsToBounds = YES;
        for (int i = 0; i < 5; i ++) {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i * 13, 0, 13, 13)];
            imageV.image = image(@"icon_star_sel");
            [_starSel addSubview:imageV];
        }
    }
    return _starSel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
