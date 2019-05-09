//
//  NearColumnCell.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/8.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "NearColumnCell.h"
#import "NearColumnCollectionViewCell.h"
#import "SDCycleScrollView.h"
@interface NearColumnCell ()< UICollectionViewDelegate, UICollectionViewDataSource, SDCycleScrollViewDelegate>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UIImageView *activityImageView;
@property (nonatomic ,strong) SDCycleScrollView *cycleScroll;
@end
@implementation NearColumnCell
{
    NSArray *imageNameArray;
    NSArray *titleArray;
}
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
    
    imageNameArray = @[@"icon_ruzhu",@"icon_meishi",@"icon_jiudian",@"icon_shenxian",@"icon_meifa",@"icon_xiuxian",@"icon_jiehun",@"icon_qinzi",@"icon_waimai",@"icon_jiaju",@"icon_youyong",@"icon_yake",@"icon_jiaoyu",@"icon_meirong",@"icon_gengduo"];
    
    titleArray = @[@"商家入驻",@"美食", @"酒店住宿", @"超市生鲜", @"美在中国", @"休闲娱乐", @"结婚摄影", @"亲子乐园", @"外卖", @"家具装修",@"游泳健身",@"医疗牙科",@"教育培训",@"医学美容",@"更多"];
    [self.contentView addSubview:self.collectionView];
	self.collectionView.scrollEnabled = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(HeightRatio((362 + 70)));
    }];
    
    
//    self.activityImageView.image = MMGetImage(@"navi_bg");
//    [self.contentView addSubview:self.activityImageView];
    [self.contentView addSubview:self.cycleScroll];
    [self.cycleScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(10);
        make.right.mas_equalTo(self.contentView).mas_offset(-10);
        make.top.mas_equalTo(self.collectionView.mas_bottom).mas_offset(HeightRatio(27));
        make.height.mas_equalTo(HeightRatio(164));
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
    // 允许用户交互
    self.activityImageView.userInteractionEnabled = NO;
    self.activityImageView.hidden = YES;
    [self.activityImageView addGestureRecognizer:tap];
    [self setupAutoHeightWithBottomViewsArray:@[self.collectionView,self.activityImageView] bottomMargin:HeightRatio(27)];
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
    return UIEdgeInsetsMake(HeightRatio(29), WidthRatio(26), HeightRatio(35), WidthRatio(26));
}
    //设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    double width = (SCREEN_WIDTH - WidthRatio(57)*5) / 5.0;
    return CGSizeMake(width, HeightRatio(140) - 20);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NearColumnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NearColumnCollectionViewCell" forIndexPath:indexPath];
    cell.imgView.image = MMGetImage(imageNameArray[indexPath.row]);
    cell.title.text = titleArray[indexPath.row];
//    cell.backgroundColor = [UIColor redColor];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(clickColumnClassificationIndexPath:dataModel:)]) {
        [self.delegate clickColumnClassificationIndexPath:indexPath dataModel:self.dataModel];
    }
    /** 商家入驻 */
    if (indexPath.row == 0) {
        [self.viewController.navigationController pushViewController:[NSClassFromString(@"YYB_HF_EntryVC") new] animated:YES];
    }
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark 点击手势
-(void)doTap:(UITapGestureRecognizer *)sender{
    if ([self.delegate respondsToSelector:@selector(clickActivityDataModel:)]) {
        [self.delegate clickActivityDataModel:self.dataModel];
    }
}
#pragma mark 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        double width = (SCREEN_WIDTH - WidthRatio(52)*5) / 5.0;
        layout.itemSize = CGSizeMake(width, HeightRatio(140));
        layout.minimumLineSpacing = WidthRatio(26);
        layout.minimumInteritemSpacing = HeightRatio(35);
            //        layout.sectionInset = UIEdgeInsetsMake(10, 30, 10, 30);
            //        layout.headerReferenceSize =CGSizeMake(SCREEN_WIDTH, 80);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[NearColumnCollectionViewCell class] forCellWithReuseIdentifier:@"NearColumnCollectionViewCell"];
       
        
    }
    return _collectionView;
}
-(UIImageView *)activityImageView{
    if (_activityImageView == nil) {
        _activityImageView = [UIImageView new];
        _activityImageView.contentMode = UIViewContentModeScaleAspectFit;
//        _activityImageView.backgroundColor = [UIColor brownColor];
    }
    return _activityImageView;
}

