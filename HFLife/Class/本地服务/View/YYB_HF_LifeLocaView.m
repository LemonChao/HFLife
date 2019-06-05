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
#import "SynthesizeMerchantListVC.h"

//#import "WKWebViewController.h"
//#import "SynthesizeMerchantListVC.h"
@interface YYB_HF_LifeLocaView()<XPCollectionViewWaterfallFlowLayoutDataSource,UICollectionViewDelegate,UICollectionViewDataSource> {
    int allPage;//猜你喜欢数据页数
    NSArray *VcArr;//跳转webvcurlid或class

}
@property(nonatomic, strong) baseCollectionView *collectionView;
@property(nonatomic, strong) XPCollectionViewWaterfallFlowLayout *layout;
@property(nonatomic, strong) YYB_HF_nearLifeModel *dataModel;//数据源
@property(nonatomic, strong) NSMutableArray *guessLikeData;//数据源_猜你喜欢

@property(nonatomic, assign) BOOL isFirstLoad;

@end

@implementation YYB_HF_LifeLocaView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
        self.isFirstLoad = YES;
        self.guessLikeData = [NSMutableArray array];
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
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    WEAK(weakSelf)
    self.collectionView.refreshHeaderBlock = ^{
        [weakSelf loadData];
        [weakSelf loadGuessLikeData];
    };
    
    self.collectionView.refreshFooterBlock = ^{
        [weakSelf loadGuessLikeData];
    };
}

//数据请求
- (void)loadData {
    
    if (self.isFirstLoad) {
        self.isFirstLoad = NO;
        [self loadGuessLikeData];
    }
    
    [[WBPCreate sharedInstance]showWBProgress];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kNearLife withParameters:nil  withResultBlock:^(BOOL result, id value) {
        [self.collectionView endRefreshData];
        [[WBPCreate sharedInstance]hideAnimated];
        if (result) {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                
                [YYB_HF_nearLifeModel mj_setupObjectClassInArray:^NSDictionary *{
                    return @{
                             @"entrance":[EntranceDetail className]
                             };
                }];
                
                NSDictionary *dataDic = value[@"data"];
                if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                    YYB_HF_nearLifeModel *model = [YYB_HF_nearLifeModel mj_objectWithKeyValues:dataDic];
                    if (model) {
                        self.dataModel = model;
                        //刷新数据
                        
                        [CATransaction setDisableActions:YES];//端头闪动处理
                        [self.collectionView reloadData];
                        [CATransaction commit];
                        
                        //回调刷新位置
                        if (self.reFreshData) {
                            self.reFreshData(model);
                        }
                    }
                }
            }
        }else {
            self.dataModel = nil;
            [self.collectionView reloadData];
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络错误"];
            }
        }
    }];
}

//猜你喜欢数据
- (void)loadGuessLikeData {
    
    if (allPage > 0 && self.collectionView.page > allPage && self.guessLikeData.count > 0) {
        [WXZTipView showCenterWithText:@"已加载全部数据"];
        [self.collectionView endRefreshData];
        return;
    }
    
    NSDictionary *parm = @{@"page":@(self.collectionView.page)};
    [[WBPCreate sharedInstance]showWBProgress];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kGetIndexRecommendList withParameters:parm withResultBlock:^(BOOL result, id value) {
        [self.collectionView endRefreshData];
        [[WBPCreate sharedInstance]hideAnimated];
        if (result) {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *dataDic = value[@"data"];
                if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                    
                    self->allPage = [[dataDic safeObjectForKey:@"last_page"] intValue];
                    if (self->allPage == 1) {
                        [self.guessLikeData removeAllObjects];
                    }
                    NSArray *dataArr = dataDic[@"data"];
                    if (dataArr && [dataArr isKindOfClass:[NSArray class]]) {
                        NSMutableArray *arr = [GuessLikeModel mj_objectArrayWithKeyValuesArray:dataArr];
                        [self.guessLikeData addObjectsFromArray:arr];
                        if (self.guessLikeData) {
                            [CATransaction setDisableActions:YES];
                            [self.collectionView reloadData];
                            [CATransaction commit];
                        }
                    }
                }
            }
            
        }else {
            [self.guessLikeData removeAllObjects];
            [CATransaction setDisableActions:YES];
            [self.collectionView reloadData];
            [CATransaction commit];

            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络错误"];
            }
        }
    }];
}

