
//
//  SXF_HF_payStepTowCel.m
//  HFLife
//
//  Created by mac on 2019/5/15.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_payStepTowCel.h"

@interface SXF_HF_payStepTowCel ()

@property (nonatomic, strong)UIImageView *selectedImgeV;

@end


@implementation SXF_HF_payStepTowCel

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addChildrenViews];
    }
    return self;
}

- (void)addChildrenViews{
    self.headerImageV = [UIImageView new];
    self.typeNameLb   = [UILabel new];
    self.subLb        = [UILabel new];
    self.selectedImgeV= [UIImageView new];
    
    [self.contentView addSubview:self.headerImageV];
    [self.contentView addSubview:self.typeNameLb];
    [self.contentView addSubview:self.subLb];
    [self.contentView addSubview:self.selectedImgeV];
    
    
    self.headerImageV.contentMode = UIViewContentModeScaleAspectFit;
    self.typeNameLb.textColor = HEX_COLOR(0x0C0B0B);
    self.typeNameLb.font = FONT(14);
    self.subLb.font = FONT(14);
    self.subLb.textColor = HEX_COLOR(0x0C0B0B);
    self.selectedImgeV.image = MY_IMAHE(@"选择图标");
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    
    [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenScale(12));
        make.width.height.mas_equalTo(ScreenScale(22));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    
    [self.typeNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageV.mas_right).offset(ScreenScale(13));
        make.centerY.mas_equalTo(self.headerImageV.mas_centerY);
        make.height.mas_equalTo(ScreenScale(14));
    }];
    
    [self.subLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.typeNameLb.mas_left);
        make.top.mas_equalTo(self.typeNameLb.mas_bottom).offset(8);
        make.height.mas_equalTo(ScreenScale(14));
    }];
    
    [self.selectedImgeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(ScreenScale(-12));
        make.width.height.mas_equalTo(ScreenScale(15));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    
    
}



@end
