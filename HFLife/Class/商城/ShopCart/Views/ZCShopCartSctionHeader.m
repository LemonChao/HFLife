//
//  ZCShopCartSctionHeader.m
//  HFLife
//
//  Created by zchao on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopCartSctionHeader.h"

@interface ZCShopCartSctionHeader ()

@property(nonatomic, strong) UIButton *selectButton;

@property(nonatomic, strong) UIImageView *shopLogoView;

@property(nonatomic, strong) UIButton *shopNameButton;

@end



@implementation ZCShopCartSctionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [UITool viewWithColor:LineColor];

        [self.contentView addSubview:self.selectButton];
        [self.contentView addSubview:self.shopLogoView];
        [self.contentView addSubview:self.shopNameButton];
        [self.contentView addSubview:lineView];

        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).inset(ScreenScale(12));
        }];
        
        [self.shopLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).inset(ScreenScale(12));
            make.bottom.equalTo(self.contentView).inset(ScreenScale(12));
            make.left.equalTo(self.selectButton.mas_right).offset(ScreenScale(10));
        }];
        
        [self.shopNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.shopLogoView.mas_right).offset(ScreenScale(10));
        }];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(0.7);
        }];

    }
    return self;
}

- (void)selectButtonAction:(UIButton *)button {
    button.selected = !button.selected;
    
    self.model.selectAll = !self.model.isSelectAll;
    for (ZCShopCartGoodsModel *item in self.model.goods) {
        item.selected = self.model.selectAll;
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:cartValueChangedNotification object:@"selectAction"];
}

- (void)shopNameButtonAction:(UIButton *)button {
    ZCShopWebViewController *webVC = [[ZCShopWebViewController alloc] initWithPath:@"store_Detail" parameters:@{@"store_id":self.model.store_id}];
    [self.viewController.navigationController pushViewController:webVC animated:YES];
}

- (void)setModel:(ZCShopCartModel *)model {
    _model = model;
    
    self.selectButton.selected = model.isSelectAll;
    [self.shopNameButton setTitle:model.store_name forState:UIControlStateNormal];
    [self.shopNameButton setTitle:model.store_name forState:UIControlStateHighlighted];
    
    CGSize size = [self.shopNameButton intrinsicContentSize];
    [self.shopNameButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(size.width+ScreenScale(6), size.height));
    }];
    
    [self layoutIfNeeded];
    
    [self.shopNameButton setImagePosition:ImagePositionTypeRight spacing:ScreenScale(6)];
    
}


- (UIImageView *)shopLogoView {
    if (!_shopLogoView) {
        _shopLogoView = [[UIImageView alloc] initWithImage:image(@"shop_cart_shopLogo")];
    }
    return _shopLogoView;
}

- (UIButton *)shopNameButton {
    if (!_shopNameButton) {
        _shopNameButton = [UITool richButton:UIButtonTypeCustom title:nil titleColor:ImportantColor font:MediumFont(14) bgColor:[UIColor clearColor] image:image(@"classify_arrow_right_gray")];
        [_shopNameButton addTarget:self action:@selector(shopNameButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shopNameButton;
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
@end
