//
//  ZCHeaderCategoryCell.m
//  HFLife
//
//  Created by zchao on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCHeaderCategoryCell.h"

@interface ZCHeaderCategoryCell ()

@property(nonatomic, strong) UIButton *button;

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZCHeaderCategoryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).inset(ScreenScale(12));
            make.bottom.equalTo(self.titleLabel.mas_top).inset(ScreenScale(10));
        }];
    }
    return self;
}

- (void)setModel:(ZCShopHomeClassModel *)model {
    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.titleLabel.text = model.gc_name;
}


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView  = [UITool imageViewImage:nil contentMode:UIViewContentModeScaleAspectFit];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UITool labelWithTextColor:ImportantColor font:SystemFont(12) alignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}


@end
