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
//        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLable];
        
//        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.top.equalTo(self.contentView);
//            make.size.mas_equalTo(CGSizeMake(ScreenScale(55), ScreenScale(55)));
//        }];
        
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setModel:(ZCShopClassifyListModel *)model {
    _model = model;
    self.titleLable.text = model.gc_name;
    NSInteger column = model.indexPath.row % 3;
    if (column == 0) {
        self.titleLable.textAlignment = NSTextAlignmentLeft;
        self.titleLable.lineBreakMode = NSLineBreakByTruncatingTail;
    }else if (column == 1) {
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.lineBreakMode = NSLineBreakByClipping;
    }else {
        self.titleLable.textAlignment = NSTextAlignmentRight;
        self.titleLable.lineBreakMode = NSLineBreakByTruncatingHead;
    }
}


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UITool imageViewImage:nil contentMode:UIViewContentModeScaleAspectFit];
    }
    return _imageView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UITool labelWithText:nil textColor:ImportantColor font:SystemFont(12) alignment:NSTextAlignmentCenter numberofLines:1 backgroundColor:[UIColor whiteColor]];
    }
    return _titleLable;
}


@end
