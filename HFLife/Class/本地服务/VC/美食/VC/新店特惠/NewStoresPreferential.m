//
//  NewStoresPreferential.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/15.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "NewStoresPreferential.h"
#import "JXCategoryView.h"
#import "NewStoresCell.h"
#import "WKWebViewController.h"
//#import "NearNetRequest.h"
//#import "HP_GetNewStoresNetApi.h"
@interface NewStoresPreferential ()<JXCategoryViewDelegate,UITableViewDelegate, UITableViewDataSource>
{
//    HP_GetNewStoresNetApi *getNewStores;
    /** 选择的分类ID*/
    NSString *cate_id;
    
    NSMutableArray *dataArray;
    
//    ListRequestDataType type;
}
@property (nonatomic, strong)JXCategoryTitleView *myCategoryView;

/** 容器TableView*/
@property (nonatomic,strong)UITableView *containerTableView;
@end

@implementation NewStoresPreferential

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if ([NearNetRequest sharedInstance].food_cate.count > 0) {
//        NSDictionary *dict = [NearNetRequest sharedInstance].food_cate[0];
//        cate_id = MMNSStringFormat(@"%@",dict[@"cate_id"]);
//    }
//    type = ListDropdownRefreshType;
    dataArray = [NSMutableArray array];
    [self initWithUI];
    [self setupNavBar];
    [self axcBaseRequestData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar setOnClickRightButton:^{
        NSLog(@"搜索");
    }];
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
        // 设置导航栏显示图片
//    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"meishi_bg"];
    self.customNavBar.title = @"新店特惠";
    [self.customNavBar wr_setRightButtonWithImage:MMGetImage(@"NearFoodSousuo")];
}
-(void)initWithUI{
    UIImageView *topImageView = [UIImageView new];
    topImageView.image = MMGetImage(@"topFoodImage");
    topImageView.userInteractionEnabled = YES;
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(HeightRatio(75)+self.navBarHeight);
    }];
    
    JXCategoryTitleView *titleCategoryView = self.myCategoryView;
    _myCategoryView.titleColor = HEX_COLOR(0xcc9af1);
    _myCategoryView.titleSelectedColor = [UIColor whiteColor];
    titleCategoryView.titleColorGradientEnabled = YES;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineWidth = 20;
    lineView.indicatorLineViewColor = [UIColor whiteColor];
    lineView.lineStyle = JXCategoryIndicatorLineStyle_JD;
    titleCategoryView.indicators = @[lineView];
    
    [topImageView addSubview:self.myCategoryView];
    [self.myCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topImageView.mas_left).offset(WidthRatio(42));
        make.bottom.mas_equalTo(topImageView.mas_bottom);
        make.width.mas_equalTo(WidthRatio(630));
        make.height.mas_equalTo(HeightRatio(51));
    }];
    self.myCategoryView.delegate = self;
