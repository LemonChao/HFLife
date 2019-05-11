//
//  ZCDisCountCollectionCell.m
//  HFLife
//
//  Created by zchao on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCDisCountCollectionCell.h"

@interface ZCDisCountCollectionCell ()

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, copy) UILabel *titleLable;

@property(nonatomic, copy) UILabel *priceLabel;

@end

@implementation ZCDisCountCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.priceLabel];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(ScreenScale(120));
        }];
        
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(ScreenScale(10));
            make.left.right.equalTo(self.contentView);
        }];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UITool imageViewPlaceHolder:image(@"image1") contentMode:UIViewContentModeScaleAspectFill cornerRadius:ScreenScale(5) borderWidth:0.f borderColor:[UIColor clearColor]];
    }
    return _imageView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UITool labelWithTextColor:ImportantColor font:SystemFont(14)];
        _titleLable.numberOfLines = 2;
        _titleLable.text = @"四川攀枝花枇杷 新鲜水嫩肉厚皮薄好吃太好吃了这么会这么好吃";
    }
    return _titleLable;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UITool labelWithTextColor:GeneralRedColor font:MediumFont(14)];
        _priceLabel.text = @"￥2324.66";
    }
    return _priceLabel;
}



@end
