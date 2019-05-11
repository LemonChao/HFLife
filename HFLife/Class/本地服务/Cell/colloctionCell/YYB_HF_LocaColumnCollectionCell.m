//
//  YYB_HF_LocaColumnCollectionCell.m
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_LocaColumnCollectionCell.h"

@implementation YYB_HF_LocaColumnCollectionCell
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
    self.title.font = FONT(12);
    self.title.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.title];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(ScreenScale(55));
        make.height.mas_equalTo(ScreenScale(45));
    }];
//    MMViewBorderRadius(self.imgView, WidthRatio(15), 0, [UIColor clearColor]);
    //    self.imgView.backgroundColor = [UIColor redColor];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(ScreenScale(8));
        make.left.mas_equalTo(self.imgView);
        make.right.mas_equalTo(self.imgView);
        make.height.mas_equalTo(ScreenScale(12));
    }];
}
@end
