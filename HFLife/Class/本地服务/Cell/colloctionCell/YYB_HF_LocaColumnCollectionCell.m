//
//  YYB_HF_LocaColumnCollectionCell.m
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_LocaColumnCollectionCell.h"
#import "WKWebViewController.h"
#import "SynthesizeMerchantListVC.h"
@interface YYB_HF_LocaColumnCollectionCell()<UICollectionViewDelegate, UICollectionViewDataSource> {
    NSArray *imageNameArray;//图片数组
    NSArray *titleArray;//title数组
    NSArray *VcArr;//跳转webvcurlid或class
}
@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic, strong) NSArray *itemDataArr;
@end

@implementation YYB_HF_LocaColumnCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        VcArr = @[@"NearFoodVC",
                  @(1),
                  @(2),
                  @(3),
                  @(4),
                  @(5),
                  @"经济连锁",
                  @"GuesthouseVC",
                  @"商务酒店",
                  @"NearHotelVC"
                  ];
    }
    return self;
}
- (void)initView {
    
//    imageNameArray = @[@"icon_ruzhu",@"icon_meishi",@"icon_jiudian",@"icon_shenxian",@"icon_meifa",@"icon_xiuxian",@"icon_jiehun",@"icon_qinzi",@"icon_waimai",@"icon_jiaju",@"icon_youyong",@"icon_yake",@"icon_jiaoyu",@"icon_meirong",@"icon_gengduo"];
//
//    titleArray = @[@"商家入驻",@"美食", @"酒店住宿", @"超市生鲜", @"美在中国", @"休闲娱乐", @"结婚摄影", @"亲子乐园", @"外卖", @"家具装修",@"游泳健身",@"医疗牙科",@"教育培训",@"医学美容",@"更多"];
    
//    UIScrollView *scroll = [UIScrollView new];
//    [self.contentView addSubview:scroll];
//    [scroll addSubview:self.collectionView];
//    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.right.left.mas_equalTo(self.contentView);
//        make.height.mas_equalTo(ScreenScale(65) * 3);
//    }];
//    scroll.contentSize = CGSizeMake(SCREEN_WIDTH * 6.0 / 5.0, ScreenScale(65) * 3);
//    self.collectionView.scrollEnabled = YES;
//    _collectionView.contentSize = CGSizeMake(SCREEN_WIDTH * 6.0 / 5.0, _collectionView.height);
//    [self.collectionView setFrame:CGRectMake(0, 0, SCREEN_WIDTH * 6.0 / 5.0, ScreenScale(65) * 3)];
    // ver
    [self.contentView addSubview:self.collectionView];
    self.collectionView.scrollEnabled = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(ScreenScale(65) * (self.itemDataArr.count / 5 + (self.itemDataArr.count % 5 > 0 ? 1 : 0)));
        make.top.right.left.mas_equalTo(self.contentView);
    }];
}

- (void)reFreshData:(NSArray *)dataArr {
    self.itemDataArr = dataArr;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(ScreenScale(65) * (self.itemDataArr.count / 5 + (self.itemDataArr.count % 5 > 0 ? 1 : 0)));
        make.top.right.left.mas_equalTo(self.contentView);
    }];
    
    [self.collectionView reloadData];
}


#pragma mark - collectionView代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.itemDataArr) {
        return self.itemDataArr.count;
    }else {
        return 0;
    }
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
    EntranceDetail *itemModel = (EntranceDetail *)self.itemDataArr[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:itemModel.icon] placeholderImage:image(@"icon_phone_login")];
    cell.title.text = itemModel.name;
    
//    cell.imgView.image = MMGetImage(imageNameArray[indexPath.row]);
//    cell.title.text = titleArray[indexPath.row];
    //    cell.backgroundColor = [UIColor redColor];
    return cell;
}
//本地分类点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UIViewController *vc;
        
        if (indexPath.row == 6 || indexPath.row == 8) {
            WKWebViewController *web = [[WKWebViewController alloc]init];
            web.webTitle = VcArr[indexPath.row];
            web.isNavigationHidden = YES;
            if (indexPath.row == 5) {
                web.urlString = MMNSStringFormat(@"%@/app_html/food_hotel/html/hotel.html?cate_id=1",GP_BASEURL);
            }else if (indexPath.row == 6){
                web.isNavigationHidden = NO;
                web.urlString = MMNSStringFormat(@"%@/app_html/food_hotel/html/ecoChainHotel.html?cate_id=2",GP_BASEURL);
                
            }else if (indexPath.row == 8){
                web.urlString = MMNSStringFormat(@"%@/app_html/food_hotel/html/hotel.html?cate_id=4",GP_BASEURL);
            }
            vc = web;
        }else{
            if (VcArr.count > indexPath.row) {
                if ([VcArr[indexPath.row] isKindOfClass:[NSString class]]) {
                    Class vcClass = NSClassFromString(VcArr[indexPath.row]);
                    vc = [[vcClass alloc] init];
                }else{
                    SynthesizeMerchantListVC *syn = [[SynthesizeMerchantListVC alloc]init];
                    syn.type = MMNSStringFormat(@"%@",VcArr[indexPath.row]);
                    vc = syn;
                }
            }
        }
        if (vc) {
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
    }
    
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
