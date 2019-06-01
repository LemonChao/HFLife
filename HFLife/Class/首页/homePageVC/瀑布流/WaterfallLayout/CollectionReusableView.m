//
//  CollectionReusableView.m
//  Example
//
//  Created by nhope on 2018/4/28.
//  Copyright © 2018年 xiaopin. All rights reserved.
//

#import "CollectionReusableView.h"

@interface CollectionReusableView()



@end



@implementation CollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _textLabel = [[UILabel alloc] init];
        [self addSubview:_textLabel];
       
        _textLabel.frame = CGRectMake(ScreenScale(12), 0, 200, self.frame.size.height);
        _textLabel.font = [UIFont systemFontOfSize:18 weight:1.5];
        _textLabel.textColor = HEX_COLOR(0x131313);
        
        [self addSubview:self.moreBtn];
    }
    return self;
}
- (void)clickMoreBtn{
    !self.clickHeaderBtnCallback ? : self.clickHeaderBtnCallback();
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(12));
        make.top.bottom.mas_equalTo(self);
    }];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-12));
        make.left.mas_equalTo(self.textLabel.mas_right).offset(ScreenScale(10));
    }];
}

- (UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [UIButton new];
        [_moreBtn addTarget:self action:@selector(clickMoreBtn) forControlEvents:UIControlEventTouchUpInside];
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:colorAAAAAA forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = FONT(14);
        _moreBtn.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentRight;
    }
    return _moreBtn;
}


@end
