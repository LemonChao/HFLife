//
//  ZCShopOrderTableHeader.m
//  HFLife
//
//  Created by zchao on 2019/5/27.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopOrderTableHeader.h"
#import "UILabelEdgeInsets.h"

@interface ZCWordsButton : UIControl

@property(nonatomic, copy) NSString *topString;

@property(nonatomic, copy) NSString *bottomString;

@end

@interface ZCShopOrderTableHeader ()

@property(nonatomic, strong) UIImageView *topBgView;
@property(nonatomic, strong) UIView *bottomContentView;
@property(nonatomic, strong) ZCWordsButton *goodsWishlist;
@property(nonatomic, strong) ZCWordsButton *shopWishlist;
@property(nonatomic, strong) UIButton *historyWishlist;
@property(nonatomic, strong) UIButton *portraitButton;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabelEdgeInsets *levelLabel;

@end



@implementation ZCShopOrderTableHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *horizontalLine = [UITool viewWithColor:LineColor];
        UIView *verticalLine1 = [UITool viewWithColor:LineColor];
        UIView *verticalLine2 = [UITool viewWithColor:LineColor];

        [self addSubview:self.topBgView];
        [self addSubview:self.bottomContentView];
        [self.bottomContentView addSubview:self.goodsWishlist];
        [self.bottomContentView addSubview:verticalLine1];
        [self.bottomContentView addSubview:self.shopWishlist];
        [self.bottomContentView addSubview:verticalLine2];
        [self.bottomContentView addSubview:self.historyWishlist];
        [self.bottomContentView addSubview:horizontalLine];
        
        [self.bottomContentView addSubview:self.portraitButton];
        [self.bottomContentView addSubview:self.nameLabel];
        [self.bottomContentView addSubview:self.levelLabel];
        
        [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo(ScreenScale(190));
        }];
        
        [self.bottomContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(ScreenScale(130));
            make.left.right.equalTo(self).inset(ScreenScale(12));
            make.bottom.equalTo(self).inset(ScreenScale(10));
        }];
        
        
        [self.portraitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bottomContentView);
            make.centerY.equalTo(self.bottomContentView.mas_top);
            make.size.mas_equalTo(CGSizeMake(ScreenScale(84), ScreenScale(84)));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.portraitButton.mas_bottom).offset(ScreenScale(12));
            make.left.equalTo(self.bottomContentView).offset(0);
        }];
        
        [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).offset(ScreenScale(6));
            make.centerY.equalTo(self.nameLabel);
            make.height.mas_equalTo(ScreenScale(20));
       }];
        
        [self.goodsWishlist mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomContentView);
            make.bottom.equalTo(self.bottomContentView).inset(ScreenScale(10));
            make.height.mas_equalTo(ScreenScale(35));
        }];
        
        [verticalLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodsWishlist.mas_right);
            make.centerY.equalTo(self.goodsWishlist);
            make.size.mas_equalTo(CGSizeMake(1, ScreenScale(30)));
        }];
        
        [self.shopWishlist mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(verticalLine1.mas_right);
            make.bottom.equalTo(self.goodsWishlist);
            make.size.equalTo(self.goodsWishlist);
        }];
        
        [verticalLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.shopWishlist.mas_right);
            make.centerY.equalTo(self.shopWishlist);
            make.size.mas_equalTo(CGSizeMake(1, ScreenScale(30)));
        }];

        [self.historyWishlist mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(verticalLine2.mas_right);
            make.right.equalTo(self.bottomContentView);
            make.bottom.equalTo(self.goodsWishlist);
            make.size.equalTo(self.goodsWishlist);
        }];
        
        [horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bottomContentView);
            make.bottom.equalTo(self.goodsWishlist.mas_top).inset(ScreenScale(8));
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}

- (void)setModel:(ZCShopOrderModel *)model {
    _model = model;
    self.levelLabel.edgeInsets = UIEdgeInsetsMake(0, ScreenScale(5), 0, ScreenScale(5));

    [self.portraitButton sd_setImageWithURL:[NSURL URLWithString:model.avatar] forState:UIControlStateNormal];
    self.nameLabel.text = model.user_name;
    self.levelLabel.text = model.level_name;
    self.goodsWishlist.topString = model.favorites_goods;
    self.shopWishlist.topString = model.favorites_store;
    
    CGFloat offset = (SCREEN_WIDTH - ScreenScale(30)-self.nameLabel.intrinsicContentSize.width-self.levelLabel.intrinsicContentSize.width)/2;
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomContentView).inset(offset);
    }];
    [self.historyWishlist setImagePosition:ImagePositionTypeTop spacing:ScreenScale(3)];

}



- (void)goodsWishlistAction:(ZCWordsButton *)button {
    ZCShopWebViewController *webVC = [[ZCShopWebViewController alloc] initWithPath:@"collect" parameters:@{@"collectType":@"1"}];
    [self.viewController.navigationController pushViewController:webVC animated:YES];
}

