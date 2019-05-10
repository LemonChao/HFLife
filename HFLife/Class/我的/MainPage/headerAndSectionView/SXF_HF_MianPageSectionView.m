
//
//  SXF_HF_MianPageSectionView.m
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_MianPageSectionView.h"

@interface SXF_HF_MianPageSectionView ()

@property (nonatomic, strong)UIView *leftView;

@end

@implementation SXF_HF_MianPageSectionView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self addChildrenViews];
    }
    
    return self;
}


- (void) addChildrenViews{
    self.titleLb = [UILabel new];
    self.leftView = [UIView new];
    
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.leftView];
    
    self.leftView.backgroundColor = HEX_COLOR(0xCA1400);
    self.titleLb.font = FONT(15);
    self.titleLb.textColor = HEX_COLOR(0x131313);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenScale(15));
        make.width.mas_equalTo(ScreenScale(3));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(14));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(ScreenScale(-14));
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftView.mas_right).offset(ScreenScale(5));
        make.centerY.mas_equalTo(self.leftView.mas_centerY);
    }];
}
@end
