//
//  YYb_HF_CollReusableView.m
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYb_HF_CollReusableView.h"

@implementation YYb_HF_CollReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _textLabel = [[UILabel alloc] init];
        [self addSubview:_textLabel];
        
        _textLabel.frame = CGRectMake(ScreenScale(12), 0, 200, self.frame.size.height);
        _textLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size: 18];
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

@implementation YYb_HF_HotCollReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _imageV = [[UIImageView alloc] init];
        [self addSubview:_imageV];
        
        _imageV.frame = CGRectMake(ScreenScale(12), ScreenScale(12), 12, 14);
        _imageV.image = image(@"icon_hot");
        _textLabel = [[UILabel alloc] init];
        [self addSubview:_textLabel];
        
        _textLabel.frame = CGRectMake(ScreenScale(12), ScreenScale(30), 200, self.frame.size.height);
        _textLabel.font = FONT(12);
        _textLabel.textColor = HEX_COLOR(0xAAAAAA);
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(30));
        make.top.bottom.mas_equalTo(self);
    }];
}
@end

@implementation YYb_HF_GuessLikeCollReusableViewFoot
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _imageV = [[UIImageView alloc] init];
        [self addSubview:_imageV];
        
        _imageV.image = image(@"nodataguess");
        _textLabel = [[UILabel alloc] init];
        [self addSubview:_textLabel];
        _textLabel.font = FONT(12);
        _textLabel.textColor = HEX_COLOR(0xAAAAAA);
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(10);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(ScreenScale(200));
        make.height.mas_equalTo(ScreenScale(150));
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageV.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(20);
    }];
}

@end
