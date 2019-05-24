//
//  ZCShopCartTableHeaderFooter.m
//  HFLife
//
//  Created by zchao on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopCartTableHeaderFooter.h"
#import "ZCShopCartGuessLikeCell.h"


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



- (UIButton *)emptyButton {
    if (!_emptyButton) {
        _emptyButton = [UITool richButton:UIButtonTypeCustom title:@"购物车还是空的" titleColor:ImportantColor font:SystemFont(18) bgColor:[UIColor clearColor] image:image(@"shop_cart_empty")];
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
    [[self.viewModel.gussLikeCmd execute:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.collectionView reloadData];
        
        CGFloat margin = [self.likeButton intrinsicContentSize].height +ScreenScale(20);
        self.height = self.collectionView.collectionViewLayout.collectionViewContentSize.height + margin;
        
        [(UITableView*)self.superview reloadData];
        
    } error:^(NSError * _Nullable error) {
        
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



