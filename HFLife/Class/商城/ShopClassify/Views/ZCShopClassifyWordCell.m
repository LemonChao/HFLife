//
//  ZCShopClassifyWordCell.m
//  HFLife
//
//  Created by zchao on 2019/5/16.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopClassifyWordCell.h"

@interface ZCShopClassifyWordCell ()

@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZCShopClassifyWordCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setModel:(ZCShopClassifyListModel *)model {
    _model = model;
    
    self.titleLabel.text = model.gc_name;
}

- (UILabel *)titleLable {
    if (!_titleLabel) {
        _titleLabel = [UITool labelWithTextColor:ImportantColor font:SystemFont(12)];
    }
    return _titleLabel;
}


@end
