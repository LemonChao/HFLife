//
//  ZC_HF_CollectionCycleHeader.m
//  HFLife
//
//  Created by zchao on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZC_HF_CollectionCycleHeader.h"
#import "SDCycleScrollView.h"

@interface ZC_HF_CollectionCycleHeader ()<SDCycleScrollViewDelegate>

@property(nonatomic, strong) SDCycleScrollView *cycleView;
@property(nonatomic, strong) UIView *collectionBgView;
@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ZC_HF_CollectionCycleHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cycleView];
        
        
        [self addSubview:self.collectionView];
    }
    return self;
}

- (SDCycleScrollView *)cycleView {
    if (!_cycleView) {
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:image(@"banner")];
    }
    return _cycleView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;
}

- (UIView *)collectionBgView {
    if (!_collectionBgView) {
        _collectionBgView = [UITool viewWithColor:[UIColor whiteColor]];
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 53)];
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:header.frame byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(24.0, 24.0)];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        header.layer.mask = shape;
        header.backgroundColor = [UIColor whiteColor];
    }
    return _collectionBgView;
}

@end




@implementation ZC_HF_CollectionWordsHeader



@end
