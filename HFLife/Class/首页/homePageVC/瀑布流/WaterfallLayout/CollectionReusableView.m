//
//  CollectionReusableView.m
//  Example
//
//  Created by nhope on 2018/4/28.
//  Copyright © 2018年 xiaopin. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _textLabel = [[UILabel alloc] init];
        [self addSubview:_textLabel];
       
        _textLabel.frame = CGRectMake(ScreenScale(12), 0, 200, self.frame.size.height);
        _textLabel.font = [UIFont systemFontOfSize:18 weight:1.5];
        _textLabel.textColor = HEX_COLOR(0x131313);

    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(12));
        make.top.bottom.mas_equalTo(self);
    }];
}


@end
