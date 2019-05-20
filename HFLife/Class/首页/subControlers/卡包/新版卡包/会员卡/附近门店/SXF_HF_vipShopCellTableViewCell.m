//
//  SXF_HF_vipShopCellTableViewCell.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_vipShopCellTableViewCell.h"

@interface SXF_HF_vipShopCellTableViewCell()

@property (nonatomic, strong)UILabel *titleLb;
@property (nonatomic, strong)UILabel *subtitleLb;
@property (nonatomic, strong)UILabel *destenceLb;
@property (nonatomic, strong)UIImageView *locationImgV;
@end



@implementation SXF_HF_vipShopCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addChildrenViews];
    }
    return self;
}
- (void)addChildrenViews{
    self.titleLb    = [UILabel new];
    self.subtitleLb = [UILabel new];
    self.destenceLb = [UILabel new];
    self.locationImgV = [UIImageView new];
    
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.subtitleLb];
    [self.contentView addSubview:self.destenceLb];
    [self.contentView addSubview:self.locationImgV];
    
    self.locationImgV.image = MY_IMAHE(@"位置");
    
    self.titleLb.font = FONT(18);
    self.titleLb.textColor = color0C0B0B;
    self.subtitleLb.font = self.destenceLb.font = FONT(14);
    self.subtitleLb.textColor = self.destenceLb.textColor = colorAAAAAA;
    
    self.subtitleLb.numberOfLines = 2;
    
    [self setDataForCell:@""];
}

- (void)setDataForCell:(id)data{
    self.titleLb.text = @"郑州丹尼斯";
    self.subtitleLb.text = @"郑州市北二七路丹尼斯大卫城一层星巴克郑州市北二七路丹尼斯大卫城一层星巴克郑州市北二七路丹尼斯大卫城一层星巴克";
    self.destenceLb.text = @"2.15公里";
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenScale(12));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(24));
        make.height.mas_equalTo(ScreenScale(18));
    }];
    
    [self.subtitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(ScreenScale(12));
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenScale(12));
        make.right.mas_equalTo(self.contentView.mas_right).offset(ScreenScale(-12));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(ScreenScale(-24));
    }];
    
    [self.locationImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(ScreenScale(-12));
        make.width.mas_equalTo(ScreenScale(20));
        make.height.mas_equalTo(ScreenScale(25));
        make.top.mas_equalTo(self.titleLb.mas_top);
    }];

    [self.destenceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.locationImgV.mas_left).offset(ScreenScale(-23));
        make.centerY.mas_equalTo(self.titleLb.mas_centerY);
    }];
}

@end
