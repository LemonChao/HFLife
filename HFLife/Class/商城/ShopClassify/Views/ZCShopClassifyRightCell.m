//
//  ZCShopClassifyRightCell.m
//  HFLife
//
//  Created by zchao on 2019/5/13.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopClassifyRightCell.h"

@interface ZCShopClassifyRightCell ()

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) UILabel *titleLable;

@end


@implementation ZCShopClassifyRightCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLable];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.top.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(ScreenScale(55), ScreenScale(55)));
        }];
        
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UITool imageViewImage:image(@"jiajujiazhuang") contentMode:UIViewContentModeScaleAspectFit];
    }
    return _imageView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UITool labelWithText:@"苹果" textColor:ImportantColor font:SystemFont(12) alignment:NSTextAlignmentCenter numberofLines:1 backgroundColor:[UIColor whiteColor]];
    }
    return _titleLable;
}


@end
