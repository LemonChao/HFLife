//
//  ZC_HF_ShopHomeSearchButton.m
//  HFLife
//
//  Created by zchao on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "ZC_HF_ShopHomeSearchButton.h"

@implementation ZC_HF_ShopHomeSearchButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 14.f;
        self.clipsToBounds = YES;
        self.backgroundColor = RGBA(237, 242, 243, 1);
        [self addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:image(@"shopHome_search")];
        UILabel *titleLab = [UILabel new].setText(@"搜一搜").setTextColor(AssistColor);
        [self addSubview:imgView];
        [self addSubview:titleLab];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(ScreenScale(10));
        }];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(imgView.mas_right).offset(ScreenScale(13));
        }];
        
    }
    return self;
}

- (void)searchButtonAction:(UIButton *)button {
}

@end
