//
//  ZC_HF_ShopHomeVC.m
//  HFLife
//
//  Created by zchao on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "ZC_HF_ShopHomeVC.h"
#import "ZC_HF_ShopHomeSearchButton.h"
#import "ZC_HF_HomeRushPurchaseCell.h"
#import "XPCollectionViewWaterfallFlowLayout.h"
#import "ZC_HF_CollectionCycleHeader.h"

@interface ZC_HF_ShopHomeVC ()<XPCollectionViewWaterfallFlowLayoutDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic ,strong) baseCollectionView *collectionView;
@property (nonatomic ,strong) XPCollectionViewWaterfallFlowLayout *layout;
@end

@implementation ZC_HF_ShopHomeVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
}



- (void)setupNavBar {
    [super setupNavBar];
    
    self.customNavBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    [self.customNavBar wr_setBackgroundAlpha:0.f];
    [self.customNavBar wr_setRightButtonWithImage:image(@"shop_news")];
    
    ZC_HF_ShopHomeSearchButton *searchBtn = [[ZC_HF_ShopHomeSearchButton alloc] initWithFrame:CGRectMake(ScreenScale(12), self.navBarHeight-28-8, ScreenScale(300), 28 )];
    [self.customNavBar addSubview:searchBtn];
}

#pragma mark - event response

#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource

/// Return per section's column number(must be greater than 0).
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout numberOfColumnInSection:(NSInteger)section {
    return 1;
}
/// Return per item's height
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout itemWidth:(CGFloat)width
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    else if (section == 3) {
        return 1;
    }else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

/// header footer View
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            ZC_HF_CollectionCycleHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([ZC_HF_CollectionCycleHeader class]) forIndexPath:indexPath];
            return header;
        }else {
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([ZC_HF_CollectionWordsHeader class]) forIndexPath:indexPath];
        }

    }else {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        return footer;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZC_HF_HomeRushPurchaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZC_HF_HomeRushPurchaseCell class]) forIndexPath:indexPath];
    return cell;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout referenceHeightForFooterInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout referenceHeightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return ScreenScale(365);
    }else {
        return ScreenScale(40);
    }
}


#pragma mark - getters and setters
- (baseCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[baseCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ZC_HF_HomeRushPurchaseCell class] forCellWithReuseIdentifier:NSStringFromClass([ZC_HF_HomeRushPurchaseCell class])];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        
        [_collectionView registerClass:[ZC_HF_CollectionCycleHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ZC_HF_CollectionCycleHeader class])];
        
        [_collectionView registerClass:[ZC_HF_CollectionWordsHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ZC_HF_CollectionWordsHeader class])];
        
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _collectionView;
}

- (XPCollectionViewWaterfallFlowLayout *)layout {
    if (!_layout) {
        _layout = [[XPCollectionViewWaterfallFlowLayout alloc] init];
        _layout.sectionHeadersPinToVisibleBounds = NO;//头部视图不悬停
        _layout.dataSource = self;//设置数据源代理
    }
    return _layout;
}

#pragma mark - private
@end
