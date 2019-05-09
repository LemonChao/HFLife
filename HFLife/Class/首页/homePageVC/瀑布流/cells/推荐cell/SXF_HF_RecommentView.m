//
//  SXF_HF_RecommentView.m
//  HFLife
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_RecommentView.h"
#import "SXF_HF_RecommentCollectionCell.h"
#import "LWDPageControl.h"
@interface SXF_HF_RecommentView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic ,strong) LWDPageControl *pageControl;
@property (nonatomic , assign) NSInteger nums;//个数
@property (nonatomic, assign) CGFloat itemWidth;
@end


@implementation SXF_HF_RecommentView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    if (self.pageControl) {
        [self.pageControl removeFromSuperview];
        self.pageControl = nil;
    }
    self.nums = _dataSource.count;
    self.pageControl.numberOfPages = self.nums;
    [self addPageControl];
    
    
    [self.collectionView reloadData];
}
- (void) addPageControl{
    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self);
        make.top.mas_equalTo(self.collectionView.mas_bottom);
        make.bottom.mas_equalTo(self.collectionView.mas_bottom).offset(0);
    }];
    self.pageControl.backgroundColor = [UIColor whiteColor];
}

- (void) addChildrenViews{
    [self addSubview:self.collectionView];
    self.layout.itemSize = CGSizeMake(ScreenScale(275), ScreenScale(175));
    self.itemWidth = self.layout.itemSize.width;
    self.collectionView.contentInset = UIEdgeInsetsMake(0.0, ScreenScale(12.0), 0.0, ScreenScale(12.0));
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SXF_HF_RecommentCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SXF_HF_RecommentCollectionCell class]) forIndexPath:indexPath];
    
    
    return cell;
}

- (void)currentPageChanged:(LWDPageControl *)pageControl{
    //点击小点
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = self.itemWidth;
    
    int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (currentPage != self.pageControl.currentPage) {
        self.pageControl.currentPage = currentPage;
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat pageWidth = self.itemWidth;
    
    int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    
    self.pageControl.currentPage = currentPage;
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-ScreenScale(15));
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self);
        make.top.mas_equalTo(self.collectionView.mas_bottom);
        make.bottom.mas_equalTo(self.collectionView.mas_bottom).offset(ScreenScale(5));
    }];
    self.pageControl.backgroundColor = [UIColor whiteColor];
}




- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = NO;//整页滚动
        [_collectionView registerClass:[SXF_HF_RecommentCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([SXF_HF_RecommentCollectionCell class])];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    
    return _collectionView;
}
- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}

- (LWDPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[LWDPageControl alloc] initWithFrame:CGRectMake(0, ScreenScale(100 - 80), SCREEN_WIDTH, 15) indicatorMargin:7.f indicatorWidth:6.f currentIndicatorWidth:6.f indicatorHeight:6];
        _pageControl.numberOfPages = self.nums;
        _pageControl.currentPageIndicatorColor = HEX_COLOR(0xCA1400);
        _pageControl.pageIndicatorColor = HEX_COLOR(0xCA1400);
        [_pageControl addTarget:self action:@selector(currentPageChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}
@end
