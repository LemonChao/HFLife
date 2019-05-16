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
#import "ZCShopHomeViewModel.h"



@interface ZC_HF_ShopHomeVC ()<XPCollectionViewWaterfallFlowLayoutDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic ,strong) baseCollectionView *collectionView;
@property(nonatomic ,strong) XPCollectionViewWaterfallFlowLayout *layout;
@property(nonatomic, strong) ZCShopHomeViewModel *viewModel;

@end

@implementation ZC_HF_ShopHomeVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    [self getData:@"1"];
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

- (void)getData:(NSString *)page {
    
    [[self.viewModel.shopRefreshCmd execute:nil] subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) {
            [self.collectionView reloadData];
        }
    }error:^(NSError * _Nullable error) {
        
    }];
}


#pragma mark - UICollectionViewDelegate && UICollectionViewDataSource

/// Return per section's column number(must be greater than 0).
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout numberOfColumnInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}
/// Return per item's height
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout itemWidth:(CGFloat)width
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = self.viewModel.dataArray[indexPath.section];
    if (indexPath.section == 0) {
        ZCShopHomeCellModel *model = array[indexPath.row];
        return model.rowHeight;
    }else {
        ZCExclusiveRecommendModel *model = array[indexPath.row];
        return model.viewHeight+ScreenScale(110);
    }
}

/// Column spacing between columns
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return ScreenScale(11);
    }
    return 0.f;
}
/// The spacing between rows and rows
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return ScreenScale(11);
    }
    
    return 0.f;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout insetForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return UIEdgeInsetsMake(0, ScreenScale(11), 0, ScreenScale(11));
    }
    return UIEdgeInsetsZero;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *sectionArray = self.viewModel.dataArray[section];
    return sectionArray.count;
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


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.viewModel.dataArray.count;
}

/// header footer View
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            ZC_HF_CollectionCycleHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([ZC_HF_CollectionCycleHeader class]) forIndexPath:indexPath];
            header.bannerList = self.viewModel.bannerArray;
            
            return header;
        }
        else {
            ZC_HF_CollectionWordsHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([ZC_HF_CollectionWordsHeader class]) forIndexPath:indexPath];
            
            return header;
        }

    }else {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        return footer;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = self.viewModel.dataArray[indexPath.section];
    
    if (indexPath.section == 0) {
        ZCShopHomeCellModel *model = array[indexPath.row];

        if ([model.title isEqualToString:@"限时折扣"]) {
            ZCHomeDiscountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCHomeDiscountCell class]) forIndexPath:indexPath];
            cell.model = model;
            return cell;

        }else if ([model.title isEqualToString:@"今日必抢"]) {
            ZC_HF_HomeRushPurchaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZC_HF_HomeRushPurchaseCell class]) forIndexPath:indexPath];
            cell.model = model;
            return cell;
        }else if ([model.title isEqualToString:@"新品推荐"]) {
            ZCHomeRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCHomeRecommendCell class]) forIndexPath:indexPath];
            cell.model = model;
           return cell;
        }
        return nil;
    }
    else {
        ZCExclusiveRecommendModel *model = array[indexPath.row];
        ZCExclusiveRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCExclusiveRecommendCell class]) forIndexPath:indexPath];
        cell.model = model;
        return cell;
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
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[ZCHomeDiscountCell class] forCellWithReuseIdentifier:NSStringFromClass([ZCHomeDiscountCell class])];
        
        [_collectionView registerClass:[ZC_HF_HomeRushPurchaseCell class] forCellWithReuseIdentifier:NSStringFromClass([ZC_HF_HomeRushPurchaseCell class])];
        
        [_collectionView registerClass:[ZCHomeRecommendCell class] forCellWithReuseIdentifier:NSStringFromClass([ZCHomeRecommendCell class])];

        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        
        [_collectionView registerClass:[ZCExclusiveRecommendCell class] forCellWithReuseIdentifier:NSStringFromClass([ZCExclusiveRecommendCell class])];
        
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

- (ZCShopHomeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZCShopHomeViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - private
@end
