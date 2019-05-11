//
//  ZC_HF_CollectionCycleHeader.m
//  HFLife
//
//  Created by zchao on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZC_HF_CollectionCycleHeader.h"
#import "SDCycleScrollView.h"
#import "ZCHeaderCategoryCell.h"

@interface ZC_HF_CollectionCycleHeader ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) SDCycleScrollView *cycleView;
@property(nonatomic, strong) UIView *collectionBgView;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, copy) NSArray *dataArray;
@end

@implementation ZC_HF_CollectionCycleHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cycleView];
        [self addSubview:self.collectionBgView];
        [self.collectionBgView addSubview:self.collectionView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(ScreenScale(10), ScreenScale(10), ScreenScale(9), ScreenScale(10)));
        }];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCHeaderCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZCHeaderCategoryCell class]) forIndexPath:indexPath];
    cell.params = self.dataArray[indexPath.row];
    return cell;
}



- (SDCycleScrollView *)cycleView {
    if (!_cycleView) {
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(240)) delegate:self placeholderImage:image(@"banner")];
        _cycleView.localizationImageNamesGroup = @[image(@"banner"),image(@"banner")];
        _cycleView.backgroundColor = [UIColor whiteColor];
        _cycleView.showPageControl = YES;
        _cycleView.pageControlBottomOffset = ScreenScale(23);
        _cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleView.currentPageDotColor = GeneralRedColor;
    }
    return _cycleView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat width = floorf((SCREEN_WIDTH-ScreenScale(20))/5);
        CGFloat height = floorf(ScreenScale(132)/2);//151-top-bottom
        layout.itemSize = CGSizeMake(width, height);
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ZCHeaderCategoryCell class] forCellWithReuseIdentifier:NSStringFromClass([ZCHeaderCategoryCell class])];
    }
    return _collectionView;
}

- (UIView *)collectionBgView {
    if (!_collectionBgView) {
        _collectionBgView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenScale(214), SCREEN_WIDTH, ScreenScale(151))];
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:_collectionBgView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(ScreenScale(23), ScreenScale(23))];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        _collectionBgView.layer.mask = shape;
        _collectionBgView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionBgView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        NSMutableArray *array = [NSMutableArray array];
        
        NSArray *titls = @[@"珠宝手表",@"家具家装",@"家用电器",@"汽车用品",@"食品饮料",@"礼品箱包",@"厨房用具",@"母婴用品",@"服饰鞋帽",@"运动健身"];
        NSArray *images = @[@"zhubaoshoubiao",@"jiajujiazhuang",@"jiayongdianqi",@"qicheyongpin",@"shipinyinliao",@"lipinxiangbao",@"chufangyongpin",@"muyingyongpin",@"fushixiemao",@"yundongjianshen"];
        for (int i = 0; i < titls.count; i++) {
            NSDictionary *dic = @{@"title":titls[i],@"imageName":images[i]};
            [array addObject:dic];
        }
        _dataArray = array.copy;
    }
    return _dataArray;
}

@end



@interface ZC_HF_CollectionWordsHeader ()

@property(nonatomic, strong) UILabel *titleLable;

@end
@implementation ZC_HF_CollectionWordsHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLable];
        self.backgroundColor = [UIColor whiteColor];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(ScreenScale(12));
        }];
    }
    return self;
}


- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UITool labelWithTextColor:ImportantColor font:MediumFont(18)];
        _titleLable.text = @"今日必抢";
    }
    return _titleLable;
}

@end

/// 倒计时View
@interface CountdDownView : UIView

@property(nonatomic, copy) NSString *hour;
@property(nonatomic, copy) NSString *minute;
@property(nonatomic, copy) NSString *second;

@property(nonatomic, strong) UILabel *hourLable;
@property(nonatomic, strong) UILabel *minuteLable;
@property(nonatomic, strong) UILabel *secondLable;

@end
/// 带有倒计时header
@interface ZC_HF_CollectionTimerHeader ()

@property(nonatomic, strong) UILabel *titleLable;

@property(nonatomic, strong) CountdDownView *countDownView;
@end

@implementation ZC_HF_CollectionTimerHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.countDownView = [[CountdDownView alloc] init];
        
        [self addSubview:self.titleLable];
        [self addSubview:self.countDownView];
        
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(ScreenScale(12));
        }];
        [self.countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.titleLable.mas_right).offset(ScreenScale(10));
        }];
    }
    return self;
}


- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UITool labelWithTextColor:ImportantColor font:MediumFont(18)];
        _titleLable.text = @"限时折扣";
    }
    return _titleLable;
}

@end


@interface ShopCountLabel : UILabel

@end


@implementation CountdDownView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hour = self.minute = self.second = @"00";
        self.hourLable = [[ShopCountLabel alloc] init];
        self.minuteLable = [[ShopCountLabel alloc] init];
        self.secondLable = [[ShopCountLabel alloc] init];
        UILabel *colonLab1 = [UITool labelWithText:@":" textColor:GeneralRedColor font:SystemFont(14)];
        UILabel *colonLab2 = [UITool labelWithText:@":" textColor:GeneralRedColor font:SystemFont(14)];
        
        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.hourLable,colonLab1,self.minuteLable,colonLab2,self.secondLable]];
        stackView.axis = UILayoutConstraintAxisHorizontal;
        stackView.alignment = UIStackViewAlignmentFill;
        stackView.distribution = UIStackViewDistributionFill;
        stackView.spacing = 2.f;
        
        [self addSubview:stackView];
        [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

@end



@implementation ShopCountLabel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.text = @"00";
        self.textColor = GeneralRedColor;
        self.font = SystemFont(14);
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = BackGroundColor;
        self.clipsToBounds = YES;
    }
    return self;
}



- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    self.layer.cornerRadius = (size.height+6)/2;
    return CGSizeMake(size.width+16, size.height+4);
}

@end

