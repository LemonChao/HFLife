//
//  ZCShopCartTableViewCell.m
//  HFLife
//
//  Created by zchao on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopCartTableViewCell.h"

@interface ZCShopCartTableViewCell ()

@property(nonatomic, strong) UIButton *selectButton;

@property(nonatomic, strong) UIImageView *godsImgView;

@property(nonatomic, strong) UILabel *nameLab;

/** 促销价 */
@property(nonatomic, strong) UILabel *priceLab;



@end

@implementation ZCShopCartTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.selectButton];
        [self.contentView addSubview:self.godsImgView];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.priceLab];
        
        [self initConstraints];
    }
    return self;
}

- (void)initConstraints {

    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).inset(ScreenScale(12));
        make.centerY.equalTo(self.godsImgView);
        make.size.mas_equalTo(CGSizeMake(ScreenScale(20), ScreenScale(20)));
    }];
    
    [self.godsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectButton.mas_right).offset(ScreenScale(10));
        make.size.mas_equalTo(CGSizeMake(ScreenScale(80), ScreenScale(80)));
        make.top.equalTo(self.contentView).inset(ScreenScale(10));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).inset(ScreenScale(20));
        make.left.equalTo(self.godsImgView.mas_right).offset(ScreenScale(10));
        make.right.equalTo(self.contentView).inset(ScreenScale(22));
        make.height.mas_lessThanOrEqualTo(ScreenScale(30));
//        make.height.mas_equalTo(ScreenScale(35));
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).offset(ScreenScale(16));
        make.left.equalTo(self.nameLab);
        make.bottom.equalTo(self.contentView).inset(ScreenScale(24));
    }];
    
}


- (void)selectButtonAction:(UIButton *)button {
    button.selected = !button.selected;
}


- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UITool imageButton:image(@"cart_gods_normal")];
        [_selectButton setImage:image(@"cart_gods_select") forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];

        [_selectButton setEnlargeEdgeWithTop:15 right:10 bottom:15 left:10];
    }
    return _selectButton;
}

- (UIImageView *)godsImgView {
    if (!_godsImgView) {
        _godsImgView = [UITool imageViewPlaceHolder:image(@"image2") contentMode:UIViewContentModeScaleToFill cornerRadius:WidthRatio(5) borderWidth:0 borderColor:[UIColor clearColor]];
    }
    return _godsImgView;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UITool labelWithTextColor:ImportantColor font:SystemFont(14)];
        _nameLab.numberOfLines = 2;
        _nameLab.text = @"泰国进口即食牛油果泰国进口即食牛 油果 拷贝";
    }
    return _nameLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [UITool labelWithTextColor:GeneralRedColor font:MediumFont(14)];
        _priceLab.text = @"￥58.00";
    }
    return _priceLab;
}


@end
