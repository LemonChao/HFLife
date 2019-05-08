//
//  collectionFlowLyoutView.m
//  News
//
//  Created by 史小峰 on 2019/5/8.
//

#import "collectionFlowLyoutView.h"
#import "XPCollectionViewWaterfallFlowLayout.h"
#import "CollectionViewCell.h"
#import "cycleScrollCell.h"
#import "CollectionReusableView.h"
#import "SXF_HF_HomePageTableHeader.h"
@interface collectionFlowLyoutView()<XPCollectionViewWaterfallFlowLayoutDataSource,
UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) XPCollectionViewWaterfallFlowLayout *layout;
@property (nonatomic ,strong)NSMutableArray<NSMutableArray<NSNumber *> *> *dataSource;
@property (nonatomic, strong)SXF_HF_HomePageTableHeader *tableHeader;
@end


@implementation collectionFlowLyoutView

static NSString * const reuseIdentifier = @"Cell";
static NSString * const headerReuseIdentifier = @"Header";
static NSString * const footerReuseIdentifier = @"Footer";

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addChildrenViews];
    }
    return self;
}

- (void) addChildrenViews{
    [self addSubview:self.collectionView];
    
    //设置数据源
    self.dataSource = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        NSMutableArray<NSNumber *> *section = [NSMutableArray array];
        for (int j=0; j<10; j++) {
            CGFloat height = arc4random_uniform(100) + 30.0;
            [section addObject:@(height)];
        }
        [_dataSource addObject:section];
    }
    
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(290))];
//    headerView.backgroundColor = [UIColor yellowColor];
    //设置内边距 需要设置第一分区内边距为 UIEdgeInsetsMake(290, 0.0, 0.0, 0.0);
    
    //不能设置 self.collectionView.contentInset = UIEdgeInsetsMake(290, 0.0, 0.0, 0.0);
    

    [self.collectionView addSubview:self.tableHeader];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 3;
    }
    return [self.dataSource objectAtIndex:section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cycleScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([cycleScrollCell class]) forIndexPath:indexPath];
            cell.modelArr = @[@"", @"", @""];
            return cell;
        }
    }
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"{%ld,%ld}", indexPath.section, indexPath.item];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = (kind==UICollectionElementKindSectionHeader) ? headerReuseIdentifier : footerReuseIdentifier;
    CollectionReusableView *view = (CollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    view.textLabel.text = [NSString stringWithFormat:@"%@ %ld", kind, indexPath.section];
    return view;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"第%ld分区--第%ld行", indexPath.section, indexPath.item);
}
#pragma mark <XPCollectionViewWaterfallFlowLayoutDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout numberOfColumnInSection:(NSInteger)section {
    //在每个分区 一排几个
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 2;
    }
    return  MIN(section+1, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    //item的高
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 100;
        }
        return 200;
    }else if (indexPath.section == 1) {
        if (indexPath.row > 4) {
            return 100;
        }
        return [UIScreen mainScreen].bounds.size.width / 2;
    }
    NSNumber *number = self.dataSource[indexPath.section][indexPath.item];
    return [number floatValue];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout insetForSectionAtIndex:(NSInteger)section {
    //每个分区的上左下右间距
    if (section == 0) {
        return UIEdgeInsetsMake(ScreenScale(300), 0.0, 10.0, 0.0);
    }
    return UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    //cell最小行间距
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    //分区内的最小列间距
    if (section == 0) {
        return 0.0;
    }
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout referenceHeightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 40.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout referenceHeightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 40.0;
}


















- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
        [_collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerReuseIdentifier];
        
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        
        [_collectionView registerClass:[cycleScrollCell class] forCellWithReuseIdentifier:NSStringFromClass([cycleScrollCell class])];
        
        _collectionView.backgroundColor = [UIColor grayColor];
    }
    return _collectionView;
}
- (XPCollectionViewWaterfallFlowLayout *)layout{
    if (!_layout) {
        _layout = [[XPCollectionViewWaterfallFlowLayout alloc] init];
        
        // 头部视图悬停
//        XPCollectionViewWaterfallFlowLayout *layout = (XPCollectionViewWaterfallFlowLayout *)self.collectionView.collectionViewLayout;
//        layout.sectionHeadersPinToVisibleBounds = NO;
        
        _layout.sectionHeadersPinToVisibleBounds = NO;//不悬停
        _layout.dataSource = self;//设置数据源代理
    }
    return _layout;
}
- (SXF_HF_HomePageTableHeader *)tableHeader{
    if (!_tableHeader) {
        _tableHeader = [[SXF_HF_HomePageTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(290))];
    }
    return _tableHeader;
}
@end
