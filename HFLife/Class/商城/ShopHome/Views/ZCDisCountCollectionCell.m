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

- (void)setModel:(ZCShopHomeLimitModel *)model {
    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_image]];
    self.titleLable.text = model.goods_name;
    self.priceLabel.text = model.xianshi_price;
    NSTimeInterval interval = [[NSDate dateWithTimeIntervalSince1970:model.end_time.integerValue] timeIntervalSinceDate:[NSDate date]];
    self.countDownView.timeInteval = interval;
}


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UITool imageViewPlaceHolder:nil contentMode:UIViewContentModeScaleAspectFill cornerRadius:ScreenScale(5) borderWidth:0.f borderColor:[UIColor clearColor]];
    }
    return _imageView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UITool labelWithTextColor:ImportantColor font:SystemFont(14)];
        _titleLable.numberOfLines = 2;
    }
    return _titleLable;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UITool labelWithTextColor:GeneralRedColor font:MediumFont(14)];
    }
    return _priceLabel;
}

- (CountdDownView *)countDownView {
    if (!_countDownView) {
        _countDownView = [[CountdDownView alloc] init];
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

- (void)dealloc {
    [self.timer invalidate];
}


@end
