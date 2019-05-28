//
//  ZC_HF_CollectionCycleHeader.m
//  HFLife
//
//  Created by zchao on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZC_HF_CollectionCycleHeader.h"
#import "SDCycleScrollView.h"
#import "ZCHeaderCategoryCell.h"
#import "ZC_HF_ShopClassifyVC.h"
#import "ShopTabbarViewController.h"

@interface ZC_HF_CollectionCycleHeader ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) SDCycleScrollView *cycleView;

@property(nonatomic, strong) UILabel *pageIndexLabel;
@property(nonatomic, strong) UIView *collectionBgView;
@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ZC_HF_CollectionCycleHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cycleView];
        [self.cycleView addSubview:self.pageIndexLabel];
        [self addSubview:self.collectionBgView];
        [self.collectionBgView addSubview:self.collectionView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(ScreenScale(10), ScreenScale(10), ScreenScale(9), ScreenScale(10)));
        }];
        
        [self.pageIndexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.cycleView).inset(ScreenScale(12));
            make.bottom.equalTo(self.collectionBgView.mas_top).offset(-ScreenScale(5));
            make.size.mas_equalTo(CGSizeMake(ScreenScale(32), ScreenScale(16)));
        }];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.classList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCHeaderCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCHeaderCategoryCell class]) forIndexPath:indexPath];
    ZCShopHomeClassModel *model = self.classList[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ShopTabbarViewController *tabBarVC =[self tabBarController];
    tabBarVC.selectedIndex = 1;
    ZC_HF_ShopClassifyVC *classifyVC = (ZC_HF_ShopClassifyVC *)[(BaseNavigationController*)tabBarVC.viewControllers[1] topViewController];
    [classifyVC selectedIndex:indexPath.row+1];
    

}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    self.pageIndexLabel.text = [NSString stringWithFormat:@"%ld/%ld", index+1, self.bannerList.count];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    ZCShopHomeBannerModel *model = self.bannerList[index];
    
//    ZCShopWebViewController *webVC = [ZCShopWebViewController alloc] initWithPath:<#(nonnull NSString *)#> parameters:<#(nullable NSDictionary *)#>
    
    
}


- (void)setBannerList:(NSArray<__kindof ZCShopHomeBannerModel *> *)bannerList {
    _bannerList = bannerList.copy;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (ZCShopHomeBannerModel *item in self.bannerList) {
        [tempArray addObject:item.mobile_banner_image];
    }
    self.cycleView.imageURLStringsGroup = tempArray;
    self.pageIndexLabel.text = [NSString stringWithFormat:@"1/%ld", self.bannerList.count];
}


- (void)setClassList:(NSArray<__kindof ZCShopHomeClassModel *> *)classList {
    _classList = classList;
    
    [self.collectionView reloadData];
}

- (SDCycleScrollView *)cycleView {
    if (!_cycleView) {
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(240)) delegate:self placeholderImage:image(@"banner")];
        _cycleView.localizationImageNamesGroup = @[image(@"banner"),image(@"banner")];
        _cycleView.backgroundColor = [UIColor whiteColor];
    }
    return _cycleView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat width = floorf((SCREEN_WIDTH-ScreenScale(20))/5);
        CGFloat height = floorf(ScreenScale(132)/2);//151-top-bottom
        layout.itemSize = CGSizeMake(width, height);
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ZCHeaderCategoryCell class] forCellWithReuseIdentifier:NSStringFromClass([ZCHeaderCategoryCell class])];
    }
    return _collectionView;
}

- (UIView *)collectionBgView {
    if (!_collectionBgView) {
        _collectionBgView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenScale(214), SCREEN_WIDTH, ScreenScale(151))];
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:_collectionBgView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(ScreenScale(23), ScreenScale(23))];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        _collectionBgView.layer.mask = shape;
        _collectionBgView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionBgView;
}



- (UILabel *)pageIndexLabel {
    if (!_pageIndexLabel) {
        _pageIndexLabel = [UITool labelWithText:nil textColor:ImportantColor font:SystemFont(12) alignment:NSTextAlignmentCenter numberofLines:0 backgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4]];
        _pageIndexLabel.layer.cornerRadius = ScreenScale(8);
        _pageIndexLabel.clipsToBounds = YES;
    }
    return _pageIndexLabel;
}

- (ShopTabbarViewController *)tabBarController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:NSClassFromString(@"ShopTabbarViewController")]) {
            return (ShopTabbarViewController*)nextResponder;
        }
    }
    return nil;
}


@end



@interface ZC_HF_CollectionWordsHeader ()

@property(nonatomic, strong) UILabel *titleLable;

@end
@implementation ZC_HF_CollectionWordsHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLable];
        self.backgroundColor = [UIColor clearColor];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(ScreenScale(12));
        }];
    }
    return self;
}


- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UITool labelWithTextColor:ImportantColor font:MediumFont(18)];
        _titleLable.text = @"专属推荐";
    }
    return _titleLable;
}

@end



