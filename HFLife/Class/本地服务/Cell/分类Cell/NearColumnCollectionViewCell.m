//
//  NearColumnCollectionViewCell.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/8.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "NearColumnCollectionViewCell.h"

@implementation NearColumnCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    
    self.title = [[UILabel alloc] init];
    self.title.numberOfLines = 0;
    self.title.font = [UIFont systemFontOfSize:WidthRatio(21)];
    self.title.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.title];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
        //    self.imgView.frame = CGRectMake(0, 0, WidthRatio(72), WidthRatio(72));
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
//        make.width.height.mas_equalTo(WidthRatio(100));
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(45);
    }];
    MMViewBorderRadius(self.imgView, WidthRatio(15), 0, [UIColor clearColor]);
    self.imgView.center = self.contentView.center;
        //    self.imgView.backgroundColor = [UIColor redColor];
    
        //    self.title.frame = CGRectMake(self.contentView.left, self.imgView.bottom, self.contentView.width, 28);
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(HeightRatio(16));
        make.centerX.mas_equalTo(self.imgView.mas_centerX);
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_equalTo(HeightRatio(21));
    }];
}
@end
