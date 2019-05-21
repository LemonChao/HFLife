//
//  myCenterCollectionView.m
//  DeliveryOrder
//
//  Created by mac on 2019/3/9.
//  Copyright © 2019 LeYuWangLuo. All rights reserved.
//

#import "myCenterCollectionView.h"
#import "myCenterCollectionViewCell.h"
@interface myCenterCollectionView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong) UICollectionView *collectionV;
@end
@implementation myCenterCollectionView
{
    NSArray *_titleArr;
    NSArray *_imageArr;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addChilerenViews];
    }
    return self;
}


- (void) addChilerenViews{
    _titleArr = @[@"附近商家", @"生活缴费", @"超级账本", @"VR商城", @"外卖", @"快递查询", @"路印打车", @"火车票机票"];
    _imageArr =  @[@"附近商家", @"生活缴费", @"超级账本", @"VR商城", @"外卖", @"快递查询", @"路印打车", @"火车票"];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - ScreenScale(24)) / 4.0 - 1, ScreenScale(75));
    NSLog(@"%lf ---  %lf", layout.itemSize.width * 4 + ScreenScale(24), SCREEN_WIDTH);
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    [self.collectionV registerClass:[myCenterCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([myCenterCollectionViewCell class])];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.collectionV];
}
- (void)setDataSourceArr:(NSArray *)dataSourceArr{
    _dataSourceArr = dataSourceArr;
    [self.collectionV reloadData];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectionV.frame = self.bounds;
    
    [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(self);
    }];
    
}






- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    myCenterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([myCenterCollectionViewCell class]) forIndexPath:indexPath];
    homeListModel *model = self.dataSourceArr[indexPath.row];
    [cell setTitleForCell:model.title image:URL_IMAGE(model.iconimage)];
//    [cell setTitleForCell:_titleArr[indexPath.row] image:_imageArr[indexPath.row]];
    return cell;
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    !self.selectedItem ? : self.selectedItem(indexPath.row);
}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(ScreenScale((self.bounds.size.width - 24.0)) / 4.0, 150.0 / 2);
//}


@end
