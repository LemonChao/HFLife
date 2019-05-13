//
//  ZC_HF_ClassifyRightVC.m
//  HFLife
//
//  Created by zchao on 2019/5/13.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZC_HF_ClassifyRightVC.h"
#import "ZCShopClassifyRightCell.h"

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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCShopClassifyRightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCShopClassifyRightCell class]) forIndexPath:indexPath];
    
    return cell;
}


#pragma mark - getters and setters

- (UICollectionView *)rightCollection {
    if (!_rightCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(ScreenScale(10), ScreenScale(22), ScreenScale(10), ScreenScale(22));
        layout.itemSize = CGSizeMake(ScreenScale(55), ScreenScale(85));
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing  = ScreenScale(30);
        _rightCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _rightCollection.backgroundColor = [UIColor whiteColor];
        _rightCollection.dataSource = self;
        _rightCollection.delegate = self;
        _rightCollection.showsVerticalScrollIndicator = NO;
        _rightCollection.showsHorizontalScrollIndicator = NO;
        [_rightCollection registerClass:[ZCShopClassifyRightCell class] forCellWithReuseIdentifier:NSStringFromClass([ZCShopClassifyRightCell class])];
    }
    return _rightCollection;
}
#pragma mark - private


@end
