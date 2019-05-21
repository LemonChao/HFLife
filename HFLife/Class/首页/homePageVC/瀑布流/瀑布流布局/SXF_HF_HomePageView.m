//
//  collectionFlowLyoutView.m
//  News
//
//  Created by 史小峰 on 2019/5/8.
//

#import "SXF_HF_HomePageView.h"
#import "XPCollectionViewWaterfallFlowLayout.h"
#import "SXF_HF_CollectionViewCell.h"
#import "cycleScrollCell.h"
#import "SXF_HF_ItemsViewCell.h"
#import "SXF_HF_HeadlineCell1.h"
#import "SXF_HF_HeadlineCell2.h"
#import "SXF_HF_RecommentCell.h"
#import "CollectionReusableView.h"
#import "SXF_HF_HomePageTableHeader.h"
@interface SXF_HF_HomePageView()<XPCollectionViewWaterfallFlowLayoutDataSource,
UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic ,strong) baseCollectionView *collectionView;
@property (nonatomic ,strong) XPCollectionViewWaterfallFlowLayout *layout;
//@property (nonatomic ,strong)NSMutableArray<NSMutableArray<NSNumber *> *> *dataSource;
@property (nonatomic, strong)SXF_HF_HomePageTableHeader *tableHeader;


@property (nonatomic, strong)NSArray *navModelsArr;
@property (nonatomic, strong)NSArray *bannerModelsArr;
@property (nonatomic, strong)NSArray *activityModelsArr;


@property (nonatomic, strong)NSArray *hotNewsModelsArr;
@property (nonatomic, strong)NSArray *noHotNewsModelArr;
@end


@implementation SXF_HF_HomePageView
{
    NSArray *_titleArr;
    UILabel *_refreshLb;
}
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
    _titleArr = @[@"", @"活动推荐",@"汉富头条",  @""];
    
    //初始化 数据源
    
    
    
    //设置数据源
//    self.dataSource = [NSMutableArray array];
//    for (int i=0; i<10; i++) {
//        NSMutableArray<NSNumber *> *section = [NSMutableArray array];
//        for (int j=0; j<10; j++) {
//            CGFloat height = arc4random_uniform(100) + 30.0;
//            [section addObject:@(height)];
//        }
//        [_dataSource addObject:section];
//    }
    
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(290))];
//    headerView.backgroundColor = [UIColor yellowColor];
    //设置内边距 需要设置第一分区内边距为 UIEdgeInsetsMake(290, 0.0, 0.0, 0.0);
    
    //不能设置 self.collectionView.contentInset = UIEdgeInsetsMake(290, 0.0, 0.0, 0.0);
    

//    [self.collectionView addSubview:self.tableHeader];
    
    WEAK(weakSelf);
    UIView *bgView = [[UIView alloc] initWithFrame:self.collectionView.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundView = bgView;
    [bgView addSubview:self.tableHeader];
    _refreshLb =
    UILabel.creat()
    .setFontSize(13)
    .setTextColor([UIColor redColor])
    .setText(self.collectionView.header.stateLabel.text)
    .setTextAligement(NSTextAlignmentCenter)
    .setFrame(CGRectMake(0, CGRectGetMaxY(self.tableHeader.frame), SCREEN_WIDTH, 40));
    //下拉刷新
    [bgView addSubview:_refreshLb];
    self.collectionView.header.stateLabel.hidden = YES;
    self.collectionView.refreshHeaderBlock = ^{
        NSLog(@"collection下拉");
        !weakSelf.refreshDataCallBack ? : weakSelf.refreshDataCallBack(weakSelf.collectionView.page);
    };
    //上拉加载
    self.collectionView.refreshFooterBlock = ^{
        NSLog(@"collection上拉");
        !weakSelf.refreshDataCallBack ? : weakSelf.refreshDataCallBack(weakSelf.collectionView.page);
    };
    
    //分区头点击d事件
    self.tableHeader.selectedHeaderBtn = ^(NSInteger index) {
        !weakSelf.selectedHeaderBtnBlock ? : weakSelf.selectedHeaderBtnBlock(index);
    };
    
    //扫一扫栏目出现的时机
    self.tableHeader.appearCallback = ^(CGFloat alpha, BOOL isAppear) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenSearchBar" object:@(alpha)];
    };
    
}

