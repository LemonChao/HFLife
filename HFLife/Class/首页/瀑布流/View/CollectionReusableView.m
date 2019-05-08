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
        _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_textLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [_textLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
        [_textLabel.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
        [_textLabel.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
        _textLabel.font = [UIFont systemFontOfSize:18 weight:1.5];
        _textLabel.textColor = HEX_COLOR(0x131313);
       
    }
    return self;
}

@end
