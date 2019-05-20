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
            make.height.mas_equalTo(ScreenScale(124));
        }];
        
        [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.emptyButton.mas_bottom).offset(ScreenScale(5));
        }];
        
        [self layoutIfNeeded];
        [self.emptyButton setImagePosition:ImagePositionTypeTop spacing:ScreenScale(10)];
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

@end

@implementation ZCShopCartTableFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        UIButton *likeButton = [UITool wordButton:@"猜你喜欢" titleColor:ImportantColor font:MediumFont(18) bgImage:image(@"cainixihuan")];

        [self addSubview:likeButton];
        [self addSubview:self.collectionView];
        
        [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).inset(ScreenScale(8));
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(ScreenScale(49));
            make.left.right.bottom.equalTo(self);
        }];
        
        
        [self performSelector:@selector(update) withObject:nil afterDelay:3.f];
    }
    return self;
}


- (void)update {
    self.dataArray = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
//    self.dataArray = @[@"",@"",@""];

    [self.collectionView reloadData];
    
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^(void){
        self.height = self.collectionView.collectionViewLayout.collectionViewContentSize.height + ScreenScale(49);
        NSLog(@"layoutH:%f--%f", self.collectionView.collectionViewLayout.collectionViewContentSize.height,self.collectionView.contentSize.height);
        [(UITableView*)self.superview reloadData];
    });
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCShopCartGuessLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCShopCartGuessLikeCell class]) forIndexPath:indexPath];
    
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
//        _layout.estimatedItemSize = CGSizeMake(width, width+ScreenScale(81));
        _layout.itemSize = CGSizeMake(width, width+ScreenScale(100));
        _layout.sectionInset = UIEdgeInsetsMake(0, ScreenScale(12), ScreenScale(10), ScreenScale(12));
        _layout.minimumInteritemSpacing = ScreenScale(12);
        _layout.minimumLineSpacing = ScreenScale(12);
    }
    return _layout;
}
@end