- (void)setPausePlay:(BOOL)pausePlay{
    _pausePlay = pausePlay;
    //获取cell
    cycleScrollCell *cell = (cycleScrollCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.pausePlay = pausePlay;
}


- (void) endRefreshData{
    [self.collectionView endRefreshData];
}
//集合点击事件
- (void) collectionViewSelection:(NSInteger )section itemIndex:(NSInteger)index{
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:index inSection:section];
    !self.selectedItem ? : self.selectedItem(indexP);
}

- (void)setDataSourceDict:(NSDictionary *)dataSourceDict{
    _dataSourceDict = dataSourceDict;
    
    self.navModelsArr = dataSourceDict[@"nav"];
    self.bannerModelsArr = dataSourceDict[@"banner"];
    self.activityModelsArr = dataSourceDict[@"activity"];
    
    //解析得到的数据
    
    [self.collectionView reloadData];
    
}

- (void)setNewsListModelArr:(NSArray *)newsListModelArr{
    _newsListModelArr = newsListModelArr;
    //刷新3 4 分区
    [self chectHotNews];
    
//    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, 2)]];
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, 2)]];
        [self.collectionView reloadData];
    });
//    [self.collectionView reloadData];
}

//找到hot 新闻
- (void) chectHotNews{
    NSMutableArray *hotArrM = [NSMutableArray array];
    NSMutableArray *newsArrM = [NSMutableArray array];
    
    for (homeListModel *model in self.newsListModelArr  ) {
        if ([model.tuiswitch integerValue] == 1) {
            //hot
            [hotArrM addObject:model];
        }else{
            [newsArrM addObject:model];
        }
    }
    
    self.hotNewsModelsArr = hotArrM;
    self.noHotNewsModelArr = newsArrM;
}



#pragma mark <UICollectionViewDataSource>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger mySection;
    //点击事件
    if (indexPath.section == 0) {
        mySection = 1;
    }else if (indexPath.section == 2) {
        mySection = 4;
    }else if (indexPath.section == 3){
        mySection = 5;
    }
    [self collectionViewSelection:mySection itemIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _titleArr.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return self.hotNewsModelsArr.count;//热点新闻
    }else{
        return self.newsListModelArr.count;
    }
//    return [self.dataSource objectAtIndex:section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WEAK(weakSelf);
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SXF_HF_ItemsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SXF_HF_ItemsViewCell class]) forIndexPath:indexPath];
            cell.selectItemBlock = ^(NSInteger index) {
                [weakSelf collectionViewSelection:0 itemIndex:index];
            };
            cell.itemDataSourceArr = self.navModelsArr;
            return cell;
        }else if (indexPath.row == 1) {
            SXF_HF_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SXF_HF_CollectionViewCell class]) forIndexPath:indexPath];
            return cell;
        }else if (indexPath.row == 2) {
            cycleScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([cycleScrollCell class]) forIndexPath:indexPath];
            cell.modelArr = self.bannerModelsArr;
            cell.selectItemBlock = ^(NSInteger index) {
                [weakSelf collectionViewSelection:2 itemIndex:index];
            };
            return cell;
        }
    }else if (indexPath.section == 1){
        SXF_HF_RecommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SXF_HF_RecommentCell class]) forIndexPath:indexPath];
        cell.selectedItem = ^(NSInteger index) {
            [weakSelf collectionViewSelection:3 itemIndex:index];;
        };
        cell.dataSourceArr = self.activityModelsArr;
        return cell;
    }else if (indexPath.section == 2){
        SXF_HF_HeadlineCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SXF_HF_HeadlineCell1 class]) forIndexPath:indexPath];
        [cell setDataForCell:self.hotNewsModelsArr[indexPath.row]];
        return cell;
    }else if (indexPath.section == 3){
        SXF_HF_HeadlineCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SXF_HF_HeadlineCell2 class]) forIndexPath:indexPath];
        [cell setDataForCell:self.noHotNewsModelArr[indexPath.row]];
        return cell;
    }
    SXF_HF_CollectionViewCell *cell = (SXF_HF_CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SXF_HF_CollectionViewCell class]) forIndexPath:indexPath];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = (kind==UICollectionElementKindSectionHeader) ? headerReuseIdentifier : footerReuseIdentifier;
    CollectionReusableView *view = (CollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    view.backgroundColor = [UIColor whiteColor];
    view.textLabel.text = _titleArr[indexPath.section];
    if (kind == UICollectionElementKindSectionFooter) {
        view.hidden = YES;
    }else{
        if (indexPath.section == 0 || indexPath.section == 3) {
            view.hidden = YES;
        }else{
            view.hidden = NO;
        }
    }
    
    return view;
}

