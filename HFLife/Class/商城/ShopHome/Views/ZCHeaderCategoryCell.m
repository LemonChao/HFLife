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

- (void)setParams:(NSDictionary *)params {
    if (params == _params) return;
    _params = params.copy;
    
    [self.button setTitle:params[@"title"] forState:UIControlStateNormal];
    [self.button setImage:image(params[@"imageName"]) forState:UIControlStateNormal];
    [self.button setImage:image(params[@"imageName"]) forState:UIControlStateHighlighted];
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
