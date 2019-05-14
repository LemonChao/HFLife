//
//  FoodPreferentialCell.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/12.
//  Copyright © 2019年 张海彬. All rights reserved.
// 美食优惠

#import "FoodPreferentialCell.h"
#import "FoodPreferentialCollCell.h"
@interface FoodPreferentialCell ()< UICollectionViewDelegate, UICollectionViewDataSource>
{
    UILabel *titleLabel;
    UIImageView *iconImageView;
    
    NSArray *imageNameArray;
    NSArray *titleArray;
    
    NSArray *dataArray;
}
@property(nonatomic,strong) UICollectionView *collectionView;
@end
@implementation FoodPreferentialCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}
-(void)initWithUI{
//    imageNameArray = @[@"haoikande",@"haochide",@"haoikande",@"haochide",@"haoikande",@"haochide",@"haoikande",@"haochide"];
//    titleArray = @[@"意大利日落",@"王婆大虾",@"意大利日落",@"王婆大虾",@"意大利日落",@"王婆大虾",@"意大利日落",@"王婆大虾"];
    
    iconImageView = [UIImageView new];
    iconImageView.backgroundColor = HEX_COLOR(0x703ae8);
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(25));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(25));
        make.width.mas_equalTo(WidthRatio(6));
        make.height.mas_equalTo(HeightRatio(26));
    }];
    titleLabel = [UILabel new];
    titleLabel.font  = [UIFont fontWithName:@"Helvetica-Bold" size:WidthRatio(30)];
    titleLabel.text = @"超值优惠";
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->iconImageView.mas_right).offset(WidthRatio(25));
        make.centerY.mas_equalTo(self->iconImageView.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_equalTo(HeightRatio(30));
    }];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(HeightRatio(322));
        make.top.mas_equalTo(self->titleLabel.mas_bottom).offset(HeightRatio(23));
    }];
    [self setupAutoHeightWithBottomViewsArray:@[self.collectionView] bottomMargin:HeightRatio(22)];
}
#pragma mark - collectionView代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FoodPreferentialCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FoodPreferentialCollCell" forIndexPath:indexPath];
    cell.dataModel = dataArray[indexPath.row];
//    cell.imgView.image = MMGetImage(imageNameArray[indexPath.row]);
//    cell.title.text = titleArray[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if ([self.delegate respondsToSelector:@selector(clickRecommendedGoodsIndexPath:dataModel:)]) {
//        [self.delegate clickRecommendedGoodsIndexPath:indexPath dataModel:self.dataModel];
//    }
    if ([self.delegate respondsToSelector:@selector(clickRecommendedGoodsDataModel:)]) {
        [self.delegate clickRecommendedGoodsDataModel:dataArray[indexPath.row]];
    }
}
#pragma mark 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(WidthRatio(241), HeightRatio(322));
            // 每一行cell之间的间距
        layout.minimumLineSpacing = WidthRatio(19);
            // 每一列cell之间的间距
            //        layout.minimumInteritemSpacing = HeightRatio(35);
            // 设置第一个cell和最后一个cell,与父控件之间的间距
        layout.sectionInset = UIEdgeInsetsMake(0, WidthRatio(25), 0, WidthRatio(25));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[FoodPreferentialCollCell class] forCellWithReuseIdentifier:@"FoodPreferentialCollCell"];
        
        
    }
    return _collectionView;
}
-(void)setDataModel:(id)dataModel{
    _dataModel = dataModel;
    if ([_dataModel isKindOfClass:[NSArray class]]) {
        dataArray = _dataModel;
        [self.collectionView reloadData];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    /**
     
     */
}

@end