//广告位
-(SDCycleScrollView *)cycleScroll{
    if (_cycleScroll == nil) {
        _cycleScroll = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"bg_banner"]];
        _cycleScroll.isCustom = YES;
        _cycleScroll.distance = HeightRatio(47);
        _cycleScroll.delegate = self;
        _cycleScroll.tag = -4000;
        _cycleScroll.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _cycleScroll.imageURLStringsGroup = @[@"http://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=%E5%9B%BE%E7%89%87&hs=0&pn=1&spn=0&di=177320&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=3300305952%2C1328708913&os=188573792%2C343995474&simid=4174703319%2C828922280&adpicid=0&lpn=0&ln=30&fr=ala&fm=&sme=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Fpic37.nipic.com%2F20140113%2F8800276_184927469000_2.png&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bgtrtv_z%26e3Bv54AzdH3Ffi5oAzdH3F9AzdH3F898AzdH3Flm808c0_z%26e3Bip4s&gsm=0&islist=&querylist=",@"http://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=%E5%9B%BE%E7%89%87&hs=0&pn=2&spn=0&di=111043033200&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=935292084%2C2640874667&os=929535083%2C139004715&simid=3383873348%2C359765392&adpicid=0&lpn=0&ln=30&fr=ala&fm=&sme=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Fwww.pptok.com%2Fwp-content%2Fuploads%2F2012%2F08%2Fxunguang-4.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Brrp5h_z%26e3Bv54AzdH3F2sw6j-us5o-rrp-kwvh2657g1-rtvp76j_z%26e3Bip4s&gsm=0&islist=&querylist="];
//        _cycleScroll.backgroundColor = [UIColor brownColor];
    }
    return _cycleScroll;
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
//    NSLog(@"图片----- %ld", index);
//    bannerModel *model = self.bannerListModel[index];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedBannerImageIndex:Url:)]) {
//        [self.delegate selectedBannerImageIndex:index Url:model.advert_url];
//    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
//    NSLog(@"----- %ld", index);
}

- (void)setDataModel:(id)dataModel{
    _dataModel = dataModel;
    
    NSString *str = (NSString *)dataModel;
    if ([str integerValue] == 0) {
        [self.activityImageView removeFromSuperviewAndClearAutoLayoutSettings];
    }else{
        [self.contentView addSubview:self.activityImageView];
        if (self.activityImageView == nil) {
            
        }
        self.activityImageView.sd_resetNewLayout
        .leftSpaceToView(self.contentView, WidthRatio(10))
        .rightSpaceToView(self.contentView, WidthRatio(10))
        .topSpaceToView(self.collectionView, HeightRatio(27))
        .heightIs(HeightRatio(211));
        [self.contentView addSubview:self.activityImageView];
        self.cycleScroll.sd_resetNewLayout
                    .leftSpaceToView(self.contentView, WidthRatio(10))
                    .rightSpaceToView(self.contentView, WidthRatio(10))
                    .topSpaceToView(self.collectionView, HeightRatio(27))
                    .heightIs(HeightRatio(211));
        
    }
    
    
}

//- (void)setBannerListModel:(NSArray<bannerModel *> *)bannerListModel{
//    NSMutableArray *imageArrM = [NSMutableArray array];
//
//    _bannerListModel = bannerListModel;
//    for (bannerModel *model in bannerListModel) {
//        [imageArrM addObject:model.advert_logo];
//    }
//
//    if (bannerListModel.count == 0) {
////        [self.activityImageView removeFromSuperviewAndClearAutoLayoutSettings];
//    }else{
////        if (self.activityImageView == nil) {
////            self.activityImageView.sd_resetNewLayout
////            .leftSpaceToView(self.contentView, WidthRatio(10))
////            .rightSpaceToView(self.contentView, WidthRatio(10))
////            .topSpaceToView(self.collectionView, HeightRatio(27))
////            .heightIs(HeightRatio(211));
////        }
//
//
//        if (self.cycleScroll == nil) {
//            self.cycleScroll.sd_resetNewLayout
//            .leftSpaceToView(self.contentView, WidthRatio(10))
//            .rightSpaceToView(self.contentView, WidthRatio(10))
//            .topSpaceToView(self.collectionView, HeightRatio(27))
//            .heightIs(HeightRatio(211));
//            self.cycleScroll.bounds = self.activityImageView.bounds;
//        }
//
//        self.cycleScroll.imageURLStringsGroup = imageArrM;
//    }
//    //    [self.activityImageView removeFromSuperviewAndClearAutoLayoutSettings];
//}
@end
