//
//  ZCClassifyRightHeaderView.m
//  HFLife
//
//  Created by zchao on 2019/5/16.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCClassifyRightHeaderView.h"

@interface ZCClassifyRightHeaderView ()

@property(nonatomic, strong) UIButton *titleButton;

@end

@implementation ZCClassifyRightHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleButton];
        
        [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setModel:(ZCShopClassifyListModel *)model {
    _model = model;
    
    [self.titleButton setTitle:model.gc_name forState:UIControlStateNormal];
    [self.titleButton setTitle:model.gc_name forState:UIControlStateSelected];
    self.titleButton.selected = !model.isClosed;
    [self.titleButton setImagePosition:ImagePositionTypeRight WithMargin:ScreenScale(10)];
}

- (void)titleButtonAction:(UIButton *)button {
    self.model.closed = !self.model.isClosed;
    
    button.selected = self.model.isClosed;
    UICollectionView *collectionView = (UICollectionView*)self.superview;
    [collectionView performBatchUpdates:^{
        [collectionView reloadSections:[NSIndexSet indexSetWithIndex:self.model.indexPath.section]];
    } completion:nil];
}

- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [UITool richButton:UIButtonTypeCustom title:nil titleColor:ImportantColor font:SystemFont(14) bgColor:HEX_COLOR(0xFBFBFB) image:image(@"classify_arrow_right_gray")];
        [_titleButton setTitleColor:GeneralRedColor forState:UIControlStateSelected];
        [_titleButton setImage:image(@"classify_arrow_down_gray") forState:UIControlStateSelected];
        [_titleButton setBackgroundImage:[UIImage imageWithColor:HEX_COLOR(0xFBFBFB)] forState:UIControlStateNormal];
       [_titleButton setBackgroundImage:[UIImage imageWithColor:HEX_COLOR(0xFAE7E5)] forState:UIControlStateSelected];
        [_titleButton addTarget:self action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleButton;
}



@end