- (void)shopWishlistAction:(ZCWordsButton *)button {
    ZCShopWebViewController *webVC = [[ZCShopWebViewController alloc] initWithPath:@"collect" parameters:@{@"collectType":@"2"}];
    [self.viewController.navigationController pushViewController:webVC animated:YES];
}

- (void)historyWishlistAction:(ZCWordsButton *)button {
    ZCShopWebViewController *webVC = [[ZCShopWebViewController alloc] initWithPath:@"footprint" parameters:nil];
    [self.viewController.navigationController pushViewController:webVC animated:YES];
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

- (ZCWordsButton *)goodsWishlist {
    if (!_goodsWishlist) {
        _goodsWishlist = [[ZCWordsButton alloc] init];
        _goodsWishlist.bottomString = @"商品收藏";
        _goodsWishlist.topString = @"0";
        [_goodsWishlist addTarget:self action:@selector(goodsWishlistAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goodsWishlist;
}

- (ZCWordsButton *)shopWishlist {
    if (!_shopWishlist) {
        _shopWishlist = [[ZCWordsButton alloc] init];
        _shopWishlist.bottomString = @"店铺收藏";
        _shopWishlist.topString = @"0";
        [_shopWishlist addTarget:self action:@selector(shopWishlistAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shopWishlist;
}

//- (ZCWordsButton *)historyWishlist {
//    if (!_historyWishlist) {
//        _historyWishlist = [[ZCWordsButton alloc] init];
//        _historyWishlist.bottomString = @"我的足迹";
//        _historyWishlist.topString = @"09";
//        [_historyWishlist addTarget:self action:@selector(historyWishlistAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _historyWishlist;
//}
- (UIButton *)historyWishlist {
    if (!_historyWishlist) {
        _historyWishlist = [UITool richButton:UIButtonTypeCustom title:@"我的足迹" titleColor:ImportantColor font:SystemFont(13) bgColor:[UIColor whiteColor] image:image(@"orderCenter_zuji")];
        [_historyWishlist addTarget:self action:@selector(historyWishlistAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _historyWishlist;
}


- (UIButton *)portraitButton {
    if (!_portraitButton) {
        _portraitButton = [UITool imageButton:nil cornerRadius:ScreenScale(42) borderWidth:ScreenScale(2) borderColor:GeneralRedColor];
        _portraitButton.backgroundColor = GeneralRedColor;
        _portraitButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _portraitButton;
}

- (UILabelEdgeInsets *)levelLabel {
    if (!_levelLabel) {
        _levelLabel = [[UILabelEdgeInsets alloc] init];
        _levelLabel.textColor = [UIColor whiteColor];
        _levelLabel.font = SystemFont(12);
        _levelLabel.textAlignment = NSTextAlignmentCenter;
        _levelLabel.backgroundColor = GeneralRedColor;
        _levelLabel.layer.cornerRadius = ScreenScale(10);
        _levelLabel.clipsToBounds = YES;
    }
    return _levelLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UITool labelWithTextColor:ImportantColor font:SystemFont(14)];
    }
    return _nameLabel;
}


@end





@interface ZCWordsButton ()

@property(nonatomic, strong) UILabel *topLable;

@property(nonatomic, strong) UILabel *bottomLable;

@property(nonatomic, assign) CGFloat spacing;

@end


@implementation ZCWordsButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commomInit];
    }
    return self;
}

- (void)commomInit {
    self.topLable = [UITool labelWithTextColor:ImportantColor font:SystemFont(13) alignment:NSTextAlignmentCenter];
    self.bottomLable = [UITool labelWithTextColor:ImportantColor font:SystemFont(13) alignment:NSTextAlignmentCenter];
    [self addSubview:self.topLable];
    [self addSubview:self.bottomLable];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.topLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
    }];
    
    [self.bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
    }];
    
    [super updateConstraints];
}

- (CGSize)intrinsicContentSize {
    
    CGSize topSize = [self.topLable sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGSize bottomSize = [self.bottomLable sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    CGFloat width = topSize.width > bottomSize.width ? topSize.width : bottomSize.width;
    CGFloat height = topSize.height > bottomSize.height ? topSize.height : bottomSize.height;
    
    if (topSize.height == 0 || bottomSize.height == 0) {
        return CGSizeMake(width, height);
    }else {
        return CGSizeMake(width, topSize.height+bottomSize.height+self.spacing);
    }
    
}




#pragma mark - setter && getter

- (void)setTopString:(NSString *)topString {
    if (_topString == topString || [_topString isEqual:topString]) return;
    
    _topString = topString;
    self.topLable.text = topString;
    [self setNeedsUpdateConstraints];
}

- (void)setBottomString:(NSString *)bottomString {
    if (_bottomString == bottomString || [_bottomString isEqual:bottomString]) return;
    
    _bottomString = bottomString;
    self.bottomLable.text = _bottomString;
    [self setNeedsUpdateConstraints];
}


@end
