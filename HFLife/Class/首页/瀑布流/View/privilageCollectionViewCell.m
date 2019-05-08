//
//  privilageCollectionViewCell.m
//  DoLifeApp
//
//  Created by sxf_pro on 2018/11/12.
//  Copyright © 2018年 张志超. All rights reserved.
//

#import "privilageCollectionViewCell.h"
@interface  privilageCollectionViewCell()
@property (nonatomic ,strong) UIImageView *imageV;
@property (nonatomic ,strong) UILabel *titleLb;
@property (nonatomic ,strong) UILabel *currentPriceLb;
@property (nonatomic ,strong) UILabel *priceLb;
@property (nonatomic ,strong) UIImageView *incoderImageV;
@property (nonatomic ,strong) UILabel *sellCountLb;


@end


@implementation privilageCollectionViewCell



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
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.currentPriceLb];
    [self.contentView addSubview:self.priceLb];
    [self.contentView addSubview:self.incoderImageV];
    [self.contentView addSubview:self.sellCountLb];
    
    self.imageV.backgroundColor = HEX_COLOR(0x999999);
    self.imageV.layer.cornerRadius = 4;
    self.imageV.clipsToBounds = YES;
    
    self.titleLb.numberOfLines = 2;
    self.titleLb.textColor = HEX_COLOR(0x333333);
    self.titleLb.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    
    self.currentPriceLb.textColor =  [UIColor colorWithRed:246/255.0 green:46/255.0 blue:46/255.0 alpha:1];
    self.currentPriceLb.font =  [UIFont fontWithName:@"DIN-Medium" size:20];
    
    self.incoderImageV.image = [UIImage imageNamed:@"vip_会员价-黑小"];
    
    self.priceLb.textColor = HEX_COLOR(0x333333);
    self.priceLb.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    
    self.sellCountLb.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
    self.sellCountLb.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    
    
    
    self.titleLb.text = @"eqeqeqw";
    self.currentPriceLb.text = @"eqvvvvv";
    self.priceLb.text = @"adasdadad";
    self.sellCountLb.text = @"已售0";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.contentView).offset(margin);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-margin);
        make.width.mas_equalTo(161 - 2 * margin);
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageV.mas_right).offset(margin);
        make.top.mas_equalTo(self.imageV.mas_top).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-22);
    }];
    
    [self.currentPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLb.mas_left).offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-33);
    }];
    [self.priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLb.mas_left).offset(0);
        make.bottom.mas_equalTo(self.imageV.mas_bottom).offset(0);
    }];
    
    [self.sellCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.priceLb.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-14);
    }];
    
    [self.incoderImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.currentPriceLb.mas_centerY);
        make.left.mas_equalTo(self.currentPriceLb.mas_right).offset(2);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(42);
    }];
    
    [self layoutIfNeeded];
   
    
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
