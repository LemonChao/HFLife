//
//  ZCRecommendCollectionCell.m
//  HFLife
//
//  Created by zchao on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCRecommendCollectionCell.h"

@interface ZCRecommendCollectionCell ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIView *tagView;
@property(nonatomic, strong) UILabel *titleLab;
@property(nonatomic, strong) UILabel *descriptLab;
@property(nonatomic, strong) UILabel *priceLab;
@property(nonatomic, strong) UIButton *cartButton;
@end

@implementation ZCRecommendCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = ScreenScale(4);
        self.contentView.clipsToBounds = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.tagView];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.descriptLab];
        [self.contentView addSubview:self.priceLab];
        [self.contentView addSubview:self.cartButton];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(ScreenScale(150));
        }];
        
        [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom);
            make.left.right.equalTo(self.imageView);
            make.height.mas_equalTo(ScreenScale(0));
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView).inset(ScreenScale(10));
            make.top.equalTo(self.tagView.mas_bottom).offset(ScreenScale(10));
        }];
        
        [self.descriptLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView).inset(ScreenScale(10));
            make.top.equalTo(self.titleLab.mas_bottom).offset(ScreenScale(8));
        }];
        
        [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView).inset(ScreenScale(10));
            make.top.equalTo(self.descriptLab.mas_bottom).offset(ScreenScale(16));
        }];
        
        [self.cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.contentView).inset(ScreenScale(10));
        }];
    }
    return self;
}



- (void)setModel:(ZCShopNewGoodsModel *)model {
    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_image]];
    self.titleLab.text = model.goods_name;
    self.descriptLab.text = model.goods_name;
    self.priceLab.attributedText = model.attPrice;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UITool imageViewImage:nil contentMode:UIViewContentModeScaleToFill];
    }
    return _imageView;
}

- (UIView *)tagView {
    if (!_tagView) {
        _tagView = [UITool viewWithColor:MMRandomColor];
    }
    return _tagView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UITool labelWithTextColor:ImportantColor font:MediumFont(14)];
    }
    return _titleLab;
}

- (UILabel *)descriptLab {
    if (!_descriptLab) {
        _descriptLab = [UITool labelWithTextColor:AssistColor font:MediumFont(12)];
    }
    return _descriptLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [UITool labelWithTextColor:GeneralRedColor font:MediumFont(18)];
    }
    return _priceLab;
}

- (UIButton *)cartButton {
    if (!_cartButton) {
        _cartButton = [UITool imageButton:image(@"shop_cartButton")];
    }
    return _cartButton;
}


@end
