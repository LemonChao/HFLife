//
//  YYB_HF_LocaColumnCollectionCell.m
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_LocaColumnCollectionCell.h"
@interface YYB_HF_LocaColumnCollectionCell()<UICollectionViewDelegate, UICollectionViewDataSource> {
    NSArray *imageNameArray;
    NSArray *titleArray;
}
@property(nonatomic,strong) UICollectionView *collectionView;


@end

@implementation YYB_HF_LocaColumnCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView {
    
    imageNameArray = @[@"icon_ruzhu",@"icon_meishi",@"icon_jiudian",@"icon_shenxian",@"icon_meifa",@"icon_xiuxian",@"icon_jiehun",@"icon_qinzi",@"icon_waimai",@"icon_jiaju",@"icon_youyong",@"icon_yake",@"icon_jiaoyu",@"icon_meirong",@"icon_gengduo"];
    
    titleArray = @[@"商家入驻",@"美食", @"酒店住宿", @"超市生鲜", @"美在中国", @"休闲娱乐", @"结婚摄影", @"亲子乐园", @"外卖", @"家具装修",@"游泳健身",@"医疗牙科",@"教育培训",@"医学美容",@"更多"];
    [self.contentView addSubview:self.collectionView];
    self.collectionView.scrollEnabled = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(ScreenScale(65) * 3);
    }];
}
#pragma mark - collectionView代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imageNameArray.count;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    double width = (self.contentView.width - ScreenScale(10)*6) / 5.0;
    return CGSizeMake(width, ScreenScale(60));
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YYB_HF_LocaColumnCollectionCellItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYB_HF_LocaColumnCollectionCellItem" forIndexPath:indexPath];
    cell.imgView.image = MMGetImage(imageNameArray[indexPath.row]);
    cell.title.text = titleArray[indexPath.row];
    //    cell.backgroundColor = [UIColor redColor];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        double width = (self.contentView.width - ScreenScale(10)*6) / 5.0;
        layout.itemSize = CGSizeMake(width, ScreenScale(60));
        layout.minimumLineSpacing = ScreenScale(5);
        layout.minimumInteritemSpacing = ScreenScale(5);
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //        layout.sectionInset = UIEdgeInsetsMake(10, 30, 10, 30);
        //        layout.headerReferenceSize =CGSizeMake(SCREEN_WIDTH, 80);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[YYB_HF_LocaColumnCollectionCellItem class] forCellWithReuseIdentifier:@"YYB_HF_LocaColumnCollectionCellItem"];
        
    }
    return _collectionView;
}
@end

//colectionCell
@implementation YYB_HF_LocaColumnCollectionCellItem
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    
    self.title = [[UILabel alloc] init];
    self.title.numberOfLines = 0;
    self.title.font = FONT(12);
    self.title.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.title];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(ScreenScale(55));
        make.height.mas_equalTo(ScreenScale(45));
    }];
//    MMViewBorderRadius(self.imgView, WidthRatio(15), 0, [UIColor clearColor]);
    //    self.imgView.backgroundColor = [UIColor redColor];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(ScreenScale(5));
        make.left.mas_equalTo(self.imgView);
        make.right.mas_equalTo(self.imgView);
        make.height.mas_equalTo(ScreenScale(12));
    }];
}
@end
