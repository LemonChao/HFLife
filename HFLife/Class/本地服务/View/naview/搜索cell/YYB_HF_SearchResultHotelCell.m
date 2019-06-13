//
//  YYB_HF_SearchResultHotelCell.m
//  HFLife
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_SearchResultHotelCell.h"

@implementation YYB_HF_SearchResultHotelCell

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
    self.scoreL = [UILabel new];
    self.addressL = [UILabel new];
    self.pingjiaL = [UILabel new];
    self.addressIconV = [UIImageView new];
    self.consume_minL = [UILabel new];
    self.minL = [UILabel new];
    
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.titleL];
    [self.contentView addSubview:self.scoreL];
    [self.contentView addSubview:self.addressL];
    [self.contentView addSubview:self.pingjiaL];
    [self.contentView addSubview:self.addressIconV];
    [self.contentView addSubview:self.consume_minL];
    [self.contentView addSubview:self.minL];
    
    [self.contentView addSubview:self.starBg];
    [self.contentView addSubview:self.starSel];
    
    self.titleL.text = @"xxxx";
    self.scoreL.text = @"xxxx";
    self.addressL.text = @"xxxx";
    self.pingjiaL.text = @"xxxx";
    self.titleL.textColor = HEX_COLOR(0x0C0B0B);
    self.titleL.font = FONT(14);
    self.scoreL.textColor = HEX_COLOR(0x0C0B0B);
    self.scoreL.font = FONT(12);
    self.addressL.textColor = HEX_COLOR(0xAAAAAA);
    self.addressL.font = FONT(12);
    self.pingjiaL.textColor = HEX_COLOR(0xAAAAAA);
    self.pingjiaL.font = FONT(11);
    
    self.imageV.clipsToBounds = YES;
    self.imageV.layer.cornerRadius = 5;
    
    self.addressIconV.image = image(@"icon_address");
    
    self.consume_minL.text = @"xxx";
    self.consume_minL.font = FONT(18);
    self.consume_minL.textColor = HEX_COLOR(0xEE0000);
    
    self.minL.font = FONT(11);
    self.minL.textColor = HEX_COLOR(0xAAAAAA);
    self.minL.text = @"起";
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
    
    [self.scoreL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleL.mas_bottom).mas_offset(ScreenScale(10));
        make.left.mas_equalTo(self.starBg.mas_right).mas_offset(10);
        make.height.mas_equalTo(ScreenScale(12));
    }];
    
    [self.addressIconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scoreL.mas_bottom).mas_offset(ScreenScale(10));
        make.left.mas_equalTo(self.titleL);
        make.height.mas_equalTo(ScreenScale(12));
        make.width.mas_equalTo(ScreenScale(10));
    }];
    
    [self.addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.addressIconV).mas_offset(ScreenScale(0));
        make.left.mas_equalTo(self.addressIconV.mas_right).mas_offset(ScreenScale(5));
        make.height.mas_equalTo(ScreenScale(14));
        make.right.mas_equalTo(self.contentView).mas_offset(ScreenScale(-60));
    }];
    [self.pingjiaL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressL.mas_bottom).mas_offset(ScreenScale(14));
        make.left.mas_equalTo(self.titleL);
        make.height.mas_equalTo(ScreenScale(12));
    }];
    
    [self.consume_minL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.imageV);
        make.right.mas_equalTo(self.contentView).mas_offset(-30);
        make.height.mas_equalTo(ScreenScale(18));
    }];
    
    [self.minL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.consume_minL.mas_right);
        make.height.mas_equalTo(ScreenScale(12));
        make.bottom.mas_equalTo(self.consume_minL);
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
