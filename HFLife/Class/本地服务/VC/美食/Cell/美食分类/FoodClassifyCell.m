//
//  FoodClassifyCell.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/11.
//  Copyright © 2019年 张海彬. All rights reserved.
// 美食分类

#import "FoodClassifyCell.h"
#import "NearColumnCollectionViewCell.h"
@interface FoodClassifyCell ()< UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView *collectionView;

@end
@implementation FoodClassifyCell
{
    NSArray *imageNameArray;
    NSArray *titleArray;
    NSArray *VCArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
        // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bgima = [UIImageView new];
        bgima.image = MMGetImage(@"meishi_bg");
        [self.contentView addSubview:bgima];
        [bgima mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top);
            make.left.mas_equalTo(self.contentView.mas_left).offset(0);
            make.right.mas_equalTo(self.contentView.mas_right).offset(0);
            make.height.mas_equalTo(HeightRatio(140));
        }];
        UIImageView *bgimageView = [UIImageView new];
        bgimageView.image = MMGetImage(@"footbiejing");
        [self.contentView addSubview:bgimageView];
        [bgimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(16));
            make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(22));
            make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(22));
            make.height.mas_equalTo(HeightRatio(373));
        }];
        [self initWithUI];
    }
    return self;
}
-(void)initWithUI{
    imageNameArray = @[@"youhuituangou",@"fujinhaoquan",@"yuyuedoingzuo",@"xindiantehui",@"waimai_food",@"near_美食_午餐",@"guoguo",@"Buffet",@"dangao"];
    titleArray = @[@"优惠团购",@"附近好券",@"预约订座",@"新店特惠",@"外卖",@"午餐",@"火锅",@"自助餐",@"蛋糕奶茶"];
    VCArray = @[@"DiscountCouponVC",@"NearDiscountCouponVC",@"PreorderTableVC",@"NewStoresPreferential",@"TakeOut_H5",@"LunchVC",@"HotPotVC",@"BuffetVC",@"Cake_MilkyTeaVC"];
   
    [self.contentView addSubview:self.collectionView];
    self.collectionView.scrollEnabled = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(16));
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(22));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(22));
        make.height.mas_equalTo(HeightRatio(373));
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
    return UIEdgeInsetsMake(HeightRatio(34), WidthRatio(0), HeightRatio(35), WidthRatio(0));
}
    //每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return WidthRatio(10);
}
    //设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    double width = (WidthRatio(748) - WidthRatio(20)*5) / 5.0;
    return CGSizeMake(width, HeightRatio(140));
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NearColumnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NearColumnCollectionViewCell" forIndexPath:indexPath];
    cell.imgView.image = MMGetImage(imageNameArray[indexPath.row]);
    cell.title.text = titleArray[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(clickColumnClassificationIndexPath:dataModel:)]) {
        [self.delegate clickColumnClassificationIndexPath:indexPath dataModel:VCArray[indexPath.row]];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
        // Configure the view for the selected state
}

#pragma mark 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[NearColumnCollectionViewCell class] forCellWithReuseIdentifier:@"NearColumnCollectionViewCell"];
        
        
    }
    return _collectionView;
}
//-(void)setDataModel:(nearHotelModel *)dataModel{
//    _dataModel = dataModel;
//}

@end
