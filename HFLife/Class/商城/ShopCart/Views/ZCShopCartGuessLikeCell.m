//
//  ZCShopCartGuessLikeCell.m
//  HFLife
//
//  Created by zchao on 2019/5/18.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopCartGuessLikeCell.h"

@interface ZCShopCartGuessLikeCell ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLab;
@property(nonatomic, strong) UILabel *descriptLab;
@property(nonatomic, strong) UILabel *priceLab;
@property(nonatomic, strong) UIButton *cartButton;
@property(nonatomic, strong) UILabel *countlab;
@end



@implementation ZCShopCartGuessLikeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = WidthRatio(5);
        self.contentView.clipsToBounds = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.priceLab];
        [self.contentView addSubview:self.countlab];
        [self.contentView addSubview:self.cartButton];
                
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.equalTo(self.imageView.mas_width);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView).inset(ScreenScale(10));
            make.top.equalTo(self.imageView.mas_bottom).offset(ScreenScale(10));
        }];
        
        [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView).inset(ScreenScale(10));
            make.top.equalTo(self.titleLab.mas_bottom).offset(ScreenScale(16));
        }];
        
        [self.countlab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.priceLab);
            make.top.equalTo(self.priceLab.mas_bottom).offset(ScreenScale(10));
        }];
        
        [self.cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.contentView).inset(ScreenScale(10));
        }];
    }
    return self;
}
#if 0 //自动计算高度
- (void)initSelfSizingContraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo((SCREEN_WIDTH - ScreenScale(36))/2);
        make.bottom.mas_equalTo(self.countlab.mas_bottom).offset(ScreenScale(10));
    }];
    
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(self.imageView.mas_width);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).inset(ScreenScale(10));
        make.top.equalTo(self.imageView.mas_bottom).offset(ScreenScale(10));
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).inset(ScreenScale(10));
        make.top.equalTo(self.titleLab.mas_bottom).offset(ScreenScale(16));
    }];
    
    [self.countlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab);
        make.top.equalTo(self.priceLab.mas_bottom).offset(ScreenScale(10));
    }];
    
    [self.cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentView).inset(ScreenScale(10));
    }];
}


- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [self setNeedsLayout];
    [self layoutIfNeeded];

//    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize withHorizontalFittingPriority:UILayoutPriorityFittingSizeLevel verticalFittingPriority:UILayoutPriorityFittingSizeLevel];

    CGRect newFrame = layoutAttributes.frame;
    NSLog(@"size:%@---%@", NSStringFromCGSize(layoutAttributes.size), NSStringFromCGSize(size));
//    newFrame.size = CGSizeMake(size.width, size.height);
    newFrame.size.height = size.height;
    layoutAttributes.frame = newFrame;
    return layoutAttributes;
    
//    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
//    attributes.size = [self systemLayoutSizeFittingSize:layoutAttributes.size withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
//    return attributes;
//
}
#endif

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UITool imageViewPlaceHolder:image(@"image2") contentMode:UIViewContentModeScaleAspectFill cornerRadius:ScreenScale(5) borderWidth:0.f borderColor:[UIColor clearColor]];
    }
    return _imageView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UITool labelWithTextColor:ImportantColor font:MediumFont(14)];
        _titleLab.text = @"夏季纯色贴身舒适阔腿舒适阔腿舒适阔腿舒适阔腿舒适阔腿";
    }
    return _titleLab;
}

- (UILabel *)countlab {
    if (!_countlab) {
        _countlab = [UITool labelWithText:@"销量" textColor:AssistColor font:SystemFont(12)];
    }
    return _countlab;
}
- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [UITool labelWithTextColor:GeneralRedColor font:MediumFont(18)];
        _priceLab.text = @"￥138.00";
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
