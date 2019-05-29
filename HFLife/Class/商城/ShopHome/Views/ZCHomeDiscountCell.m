//
//  ZCHomeDiscountCell.m
//  HFLife
//
//  Created by zchao on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCHomeDiscountCell.h"
#import "ZCDisCountCollectionCell.h"

@interface ZCHomeDiscountCell ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UILabel *titleLable;
@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ZCHomeDiscountCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.collectionView];
        
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(ScreenScale(12));
            make.height.mas_equalTo(ScreenScale(40));
        }];

        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLable.mas_bottom);
            make.bottom.right.equalTo(self.contentView);
            make.left.equalTo(self.contentView).inset(ScreenScale(12));
        }];
    }
    return self;
}

- (void)setModel:(ZCShopHomeCellModel *)model {
    _model = model;
    
    self.titleLable.text = model.title;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.cellDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCDisCountCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCDisCountCollectionCell class]) forIndexPath:indexPath];
    ZCShopHomeLimitModel *model = self.model.cellDatas[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCShopHomeLimitModel *model = self.model.cellDatas[indexPath.row];
    ZCShopWebViewController *webVC = [[ZCShopWebViewController alloc] initWithPath:@"productDetail" parameters:@{@"goods_id":model.goods_id}];
    [self.viewController.navigationController pushViewController:webVC animated:YES];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(ScreenScale(120), ScreenScale(194));
        layout.minimumLineSpacing = ScreenScale(11);
        layout.minimumInteritemSpacing = 0.f;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ZCDisCountCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([ZCDisCountCollectionCell class])];
    }
    return _collectionView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UITool labelWithTextColor:ImportantColor font:MediumFont(18)];
    }
    return _titleLable;
}
@end