#pragma mark <XPCollectionViewWaterfallFlowLayoutDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout numberOfColumnInSection:(NSInteger)section {
    //在每个分区 一排几个
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 1;
    }else if (section == 2){
        return 2;
    }
    return  1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    //item的高
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return ScreenScale(170  / 2 + ScreenScale(10));
        }else if(indexPath.row == 1){
            return ScreenScale(80);
        }
        return ScreenScale(120);
    }else if (indexPath.section ==1){
        return ScreenScale(180);
    }else if (indexPath.section == 2) {
        if (indexPath.row > 4) {
            return 100;
        }
        return [UIScreen mainScreen].bounds.size.width / 2;
    }else if (indexPath.section == 3){
        return ScreenScale(112);
    }else{
        return 0;
    }
//    NSNumber *number = self.dataSource[indexPath.section][indexPath.item];
//    return [number floatValue];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout insetForSectionAtIndex:(NSInteger)section {
    //每个分区的上左下右间距
    if (section == 0) {
        return UIEdgeInsetsMake(ScreenScale(290) , 0.0, 10.0, 0.0);
    }else if (section == 1){
        return UIEdgeInsetsMake(ScreenScale(6), 0.0, ScreenScale(6), 0.0);
    }
    else if (section == 2){
        return UIEdgeInsetsMake(0.0, ScreenScale(6), 0.0, ScreenScale(6));
    }
    return UIEdgeInsetsMake(ScreenScale(0), 0.0, 0.0, 0.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    //cell最小行间距
    if (section == 0) {
        return 0.0;
    }
    if (section == 2 || section == 3) {
        return 0.0;
    }
    return ScreenScale(12);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    //分区内的最小列间距
    if (section == 0 || section == 2 || section == 3) {
        return 0.0;
    }
    return ScreenScale(10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout referenceHeightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 3) {
        return 0.01;
    }
    return 40.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout referenceHeightForFooterInSection:(NSInteger)section {
    return 0.01;;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSIndexSet *set  = [NSIndexSet indexSetWithIndex:0];
//    [self.collectionView reloadData];
    
    self.tableHeader.frame = CGRectMake(0, - (scrollView.contentOffset.y > 0 ? scrollView.contentOffset.y : 0), self.tableHeader.bounds.size.width, self.tableHeader.bounds.size.height);
    
    if (scrollView.contentOffset.y > 50) {
        _refreshLb.hidden = YES;
    }else{
        _refreshLb.hidden =  NO;
        _refreshLb.text = self.collectionView.header.stateLabel.text;
    }
    
    
    //s隐藏扫一扫时机
    self.tableHeader.scrollY = self.collectionView.contentOffset.y;
    
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[baseCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
        [_collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerReuseIdentifier];
        
        [_collectionView registerClass:[SXF_HF_CollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SXF_HF_CollectionViewCell class])];
        
        [_collectionView registerClass:[cycleScrollCell class] forCellWithReuseIdentifier:NSStringFromClass([cycleScrollCell class])];
        
        [_collectionView registerClass:[SXF_HF_ItemsViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SXF_HF_ItemsViewCell class])];
        
        
        [_collectionView registerClass:[SXF_HF_HeadlineCell1 class] forCellWithReuseIdentifier:NSStringFromClass([SXF_HF_HeadlineCell1 class])];
        
        [_collectionView registerClass:[SXF_HF_HeadlineCell2 class] forCellWithReuseIdentifier:NSStringFromClass([SXF_HF_HeadlineCell2 class])];
        
        [_collectionView registerClass:[SXF_HF_RecommentCell class] forCellWithReuseIdentifier:NSStringFromClass([SXF_HF_RecommentCell class])];
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






//判断有几行
- (NSInteger)getItemCount{
    NSInteger rowNum = 4;//每行4 个
    if (self.bannerModelsArr.count <= rowNum) {
        return 1;
    }else if (self.bannerModelsArr.count % rowNum == 0) {
        return self.bannerModelsArr.count / rowNum;
    }else{
        return self.bannerModelsArr.count / rowNum + 1;
    }
    
}


@end
