//
//  TableHeaderView.m
//  HanPay
//
//  Created by mac on 2019/2/16.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "TableHeaderView.h"
#import "WaimaiCategoryCell.h"

@interface TableHeaderView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

static NSString *cellid = @"WaimaiCategoryCell_id";

@implementation TableHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self.collectionView registerClass:[WaimaiCategoryCell class] forCellWithReuseIdentifier:cellid];
    NSLog(@"collection:%@", self.collectionView);
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WaimaiCategoryCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellid];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaimaiCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    
    return cell;
}
@end
