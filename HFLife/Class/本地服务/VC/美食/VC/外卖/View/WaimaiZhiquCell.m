//
//  WaimaiZhiquCell.m
//  HanPay
//
//  Created by mac on 2019/2/18.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "WaimaiZhiquCell.h"
#import "WaimaiZhiquCollectionCell.h"

@interface WaimaiZhiquCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(strong,nonatomic) UICollectionView *collectionView;

@end

static NSString *zhiquCollectionCellid = @"WaimaiZhiquCollectionCell.h";

@implementation WaimaiZhiquCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 13, 0, 13));
        }];
    }
    
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaimaiZhiquCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:zhiquCollectionCellid forIndexPath:indexPath];
    return cell;
}



- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(100, 140);
        layout.minimumInteritemSpacing = 10;
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WaimaiZhiquCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:zhiquCollectionCellid];
    }
    return _collectionView;
}


@end
