//
//  ZCShopOrderTableHeader.m
//  HFLife
//
//  Created by zchao on 2019/5/27.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopOrderTableHeader.h"

@interface ZCWordsButton : UIControl

@property(nonatomic, copy) NSString *topString;

@property(nonatomic, copy) NSString *bottomString;

@end

@interface ZCShopOrderTableHeader ()

@property(nonatomic, strong) UIImageView *topBgView;
@property(nonatomic, strong) UIView *bottomContentView;
@property(nonatomic, strong) ZCWordsButton *goodsWishlist;
@property(nonatomic, strong) ZCWordsButton *shopWishlist;
@property(nonatomic, strong) ZCWordsButton *historyWishlist;
@property(nonatomic, strong) UIButton *portraitButton;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *levelLabel;

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
            make.bottom.equalTo(self).inset(ScreenScale(5));
        }];
        
        
        [self.portraitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bottomContentView);
            make.centerY.equalTo(self.bottomContentView.mas_top);
            make.size.mas_equalTo(CGSizeMake(ScreenScale(84), ScreenScale(84)));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.portraitButton.mas_bottom).offset(ScreenScale(12));
            make.left.equalTo(self.portraitButton);
        }];
        
        [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right);
            make.centerY.equalTo(self.nameLabel);
            make.size.mas_equalTo(CGSizeMake(36, 20));//(26,14)
       }];
        
        
        
        
        
        
        
        
        
        [self.goodsWishlist mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomContentView);
            make.bottom.equalTo(self.bottomContentView).inset(ScreenScale(10));
            make.height.mas_equalTo(ScreenScale(32));
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
        _goodsWishlist.topString = @"50";
    }
    return _goodsWishlist;
}

- (ZCWordsButton *)shopWishlist {
    if (!_shopWishlist) {
        _shopWishlist = [[ZCWordsButton alloc] init];
        _shopWishlist.bottomString = @"店铺收藏";
        _shopWishlist.topString = @"34";
    }
    return _shopWishlist;
}

- (ZCWordsButton *)historyWishlist {
    if (!_historyWishlist) {
        _historyWishlist = [[ZCWordsButton alloc] init];
        _historyWishlist.bottomString = @"我的足迹";
        _historyWishlist.topString = @"09";
    }
    return _historyWishlist;
}


- (UIButton *)portraitButton {
    if (!_portraitButton) {
        _portraitButton = [UITool imageButton:image(@"image2") cornerRadius:ScreenScale(42) borderWidth:ScreenScale(2) borderColor:GeneralRedColor];
        _portraitButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        _portraitButton = [UITool imageButton:image(@"image2")];
    }
    return _portraitButton;
}

- (UILabel *)levelLabel {
    if (!_levelLabel) {
        _levelLabel = [UITool labelWithText:@"VIP3" textColor:[UIColor whiteColor] font:SystemFont(12) alignment:NSTextAlignmentCenter numberofLines:1 backgroundColor:GeneralRedColor];
        _levelLabel.layer.cornerRadius = 10.f;
        _levelLabel.clipsToBounds = YES;
    }
    return _levelLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UITool labelWithTextColor:ImportantColor font:SystemFont(14)];
        _nameLabel.text = @"垂綏饮清露";
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
