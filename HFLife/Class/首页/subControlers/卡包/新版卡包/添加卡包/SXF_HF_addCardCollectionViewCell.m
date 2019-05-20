//
//  SXF_HF_CollectionViewCell.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_addCardCollectionViewCell.h"

@interface SXF_HF_addCardCollectionViewCell ()

@property (nonatomic, strong)UIImageView *cardImageV;
@property (nonatomic, strong)UILabel *titleLb;
@property (nonatomic, strong)UILabel *subLabel;

@end

@implementation SXF_HF_addCardCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addChiledrenViews];
    }
    return self;
}

- (void)addChiledrenViews{
    self.cardImageV    = [UIImageView new];
    self.titleLb       = [UILabel new];
    self.subLabel      = [UILabel new];
    
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.subLabel];
    [self.contentView addSubview:self.cardImageV];
    
    self.cardImageV.contentMode = UIViewContentModeScaleAspectFit;
    self.cardImageV.layer.cornerRadius = 5.0;
    self.cardImageV.clipsToBounds = YES;
    self.cardImageV.backgroundColor = HEX_COLOR(0xAAAAAA);
    self.titleLb.textColor = HEX_COLOR(0x0C0B0B);
    self.titleLb.font = [UIFont  fontWithName:@"PingFang-SC-Regular" size:14];
    
    self.subLabel.textColor = HEX_COLOR(0xAAAAAA);
    self.subLabel.font = [UIFont  fontWithName:@"PingFang-SC-Regular" size:12];
    
    self.titleLb.text = @"舒服人生优享生活";
    self.subLabel.text = @"优衣库会员";
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.cardImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(ScreenScale(75));
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.cardImageV.mas_bottom).offset(ScreenScale(8));
        make.height.mas_equalTo(ScreenScale(14));
    }];
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(ScreenScale(8));
        make.height.mas_equalTo(ScreenScale(12));
    }];
}




@end
