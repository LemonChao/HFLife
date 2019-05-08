//
//  SXF_HF_RecommentView.m
//  HFLife
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_RecommentView.h"
#import "SXF_HF_RecommentCollectionCell.h"

@interface SXF_HF_RecommentView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
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
- (void) addChildrenViews{
    [self addSubview:self.collectionView];
    self.layout.itemSize = CGSizeMake(ScreenScale(275), ScreenScale(175));
    self.collectionView.contentInset = UIEdgeInsetsMake(0.0, ScreenScale(12.0), 0.0, ScreenScale(12.0));
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SXF_HF_RecommentCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SXF_HF_RecommentCollectionCell class]) forIndexPath:indexPath];
    
    
    return cell;
}





- (void)layoutSubviews{
    [super layoutSubviews];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-ScreenScale(10));
    }];
}




- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;//整页滚动
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
@end
