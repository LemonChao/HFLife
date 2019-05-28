//
//  ZCShopOrderTableHeader.m
//  HFLife
//
//  Created by zchao on 2019/5/27.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopOrderTableHeader.h"

@interface ZCShopOrderTableHeader ()

@property(nonatomic, strong) UIImageView *topBgView;
@property(nonatomic, strong) UIView *bottomContentView;
@end



@implementation ZCShopOrderTableHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topBgView];
        [self addSubview:self.bottomContentView];
        
        [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo(ScreenScale(190));
        }];
        
        [self.bottomContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(ScreenScale(130));
            make.left.right.equalTo(self).inset(ScreenScale(12));
            make.bottom.equalTo(self).inset(ScreenScale(5));
        }];
        
        
    }
    return self;
}


- (UIImageView *)topBgView {
    if (!_topBgView) {
        _topBgView = [UITool imageViewImage:image(@"shopOrder_headerBG") contentMode:UIViewContentModeScaleAspectFill];
        
    }
    return _topBgView;
}

- (UIView *)bottomContentView {
    if (!_bottomContentView) {
        _bottomContentView = [UITool viewWithColor:[UIColor whiteColor]];
        [_bottomContentView addShadowForViewColor:GeneralRedColor offSet:CGSizeMake(0, 2) shadowRadius:3 cornerRadius:ScreenScale(5) opacity:0.1];
    }
    return _bottomContentView;
}

@end