//    self.myCategoryView.titles = @[@"福建菜",@"日本菜",@"饮品店",@"面包甜点",@"生日蛋糕",@"火锅",@"自助餐",@"小吃快餐",@"其他美食",@"日韩料理",@"聚餐宴请",@"西餐",@"大闸蟹",@"烧烤烤肉",@"川湘菜",@"香锅烤鱼",@"小龙虾",@"江浙菜",@"中式烧烤/烤串",@"粤菜",@"咖啡酒吧",@"西北菜",@"徽菜",@"豫菜"];
//    self.myCategoryView.titles = [NearNetRequest sharedInstance].cate_titles;
        //    self.myCategoryView.contentScrollView = self.containerScrollView;
    
    [self.view addSubview:self.containerTableView];
    [self.containerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(topImageView.mas_bottom);
    }];
}
-(void)axcBaseRequestData{
    NSString *city = [MMNSUserDefaults objectForKey:@"currentCity"];
    WS(weakSelf);
//    if ([JFLocationSingleton sharedInstance].locationArray.count>0) {
//        CLLocation *newLocation = [[JFLocationSingleton sharedInstance].locationArray lastObject];
//        CLLocationCoordinate2D gaocoor;
//        gaocoor.latitude = newLocation.coordinate.latitude;
//        gaocoor.longitude = newLocation.coordinate.longitude;
//
//        CLLocationCoordinate2D coor = [JZLocationConverter gcj02ToBd09:gaocoor];
//        NSDictionary *dict = @{@"city_name":city,
//                               @"lat":MMNSStringFormat(@"%f",coor.latitude),
//                               @"lng":MMNSStringFormat(@"%f",coor.longitude),
//                               @"cate_id":cate_id
//                               };
//        [self getGetNewStoresDataParameter:dict ListRequestDataType:(type) successBlock:^(id  _Nonnull request) {
//            [weakSelf.containerTableView endLoadMore];
//            [weakSelf.containerTableView endRefreshing];
//            if ([request isKindOfClass:[NSArray class]]) {
//                [self->dataArray addObjectsFromArray:request];
//                [weakSelf.containerTableView reloadData];
//                NSArray *ara = (NSArray *)request;
//                if (ara.count < 10) {
//                    [weakSelf.containerTableView  setLoadMoreViewHidden:YES];
//                }
//            }else{
//                 [weakSelf.containerTableView reloadData];
//                 [weakSelf.containerTableView  setLoadMoreViewHidden:YES];
//            }
//
//        }];
//    }else{
//        [weakSelf.containerTableView endLoadMore];
//    }
}
#pragma mark UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewStoresCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewStoresCell"];
    if (!cell) {
        cell = [[NewStoresCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"NewStoresCell"];
    }
    NSDictionary *dict = dataArray[indexPath.row];
    cell.titleString = [NSString judgeNullReturnString:dict[@"food_name"]];
    cell.distance =  [NSString judgeNullReturnString:dict[@"distance"]];;
    cell.opularity = MMNSStringFormat(@"当前人气%@",dict[@"moods"]);
    cell.imageName = dict[@"photo"];
    cell.starCount = 5;
    cell.star_level = 5;
    cell.address = MMNSStringFormat(@"当前人气%@",dict[@"address"]);;
    if ([dict[@"coupon"] isKindOfClass:[NSArray class]]) {
        NSString *content = @"";
        for (NSString *str in dict[@"coupon"]) {
            content = MMNSStringFormat(@"%@ %@",content,str);
        }
        cell.preferential = content;
    }
//    cell.preferential = MMNSStringFormat(@"%@",dict[@"coupon"]);
//    cell.preferential =  @"";
//    cell.price = @"";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRatio(237);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = dataArray[indexPath.row];
    WKWebViewController *wkWebView = [[WKWebViewController alloc]init];
    wkWebView.isNavigationHidden = YES;
    wkWebView.urlString = dict[@"url"];
    [self.navigationController pushViewController:wkWebView animated:YES];
}

#pragma mark JXCategoryViewDelegate 滑动菜单代理
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    JXCategoryTitleView *category = (JXCategoryTitleView *)categoryView;
    NSLog(@"titleArray = %@",category.titles[index]);
//    if ([NearNetRequest sharedInstance].food_cate.count > 0) {
//        NSDictionary *dict = [NearNetRequest sharedInstance].food_cate[index];
//        cate_id = MMNSStringFormat(@"%@",dict[@"cate_id"]);
//        [dataArray removeAllObjects];
//        [self axcBaseRequestData];
//    }
    
}
#pragma mark 懒加载
- (JXCategoryTitleView *)myCategoryView {
    if (_myCategoryView == nil) {
        _myCategoryView = [[[JXCategoryTitleView class] alloc] init];
        _myCategoryView.delegate = self;
    }
    return _myCategoryView;
}
- (UITableView *)containerTableView{
    if (_containerTableView == nil) {
        _containerTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                           style:UITableViewStylePlain];
        _containerTableView.delegate = self;
        _containerTableView.dataSource = self;
        _containerTableView.backgroundColor = HEX_COLOR(0xf5f8f8);
        _containerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _containerTableView.backgroundColor = HEX_COLOR(0xffffff);
//        [_containerTableView loadMoreDada:^{
//            self->type = ListPullOnLoadingType;
//            [self axcBaseRequestData];
//        }];
//        [_containerTableView refreshingData:^{
//            [self->dataArray removeAllObjects];
//            self->type = ListDropdownRefreshType;
//            [self axcBaseRequestData];
//        }];
    }
    return _containerTableView;
}
//-(void)getGetNewStoresDataParameter:(NSDictionary *)parameter ListRequestDataType:(ListRequestDataType)type successBlock:(SuccessBlock)successBlock{
//    if (!getNewStores) {
//        getNewStores  = [[HP_GetNewStoresNetApi alloc] initWithParameter:parameter];
//    }else{
//        NSString *str1 = parameter[@"cate_id"];
//        NSString *str2 = getNewStores.parameter[@"cate_id"];
//        if (![str1 isEqualToString:str2]) {
//            [getNewStores againPag];
//        }
//        getNewStores.parameter = parameter;
//    }
//    getNewStores.requestDataType = type;
//    [getNewStores startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        HP_GetNewStoresNetApi *classifyRequest = (HP_GetNewStoresNetApi *)request;
//        if ([classifyRequest getCodeStatus] == 1) {
//            NSArray *array = [classifyRequest getContent];
//            successBlock(array);
//        }else{
//            [WXZTipView showCenterWithText:@"数据获取失败"];
//            successBlock(@(NO));
//        }
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [WXZTipView showCenterWithText:@"分类数据获取失败"];
//        successBlock(@(NO));
//    }];
//}
@end
