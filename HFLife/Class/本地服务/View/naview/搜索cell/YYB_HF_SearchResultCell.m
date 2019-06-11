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
    
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.titleL];
    [self.contentView addSubview:self.priceL];
    [self.contentView addSubview:self.addressL];
    [self.contentView addSubview:self.cashL];
    
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
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(ScreenScale(12));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(ScreenScale(110));
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageV);
        make.height.mas_equalTo(ScreenScale(15));
        make.left.mas_equalTo(self.imageV.mas_right).mas_offset(ScreenScale(12));
        make.right.mas_equalTo(self.contentView).mas_offset(ScreenScale(-60));
    }];
    
    [self.priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleL.mas_bottom).mas_offset(ScreenScale(10));
        make.left.mas_equalTo(self.titleL);
        make.height.mas_equalTo(ScreenScale(12));
    }];
    
    [self.addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceL.mas_bottom).mas_offset(ScreenScale(10));
        make.left.mas_equalTo(self.titleL);
        make.height.mas_equalTo(ScreenScale(14));
    }];
    [self.cashL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressL.mas_bottom).mas_offset(ScreenScale(14));
        make.left.mas_equalTo(self.titleL);
        make.height.mas_equalTo(ScreenScale(12));
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
