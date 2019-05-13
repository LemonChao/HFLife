//
//  ZCShopClassifyRightCell.m
//  HFLife
//
//  Created by zchao on 2019/5/13.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopClassifyRightCell.h"

@interface ZCShopClassifyRightCell ()

@property(nonatomic, strong) UIButton *button;

@end


@implementation ZCShopClassifyRightCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.button];
        
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self layoutIfNeeded];
        [self.button setImagePosition:ImagePositionTypeTop WithMargin:0];
    }
    return self;
}



- (UIButton *)button {
    if (!_button) {
        _button = [UITool richButton:UIButtonTypeCustom title:@"苹果" titleColor:ImportantColor font:SystemFont(12) bgColor:[UIColor whiteColor] image:image(@"jiajujiazhuang")];
    }
    return _button;
}



@end
