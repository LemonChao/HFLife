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

@interface ZC_HF_CollectionCycleHeader ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) SDCycleScrollView *cycleView;
@property(nonatomic, strong) UIView *collectionBgView;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, copy) NSArray *dataArray;
@end

@implementation ZC_HF_CollectionCycleHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cycleView];
        [self addSubview:self.collectionBgView];
        [self.collectionBgView addSubview:self.collectionView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(ScreenScale(10), ScreenScale(10), ScreenScale(9), ScreenScale(10)));
        }];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCHeaderCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCHeaderCategoryCell class]) forIndexPath:indexPath];
    cell.params = self.dataArray[indexPath.row];
    return cell;
}


- (void)setBannerList:(NSArray<__kindof ZCShopHomeBannerModel *> *)bannerList {
    _bannerList = bannerList.copy;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (ZCShopHomeBannerModel *item in self.bannerList) {
        [tempArray addObject:item.mobile_banner_image];
    }
    self.cycleView.imageURLStringsGroup = tempArray;
    
}


- (SDCycleScrollView *)cycleView {
    if (!_cycleView) {
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(240)) delegate:self placeholderImage:image(@"banner")];
        _cycleView.localizationImageNamesGroup = @[image(@"banner"),image(@"banner")];
        _cycleView.backgroundColor = [UIColor whiteColor];
        _cycleView.showPageControl = YES;
        _cycleView.pageControlBottomOffset = ScreenScale(23);
        _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleView.currentPageDotColor = GeneralRedColor;
    }
    return _cycleView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat width = floorf((SCREEN_WIDTH-ScreenScale(20))/5);
        CGFloat height = floorf(ScreenScale(132)/2);//151-top-bottom
        layout.itemSize = CGSizeMake(width, height);
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
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

- (NSArray *)dataArray {
    if (!_dataArray) {
        NSMutableArray *array = [NSMutableArray array];
        
        NSArray *titls = @[@"珠宝手表",@"家具家装",@"家用电器",@"汽车用品",@"食品饮料",@"礼品箱包",@"厨房用具",@"母婴用品",@"服饰鞋帽",@"运动健身"];
        NSArray *images = @[@"zhubaoshoubiao",@"jiajujiazhuang",@"jiayongdianqi",@"qicheyongpin",@"shipinyinliao",@"lipinxiangbao",@"chufangyongpin",@"muyingyongpin",@"fushixiemao",@"yundongjianshen"];
        for (int i = 0; i < titls.count; i++) {
            NSDictionary *dic = @{@"title":titls[i],@"imageName":images[i]};
            [array addObject:dic];
        }
        _dataArray = array.copy;
    }
    return _dataArray;
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



