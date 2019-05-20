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

@end

@implementation ZCHeaderCategoryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setModel:(ZCShopHomeClassModel *)model {
    _model = model;
    
    [self.button setTitle:model.gc_name forState:UIControlStateNormal];
    [self.button sd_setImageWithURL:[NSURL URLWithString:model.image] forState:UIControlStateNormal];
    [self.button sd_setImageWithURL:[NSURL URLWithString:model.image] forState:UIControlStateHighlighted];
    [self.button setImagePosition:ImagePositionTypeTop WithMargin:ScreenScale(6)];
}


- (UIButton *)button {
    if (!_button) {
        _button = [UITool richButton:UIButtonTypeCustom title:nil titleColor:ImportantColor font:SystemFont(12) bgColor:[UIColor whiteColor] image:nil];
        _button.userInteractionEnabled = NO;
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)buttonAction:(UIButton *)button {
    
}

@end
