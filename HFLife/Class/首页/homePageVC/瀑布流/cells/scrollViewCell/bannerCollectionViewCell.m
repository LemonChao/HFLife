//
//  privilageCollectionViewCell.m
//  HF_Life
//
//  Created by sxf_pro on 2018/11/12.
//  Copyright © 2018年 sxf. All rights reserved.
//

#import "bannerCollectionViewCell.h"
@interface  bannerCollectionViewCell()
@property (nonatomic ,strong) UIImageView *imageV;
@property (nonatomic ,strong) UILabel *titleLb;
@property (nonatomic ,strong) UILabel *currentPriceLb;
@property (nonatomic ,strong) UILabel *priceLb;
@property (nonatomic ,strong) UIImageView *incoderImageV;
@property (nonatomic ,strong) UILabel *sellCountLb;


@end


@implementation bannerCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addChildrenViews];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}


- (void) addChildrenViews{
    
    [self.contentView addSubview:self.imageV];
    
    
    self.imageV.backgroundColor = HEX_COLOR(0xE1E1E1);
    self.imageV.layer.cornerRadius = 5;
    self.imageV.clipsToBounds = YES;
    
  
    
   
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat margin = 6;
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(margin);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenScale(12));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-ScreenScale(12));
    }];
}





- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
    }
    return _imageV;
}
- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
    }
    return _titleLb;
}
- (UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] init];
    }
    return _priceLb;
}

-(UILabel *)currentPriceLb{
    if (!_currentPriceLb) {
        _currentPriceLb = [[UILabel alloc] init];
    }
    return _currentPriceLb;
}


- (UIImageView *)incoderImageV{
    if (!_incoderImageV) {
        _incoderImageV = [[UIImageView alloc] init];
    }
    return _incoderImageV;
}

- (UILabel *)sellCountLb{
    if (!_sellCountLb) {
        _sellCountLb = [[UILabel alloc] init];
    }
    return _sellCountLb;
}

@end
