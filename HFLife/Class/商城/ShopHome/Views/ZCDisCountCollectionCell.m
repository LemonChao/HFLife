//
//  ZCDisCountCollectionCell.m
//  HFLife
//
//  Created by zchao on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCDisCountCollectionCell.h"
#import "CountdDownView.h"

@interface ZCDisCountCollectionCell ()

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) UILabel *titleLable;

@property(nonatomic, strong) UILabel *priceLabel;

/** 倒计时view */
@property(nonatomic, strong) CountdDownView *countDownView;

@property(nonatomic, strong) NSTimer *timer;
@end

@implementation ZCDisCountCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.priceLabel];
        [self.imageView addSubview:self.countDownView];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.equalTo(self.imageView.mas_width);
        }];
        
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(ScreenScale(10));
            make.left.right.equalTo(self.contentView);
        }];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
        }];
        
        [self.countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView);
            make.bottom.equalTo(self.imageView);
        }];
        
        [self.timer fire];
    }
    return self;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UITool imageViewPlaceHolder:image(@"image1") contentMode:UIViewContentModeScaleAspectFill cornerRadius:ScreenScale(5) borderWidth:0.f borderColor:[UIColor clearColor]];
    }
    return _imageView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UITool labelWithTextColor:ImportantColor font:SystemFont(14)];
        _titleLable.numberOfLines = 2;
        _titleLable.text = @"四川攀枝花枇杷 新鲜水嫩肉厚皮薄好吃太好吃了这么会这么好吃";
    }
    return _titleLable;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UITool labelWithTextColor:GeneralRedColor font:MediumFont(14)];
        _priceLabel.text = @"￥2324.66";
    }
    return _priceLabel;
}

- (CountdDownView *)countDownView {
    if (!_countDownView) {
        _countDownView = [[CountdDownView alloc] init];
        _countDownView.timeInteval = 361000;
    }
    return _countDownView;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer =[NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerOperation:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)timerOperation:(NSTimer *)timer {
    self.countDownView.timeInteval -= 1;
}

@end
