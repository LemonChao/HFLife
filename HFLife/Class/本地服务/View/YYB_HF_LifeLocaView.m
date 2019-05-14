//CollectionReusableView
//  YYB_HF_LifeLocaView.m
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_LifeLocaView.h"
#import "XPCollectionViewWaterfallFlowLayout.h"
#import "baseCollectionView.h"
#import "YYB_HF_LocaColumnCollectionCell.h"
#import "YYB_HF_cycleScrollCollectionViewCell.h"
#import "YYB_HF_guessLikeCollectionViewCell.h"
#import "YYb_HF_CollReusableView.h"
#import "WKWebViewController.h"
#import "SynthesizeMerchantListVC.h"
@interface YYB_HF_LifeLocaView()<XPCollectionViewWaterfallFlowLayoutDataSource,UICollectionViewDelegate,UICollectionViewDataSource> {
    
    NSArray *imageNameArray;
    NSArray *titleArray;
    NSArray *VcArr;
}
@property(nonatomic, strong) baseCollectionView *collectionView;
@property(nonatomic, strong) XPCollectionViewWaterfallFlowLayout *layout;

@end

@implementation YYB_HF_LifeLocaView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
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

- (void)setUpUI {
    imageNameArray = @[@"icon_ruzhu",@"icon_meishi",@"icon_jiudian",@"icon_shenxian",@"icon_meifa",@"icon_xiuxian",@"icon_jiehun",@"icon_qinzi",@"icon_waimai",@"icon_jiaju",@"icon_youyong",@"icon_yake",@"icon_jiaoyu",@"icon_meirong",@"icon_gengduo"];
    
    titleArray = @[@"商家入驻",@"美食", @"酒店住宿", @"超市生鲜", @"美在中国", @"休闲娱乐", @"结婚摄影", @"亲子乐园", @"外卖", @"家具装修",@"游泳健身",@"医疗牙科",@"教育培训",@"医学美容",@"更多"];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    WEAK(weakSelf)
    self.collectionView.refreshHeaderBlock = ^{
        [weakSelf.collectionView endRefreshData];
    };
    
    self.collectionView.refreshFooterBlock = ^{
        [weakSelf.collectionView endRefreshData];
    };
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[baseCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_collectionView registerClass:[YYB_HF_LocaColumnCollectionCell class] forCellWithReuseIdentifier:@"YYB_HF_LocaColumnCollectionCell"];
        [_collectionView registerClass:[YYB_HF_cycleScrollCollectionViewCell class] forCellWithReuseIdentifier:@"YYB_HF_cycleScrollCollectionViewCell"];
        [_collectionView registerClass:[YYB_HF_guessLikeCollectionViewCell class] forCellWithReuseIdentifier:@"YYB_HF_guessLikeCollectionViewCell"];
        [_collectionView registerClass:[YYB_HF_guessLikeCollectionViewCellRightPic class] forCellWithReuseIdentifier:@"YYB_HF_guessLikeCollectionViewCellRightPic"];

        [_collectionView registerClass:[YYb_HF_CollReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        [_collectionView registerClass:[YYb_HF_CollReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];

    }
    return _collectionView;
}
- (XPCollectionViewWaterfallFlowLayout *)layout{
    if (!_layout) {
        _layout = [[XPCollectionViewWaterfallFlowLayout alloc] init];
        
        // 头部视图悬停
        //        XPCollectionViewWaterfallFlowLayout *layout = (XPCollectionViewWaterfallFlowLayout *)self.collectionView.collectionViewLayout;
        //        layout.sectionHeadersPinToVisibleBounds = NO;
        
        _layout.sectionHeadersPinToVisibleBounds = NO;//不悬停
        _layout.dataSource = self;//设置数据源代理
    }
    return _layout;
}

#pragma mark - collctionview


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        YYB_HF_LocaColumnCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYB_HF_LocaColumnCollectionCell" forIndexPath:indexPath];
        cell.imgView.image = MMGetImage(imageNameArray[indexPath.row]);
        cell.title.text = titleArray[indexPath.row];
        //    cell.backgroundColor = [UIColor redColor];
        return cell;
    }
    if (indexPath.section == 1) {
        YYB_HF_cycleScrollCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYB_HF_cycleScrollCollectionViewCell" forIndexPath:indexPath];
        // !!!: 设置滚动图片
        [cell setCycleImageArr];
//        [cell setHidden:YES];
        return cell;
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            YYB_HF_guessLikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYB_HF_guessLikeCollectionViewCell" forIndexPath:indexPath];
            return cell;
            
        }else {
            YYB_HF_guessLikeCollectionViewCellRightPic *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYB_HF_guessLikeCollectionViewCellRightPic" forIndexPath:indexPath];
            return cell;
            
        }
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor brownColor];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 15;
    }
    if (section == 2) {
        return 3;
    }
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"section %ld item %ld",indexPath.section,indexPath.row);
    
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = (kind==UICollectionElementKindSectionHeader) ? @"head" : @"foot";
    YYb_HF_CollReusableView *view = (YYb_HF_CollReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    view.backgroundColor = [UIColor whiteColor];
    view.textLabel.text = @"猜你喜欢";
    if (kind == UICollectionElementKindSectionFooter) {
        view.hidden = YES;
    }else{
        if (indexPath.section != 2) {
            view.hidden = YES;
        }else{
            view.hidden = NO;
        }
    }
    
    return view;
}


#pragma mark - XPCollectionViewWaterfallFlowLayout

/// 列数
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout numberOfColumnInSection:(NSInteger)section {
    
    if (section == 0) {
        return 5;
    }
    
    if (section == 1) {
       return 1;
    }
    if (section == 2) {
        return 1;
    }

    return 2;
}
/// item高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout itemWidth:(CGFloat)width
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return ScreenScale(60);
    }
    
    if (indexPath.section == 1) {
        return ScreenScale(92);
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            return ScreenScale(173);
        }
        return ScreenScale(110);
    }
    
    return 50;
}

/// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
/// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 5;
}
///
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout insetForSectionAtIndex:(NSInteger)section {
    
    if (section == 1) {
        return UIEdgeInsetsMake(15, 10, 5, 10);
    }
    return UIEdgeInsetsMake(5, 5, 5, 5);
    
}
/// Return per section header view height.
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout referenceHeightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 30;
    }
    return 1;
}
/// Return per section footer view height.
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout referenceHeightForFooterInSection:(NSInteger)section {
    return 1;
}


@end
