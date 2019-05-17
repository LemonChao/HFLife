//
//  ZCShopCartTableHeaderFooter.m
//  HFLife
//
//  Created by zchao on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopCartTableHeaderFooter.h"

@interface ZCShopCartTableHeaderView ()

@property(nonatomic, strong) UILabel *titleLable;

@end


@implementation ZCShopCartTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLable = [UITool labelWithTextColor:ImportantColor font:SystemFont(14)];
        self.titleLable.text = @"共6件商品";
        [self addSubview:self.titleLable];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(ScreenScale(12));
        }];
    }
    return self;
}

@end



@implementation ZCShopCartTableFooterView



@end



