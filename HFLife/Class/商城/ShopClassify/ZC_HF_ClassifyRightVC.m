//
//  ZC_HF_ClassifyRightVC.m
//  HFLife
//
//  Created by zchao on 2019/5/13.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZC_HF_ClassifyRightVC.h"
#import "ZCShopClassifyRightCell.h"
#import "ZCClassifyRightHeaderView.h"

@interface ZC_HF_ClassifyRightVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *rightCollection;

@end

@implementation ZC_HF_ClassifyRightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.rightCollection];
    
    [self.rightCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.customNavBar.mas_bottom);
    }];
}
#pragma mark - life cycle

#pragma mark - event response

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        ZCClassifyRightHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([ZCClassifyRightHeaderView class]) forIndexPath:indexPath];
        ZCShopClassifyListModel *model = self.dataArray[indexPath.section];
        model.indexPath = indexPath;
        header.model = model;
        return header;
    }else {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ZCShopClassifyListModel *sectionModel = self.dataArray[section];
    return sectionModel.select ? sectionModel.child.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCShopClassifyRightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCShopClassifyRightCell class]) forIndexPath:indexPath];
    ZCShopClassifyListModel *sectionModel = self.dataArray[indexPath.section];
    ZCShopClassifyListModel *childModel = sectionModel.child[indexPath.row];
    childModel.indexPath = indexPath;
    cell.model = childModel;
    return cell;
}

#pragma mark - getters and setters

- (void)setDataArray:(NSArray<__kindof ZCShopClassifyListModel *> *)dataArray {
    if (_dataArray == dataArray) return;
    _dataArray = dataArray;
    [self.rightCollection reloadData];
//    [self.rightCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
//    [self.rightCollection scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (UICollectionView *)rightCollection {
    if (!_rightCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (SCREEN_WIDTH-ScreenScale(128)) / 3;
        layout.sectionInset = UIEdgeInsetsMake(ScreenScale(10), ScreenScale(22), ScreenScale(10), ScreenScale(22));
        layout.itemSize = CGSizeMake(width, ScreenScale(44));
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing  = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        layout.footerReferenceSize = CGSizeZero;
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH-ScreenScale(84), ScreenScale(44));
        
        _rightCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _rightCollection.backgroundColor = [UIColor whiteColor];
        _rightCollection.dataSource = self;
        _rightCollection.delegate = self;
        _rightCollection.showsVerticalScrollIndicator = NO;
        _rightCollection.showsHorizontalScrollIndicator = NO;
        [_rightCollection registerClass:[ZCShopClassifyRightCell class] forCellWithReuseIdentifier:NSStringFromClass([ZCShopClassifyRightCell class])];
        
        [_rightCollection registerClass:[ZCClassifyRightHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ZCClassifyRightHeaderView class])];
        [_rightCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    }
    return _rightCollection;
}
#pragma mark - private

@end
