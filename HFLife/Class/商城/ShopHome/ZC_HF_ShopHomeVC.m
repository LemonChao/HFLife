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
#import "ZCHomeDiscountCell.h"
#import "XPCollectionViewWaterfallFlowLayout.h"
#import "ZC_HF_CollectionCycleHeader.h"
#import "ZCHomeRecommendCell.h"
#import "ZCExclusiveRecommendCell.h"

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
    
    self.customNavBar.barBackgroundColor = [RGBA(202, 20, 0, 1) colorWithAlphaComponent:0];
    self.customNavBar.backgroundColor = [UIColor clearColor];
    [self.customNavBar wr_setRightButtonWithImage:image(@"shop_news")];
    
    ZC_HF_ShopHomeSearchButton *searchBtn = [[ZC_HF_ShopHomeSearchButton alloc] initWithFrame:CGRectMake(ScreenScale(12), self.navBarHeight-28-8, ScreenScale(300), 28 )];
    [self.customNavBar addSubview:searchBtn];
}

#pragma mark - event response

#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource

/// Return per section's column number(must be greater than 0).
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout numberOfColumnInSection:(NSInteger)section {
    if (section == 4) {
        return 2;
    }
    return 1;
}
/// Return per item's height
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout itemWidth:(CGFloat)width
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return ScreenScale(194);
    }else if (indexPath.section == 2) {
        return ScreenScale(334);
    }else if (indexPath.section == 3) {
        return ScreenScale(160);
    }else if (indexPath.section == 4) {
        return ScreenScale(273);
    }
    return 0;

}

/// Column spacing between columns
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 4) {
        return ScreenScale(11);
    }
    return 0.f;
}
/// The spacing between rows and rows
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 4) {
        return ScreenScale(11);
    }
    
    return 0.f;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout insetForSectionAtIndex:(NSInteger)section {
    if (section == 4) {
        return UIEdgeInsetsMake(0, ScreenScale(11), 0, ScreenScale(11));
    }
    return UIEdgeInsetsZero;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    else if (section == 4) {
        return 6;
    }else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

/// header footer View
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            ZC_HF_CollectionCycleHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([ZC_HF_CollectionCycleHeader class]) forIndexPath:indexPath];
            return header;
        }else if (indexPath.section == 1) {
            ZC_HF_CollectionTimerHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([ZC_HF_CollectionTimerHeader class]) forIndexPath:indexPath];
            return header;
        }
        else {
            return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([ZC_HF_CollectionWordsHeader class]) forIndexPath:indexPath];
        }

    }else {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        return footer;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        ZCHomeDiscountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCHomeDiscountCell class]) forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 2) {
        ZC_HF_HomeRushPurchaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZC_HF_HomeRushPurchaseCell class]) forIndexPath:indexPath];
        return cell;

    }
    else if (indexPath.section == 3) {
        ZCHomeRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCHomeRecommendCell class]) forIndexPath:indexPath];
        return cell;

    }
    else if (indexPath.section == 4) {
        ZCExclusiveRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCExclusiveRecommendCell class]) forIndexPath:indexPath];
        
        return cell;
    }
    
    return nil;
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


#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;

    if (offsetY < ScreenScale(214)-NavBarHeight*2 || offsetY == 0) {
        self.customNavBar.barBackgroundColor = [RGBA(202, 20, 0, 1) colorWithAlphaComponent:0];

    }else {
        CGFloat alpha = (offsetY+NavBarHeight*2-ScreenScale(214)) / NavBarHeight;
        if (alpha > 1) {
            alpha = 1;
        }
        self.customNavBar.barBackgroundColor = [RGBA(202, 20, 0, 1) colorWithAlphaComponent:0.2*alpha];
    }
}


#pragma mark - getters and setters
- (baseCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[baseCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TabBarHeight) collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = BackGroundColor;
        
        [_collectionView registerClass:[ZCHomeDiscountCell class] forCellWithReuseIdentifier:NSStringFromClass([ZCHomeDiscountCell class])];
        
        [_collectionView registerClass:[ZC_HF_HomeRushPurchaseCell class] forCellWithReuseIdentifier:NSStringFromClass([ZC_HF_HomeRushPurchaseCell class])];
        
        [_collectionView registerClass:[ZCHomeRecommendCell class] forCellWithReuseIdentifier:NSStringFromClass([ZCHomeRecommendCell class])];

        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        
        [_collectionView registerClass:[ZCExclusiveRecommendCell class] forCellWithReuseIdentifier:NSStringFromClass([ZCExclusiveRecommendCell class])];
        
        [_collectionView registerClass:[ZC_HF_CollectionCycleHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ZC_HF_CollectionCycleHeader class])];
        
        [_collectionView registerClass:[ZC_HF_CollectionWordsHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ZC_HF_CollectionWordsHeader class])];
        [_collectionView registerClass:[ZC_HF_CollectionTimerHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ZC_HF_CollectionTimerHeader class])];

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