- (UICollectionView *)collectionView {
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
- (XPCollectionViewWaterfallFlowLayout *)layout {
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
        NSArray *dataArr = self.dataModel.entrance;
        if (dataArr.count == 0) {
            [cell setHidden:YES];
        }else {
            [cell reFreshData:dataArr];
            [cell setHidden:NO];
        }
        cell.selectColumnIndex = ^(NSIndexPath * _Nonnull index) {
            [self selectColumnIndexPath:index];
        };
        return cell;
    }
    if (indexPath.section == 1) {
        YYB_HF_cycleScrollCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYB_HF_cycleScrollCollectionViewCell" forIndexPath:indexPath];
        // !!!: 设置滚动图片
        NSArray *benerArr = self.dataModel.banner;
        if (benerArr.count > 0) {
            [cell setHidden:NO];
            [cell setCycleImageArr:benerArr];
        }else {
            [cell setHidden:YES];
        }
        return cell;
    }
    
    if (indexPath.section == 2) {
        
        GuessLikeModel *guessModel = self.guessLikeData[indexPath.row];
        if (guessModel.product_type.intValue == 1) {//美食布局
            YYB_HF_guessLikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYB_HF_guessLikeCollectionViewCell" forIndexPath:indexPath];
            
            cell.setNameStr = guessModel.store_name;
            cell.setAdLabelStr = guessModel.product_name;
            cell.setDistanceStr = [NSString stringWithFormat:@"%.2fkm",[guessModel.distance floatValue]];
            cell.setPriceStr = [NSString stringWithFormat:@"￥%@",guessModel.product_price];
            cell.setOldPriceStr = [NSString stringWithFormat:@"￥%@",guessModel.original_price];
            cell.setConcessionMoneyStr = [NSString stringWithFormat:@"让利￥%@",guessModel.fan_price];
            cell.setImageArr = guessModel.detail_photo;

            return cell;
            
        }else  if (guessModel.product_type.intValue == 3) {//酒店布局
            YYB_HF_guessLikeCollectionViewCellRightPic *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYB_HF_guessLikeCollectionViewCellRightPic" forIndexPath:indexPath];
            cell.setNameStr = guessModel.store_name;
            cell.setDistanceStr = [NSString stringWithFormat:@"%.2fkm",[guessModel.distance floatValue]];
            cell.setPriceStr = [NSString stringWithFormat:@"￥%@",guessModel.product_price];
            cell.setOldPriceStr = [NSString stringWithFormat:@"￥%@",guessModel.original_price];
            cell.setConcessionMoneyStr = [NSString stringWithFormat:@"让利￥%@",guessModel.fan_price];
            cell.setImageUrl = guessModel.product_photo;
            return cell;
            
        }else{
            YYB_HF_guessLikeCollectionViewCellRightPic *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYB_HF_guessLikeCollectionViewCellRightPic" forIndexPath:indexPath];
            return cell;
            
        }
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor brownColor];
    return cell;
}

// !!!: #pragma mark - section0分类商家点击
- (void)selectColumnIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"idnex %ld - %ld",indexPath.section,indexPath.row);
    
    EntranceDetail *entrModel = self.dataModel.entrance[indexPath.row];

    NSString *url;
    if (indexPath.row == 0) {
        [self checkCamareAlbum];
        //商家入驻
        url = kEnter;
    }else if (indexPath.row == 1) {
        //美食
        url = kMeiFood;
    }else if (indexPath.row == 2) {
        //酒店住宿
        url = kHotelAccommodation;
    }else {
        //默认地址
        url = entrModel.url;
    }
    
    if (url && url.length > 0) {
        YYB_HF_WKWebVC *vc = [[YYB_HF_WKWebVC alloc]init];
        vc.isTop = YES;
        vc.urlString = url;
        vc.isNavigationHidden = YES;
        [self.supVC.navigationController pushViewController:vc animated:YES];
    }else {
        [WXZTipView showCenterWithText:[NSString stringWithFormat:@"click -item %ld",indexPath.row]];
    }
    
    return;
