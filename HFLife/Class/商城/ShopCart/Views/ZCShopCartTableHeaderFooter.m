//
//  ZCShopCartTableHeaderFooter.m
//  HFLife
//
//  Created by zchao on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopCartTableHeaderFooter.h"
#import "ZCShopCartGuessLikeCell.h"
#import "ZCShopCartPayResultVC.h"


@interface ZCShopCartTableHeaderView ()

@property(nonatomic, strong) UILabel *titleLable;

@end

@implementation ZCShopCartTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLable = [UITool labelWithTextColor:ImportantColor font:SystemFont(14)];
        self.titleLable.text = @"共6件商品";
        [self addSubview:self.titleLable];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(ScreenScale(12));
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLable.text = title;
}


@end



@interface ZCShopCartEmptyHeaderView ()

@property(nonatomic, strong) UIButton *emptyButton;

@property(nonatomic, strong) UILabel *descriptLabel;

@end

@implementation ZCShopCartEmptyHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.emptyButton];
        [self addSubview:self.descriptLabel];
        
        [self.emptyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(ScreenScale(47));
            make.left.right.equalTo(self);
            make.height.mas_equalTo(115+ScreenScale(10));
        }];
        
        [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.emptyButton.mas_bottom).offset(ScreenScale(5));
        }];
        
        [self layoutIfNeeded];
        [self.emptyButton setImagePosition:ImagePositionTypeTop WithMargin:0];
    }
    return self;
}

- (void)emptyButtonAction:(UIButton *)button {
    ZCShopCartPayResultVC *result = [[ZCShopCartPayResultVC alloc] init];
    
    [self.viewController.navigationController pushViewController:result animated:YES];
}

- (UIButton *)emptyButton {
    if (!_emptyButton) {
        _emptyButton = [UITool richButton:UIButtonTypeCustom title:@"购物车还是空的" titleColor:ImportantColor font:SystemFont(18) bgColor:[UIColor clearColor] image:image(@"shop_cart_empty")];
        [_emptyButton addTarget:self action:@selector(emptyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emptyButton;
}

- (UILabel *)descriptLabel {
    if (!_descriptLabel) {
        _descriptLabel = [UITool labelWithText:@"去商城找找自己喜欢的商品吧" textColor:ImportantColor font:SystemFont(18) alignment:NSTextAlignmentCenter numberofLines:1 backgroundColor:[UIColor clearColor]];
    }
    return _descriptLabel;
}


@end







@interface ZCShopCartTableFooterView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) UICollectionViewFlowLayout *layout;

@property(nonatomic, strong) UIButton *likeButton;

@end

@implementation ZCShopCartTableFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.likeButton = [UITool wordButton:@"猜你喜欢" titleColor:ImportantColor font:MediumFont(18) bgImage:image(@"cainixihuan")];

        [self addSubview:self.likeButton];
        [self addSubview:self.collectionView];
        
        [self.likeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.lessThanOrEqualTo(self).inset(ScreenScale(8));
        }];
        
        [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.likeButton.mas_bottom).offset(ScreenScale(12));
            make.left.right.bottom.equalTo(self);
        }];
    }
    return self;
}


- (void)setViewModel:(ZCShopCartViewModel *)viewModel {
    _viewModel = viewModel;
    
    [self bindViewModel];
}


- (void)bindViewModel {
    @weakify(self);
    
    [[RACObserve(self, viewModel.likeArray) skip:1] subscribeNext:^(NSArray <__kindof ZCShopCartLikeModel *> * _Nullable likeArray) {
        @strongify(self);
        if (likeArray.count) {
            [self.collectionView reloadData];
            
            CGFloat margin = [self.likeButton intrinsicContentSize].height +ScreenScale(20);
            self.height = self.collectionView.collectionViewLayout.collectionViewContentSize.height + margin;
            
            [(UITableView*)self.superview reloadData];
        }
    }];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.likeArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCShopCartGuessLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCShopCartGuessLikeCell class]) forIndexPath:indexPath];
    ZCShopCartLikeModel *model = self.viewModel.likeArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCShopCartLikeModel *model = self.viewModel.likeArray[indexPath.row];
    ZCShopWebViewController *webVC = [[ZCShopWebViewController alloc] initWithPath:@"productDetail" parameters:@{@"goods_id":model.goods_id}];
    
    [self.viewController.navigationController pushViewController:webVC animated:YES];
}



- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = BackGroundColor;
        _collectionView.bounces = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[ZCShopCartGuessLikeCell class] forCellWithReuseIdentifier:NSStringFromClass([ZCShopCartGuessLikeCell class])];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat width = (SCREEN_WIDTH - ScreenScale(36))/2;
        _layout.itemSize = CGSizeMake(width, width+ScreenScale(100));
        _layout.sectionInset = UIEdgeInsetsMake(0, ScreenScale(12), ScreenScale(10), ScreenScale(12));
        _layout.minimumInteritemSpacing = ScreenScale(12);
        _layout.minimumLineSpacing = ScreenScale(12);
    }
    return _layout;
}
@end




@interface ZCShopCartPayResultHeaderView ()

@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UIButton *stateButton;
@property(nonatomic, strong) UILabel *descriptLabel;
@property(nonatomic, strong) UIButton *leftButton;
@property(nonatomic, strong) UIButton *rightButton;

@end

@implementation ZCShopCartPayResultHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.stateButton];
        [self.contentView addSubview:self.descriptLabel];
        [self.contentView addSubview:self.leftButton];
        [self.contentView addSubview:self.rightButton];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(ScreenScale(10), ScreenScale(12), ScreenScale(10), ScreenScale(12)));
        }];
        
        [self.stateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView).inset(ScreenScale(15));
            make.size.mas_equalTo(CGSizeMake(ScreenScale(100), ScreenScale(30)));
        }];
        
        [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.stateButton.mas_bottom).offset(ScreenScale(10));
        }];
        
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).inset(ScreenScale(16));
            make.right.equalTo(self.contentView.mas_centerX).inset(ScreenScale(10));
            make.size.mas_equalTo(CGSizeMake(ScreenScale(65), ScreenScale(24)));
        }];
        
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.leftButton);
            make.left.equalTo(self.contentView.mas_centerX).offset(ScreenScale(10));
            make.size.equalTo(self.leftButton);
        }];
        
        [self layoutIfNeeded];
        [self.stateButton setImagePosition:ImagePositionTypeLeft spacing:ScreenScale(10)];
    }
    return self;
}



- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UITool viewWithColor:GeneralRedColor];
        _contentView.layer.cornerRadius = ScreenScale(5);
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}

- (UIButton *)stateButton {
    if (!_stateButton) {
        _stateButton = [UITool richButton:UIButtonTypeCustom title:@"支付成功" titleColor:[UIColor whiteColor] font:MediumFont(14) bgColor:[UIColor clearColor] image:image(@"shopCart_paySuccess")];
    }
    return _stateButton;
}

- (UILabel *)descriptLabel {
    if (!_descriptLabel) {
        _descriptLabel = [UITool labelWithText:@"付款￥68.90" textColor:[UIColor whiteColor] font:SystemFont(12)];
        _descriptLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _descriptLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UITool wordButton:@"重新支付" titleColor:[UIColor whiteColor] font:SystemFont(12) bgColor:[UIColor clearColor]];
        MMViewBorderRadius(_leftButton, ScreenScale(12), 0.8, [UIColor whiteColor]);
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UITool wordButton:@"查看订单" titleColor:[UIColor whiteColor] font:SystemFont(12) bgColor:[UIColor clearColor]];
        MMViewBorderRadius(_rightButton, ScreenScale(12), 0.8, [UIColor whiteColor]);
    }
    return _rightButton;
}

@end

