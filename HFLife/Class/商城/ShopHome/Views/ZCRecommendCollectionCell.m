//
//  ZCRecommendCollectionCell.m
//  HFLife
//
//  Created by zchao on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCRecommendCollectionCell.h"

@interface ZCRecommendCollectionCell ()

//@property(nonatomic, strong) UIView *cornerBgView;

@property(nonatomic, strong) UIImageView *imageView;

//@property(nonatomic, strong) UIView *bottomBGView;

@property(nonatomic, copy) UILabel *titleLable;

@property(nonatomic, copy) UILabel *priceLabel;



@end

@implementation ZCRecommendCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *cornerBgView = [UITool viewWithColor:[UIColor whiteColor]];
        UIView *bottomBGView = [UITool viewWithColor:HEX_COLOR(0xFFFAEB)];

        [self.contentView addSubview:cornerBgView];
        [cornerBgView addSubview:self.imageView];
        [cornerBgView addSubview:bottomBGView];
        
        [cornerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(ScreenScale(5), 0, ScreenScale(5), 0));
        }];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(cornerBgView);
            make.height.mas_equalTo(ScreenScale(100));
        }];
        
        [bottomBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.imageView);
            make.top.equalTo(self.imageView.mas_bottom);
            make.bottom.equalTo(cornerBgView);
        }];
        
        [self layoutIfNeeded];
        [cornerBgView addShadowForViewColor:HEX_COLOR(0xbababa) offSet:CGSizeMake(0, 0) shadowRadius:ScreenScale(5) cornerRadius:ScreenScale(5) opacity:0.8];
        [_imageView addCornerWithRoundedRect:_imageView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(ScreenScale(5), ScreenScale(5))];
    }
    return self;
}

- (void)setModel:(ZCShopNewGoodsModel *)model {
    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_image]];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UITool imageViewImage:image(@"image1") contentMode:UIViewContentModeScaleAspectFill];

    }
    return _imageView;
}


@end