//    if (indexPath.section == 0) {
//        UIViewController *vc;
//
//        if (indexPath.row == 6 || indexPath.row == 8) {
//            WKWebViewController *web = [[WKWebViewController alloc]init];
//            web.webTitle = VcArr[indexPath.row];
//            web.isNavigationHidden = YES;
//            if (indexPath.row == 5) {
//                web.urlString = MMNSStringFormat(@"%@/app_html/food_hotel/html/hotel.html?cate_id=1",GP_BASEURL);
//            }else if (indexPath.row == 6){
//                web.isNavigationHidden = NO;
//                web.urlString = MMNSStringFormat(@"%@/app_html/food_hotel/html/ecoChainHotel.html?cate_id=2",GP_BASEURL);
//
//            }else if (indexPath.row == 8){
//                web.urlString = MMNSStringFormat(@"%@/app_html/food_hotel/html/hotel.html?cate_id=4",GP_BASEURL);
//            }
//            vc = web;
//        }else{
//            if (VcArr.count > indexPath.row) {
//                if ([VcArr[indexPath.row] isKindOfClass:[NSString class]]) {
//                    Class vcClass = NSClassFromString(VcArr[indexPath.row]);
//                    vc = [[vcClass alloc] init];
//                }else{
//                    SynthesizeMerchantListVC *syn = [[SynthesizeMerchantListVC alloc]init];
//                    syn.type = MMNSStringFormat(@"%@",VcArr[indexPath.row]);
//                    vc = syn;
//                }
//            }
//        }
//        if (vc) {
//            [self.viewController.navigationController pushViewController:vc animated:YES];
//        }
//    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        //判断轮播显示
        NSArray *bannerArr = self.dataModel.banner;
        if (bannerArr && [bannerArr isKindOfClass:[NSArray class]]) {
            return bannerArr.count > 0 ? 1 : 0;
        }
        return 0;
    }
    if (section == 2) {
        if (self.guessLikeData) {
            return self.guessLikeData.count;
        }
        return 0;
    }
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"section %ld item %ld",indexPath.section,indexPath.row);
    [WXZTipView showCenterWithText:[NSString stringWithFormat:@"click -item %ld - %ld",indexPath.section,indexPath.row]];
    if (indexPath.section == 0) {
        
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
            if (self.guessLikeData.count == 0) {
                view.hidden = YES;
            }
        }
    }
    
   
    
    return view;
}

#pragma mark - XPCollectionViewWaterfallFlowLayout

/// 列数
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout numberOfColumnInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 1;
    }

    return 2;
}
#pragma mark -  item高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout itemWidth:(CGFloat)width
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSArray *itemArr = self.dataModel.entrance;
        //计算行高
        return ScreenScale(70) * ((itemArr.count / 5) + (itemArr.count % 5 > 0 ? 1 : 0));
    }
    
    if (indexPath.section == 1) {
        if (self.dataModel.banner && [self.dataModel.banner isKindOfClass:[NSArray class]] && self.dataModel.banner.count > 0) {
            return ScreenScale(92);
        }
    }
    
    if (indexPath.section == 2) {
        GuessLikeModel *model = self.guessLikeData[indexPath.row];
        if (model && model.id.intValue > 0) {
            if (model.product_type.intValue == 1) {//美食高度布局
                return ScreenScale(173);
            }
            return ScreenScale(110);//酒店高度布局
        }
    }
    
    return 0;
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
#pragma mark - 检测相机相册
- (void) checkCamareAlbum{
   
    //检测相机权限
    if ([NSObject isCameraAvailable]) {
        if (![userInfoModel isCanUseCamare]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您未开通相机权限" message:@"请在设置-隐私-相册中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }]];
            [self.supVC.navigationController presentViewController:alert animated:YES completion:nil];
            return;
        }
        if (([PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusAuthorized)){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您未开通相册权限" message:@"请在设置-隐私-相册中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }]];
            [self.supVC.navigationController presentViewController:alert animated:YES completion:nil];
            return;
        }
    }else{
        [WXZTipView showCenterWithText:@"相机不可用"];
        return;
    }
}

@end
