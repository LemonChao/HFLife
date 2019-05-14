//
//  NearFoodVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/11.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "NearFoodVC.h"
//代理处理
#import "NearFoodDelegateManage.h"

#import "JXCategoryView.h"
#import "NearFoodListVC.h"
#import "NearFoodListCell.h"

//#import "NearNetRequest.h"
#import "JZLocationConverter.h"

#import "JFLocationSingleton.h"
#import "PYSearch.h"

#define NAVBAR_TRANSLATION_POINT HeightRatio(437)
#define NavBarHeight 44
@interface NearFoodVC ()<UITableViewDelegate, UITableViewDataSource,JXCategoryViewDelegate,CLLocationManagerDelegate,PYSearchViewControllerDelegate>
{
    CGFloat FoodPreferentialCellHeight;
    NSString *titleString;
    /** 超值优惠*/
    NSArray *food_discount;
    /** 分类*/
    NSArray *food_cate;
    NSArray *locationArray;
    /** 选择的分类ID*/
    NSString *cate_id;
    
    NSMutableArray *cate_Array;
    
//    HP_FoodHomeClassifyNetApi *foodHomeClassify;
}
/** 搜索框*/
@property (nonatomic, strong) UITextField *searchTextField;
/** 容器TableView*/
@property (nonatomic,strong)UITableView *containerTableView;

@property (nonatomic, strong)JXCategoryTitleView *myCategoryView;

@property (nonatomic, strong)UIView *optionsView;

@property (nonatomic, strong) UIScrollView *containerScrollView;

@property (nonatomic, strong) NSArray *titles;

/** 代理处理相关*/
@property (nonatomic, strong) NearFoodDelegateManage *delegateManage;

@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation NearFoodVC
- (void)viewDidLoad{
    [super viewDidLoad];
    cate_Array = [NSMutableArray array];
    self.title = @"美食";
    [self.locationManager startUpdatingLocation];
    self.view.backgroundColor = [UIColor whiteColor];
//     [WRNavigationBar wr_setDefaultNavBarBarTintColor:[UIColor colorWithPatternImage:MMGetImage(@"foodBG.png")]];
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:MMGetImage(@"foodBG.png")];
//    [self setupNavigationItem];
     self.titles = @[];
    food_discount = @[];
    food_cate = @[];
    [self.view addSubview:self.containerTableView];
    self.containerTableView.tableFooterView = [UIView new];
    
    // !!!:[self axcBaseRequestData];
    NSString *city = [MMNSUserDefaults objectForKey:@"currentCity"];
    if ([NSString isNOTNull:city]) {
//        [self initEmptyDataViewbelowSubview:self.customNavBar touchBlock:^{
//        }];
        
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"homeNavBG"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.containerTableView.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.containerTableView.delegate = nil;
    [self setNavigationBarTransformProgress:0];
}
//-(void)axcBaseRequestData{
//    WS(weakSelf);
//    NSString *city = [MMNSUserDefaults objectForKey:@"currentCity"];
//    if (![NSString isNOTNull:city]) {
//        NSDictionary *dict = @{@"city_name":city};
//        [[NearNetRequest sharedInstance]getFoodHomeDataParameter:dict successBlock:^(id  _Nonnull request) {
//            if ([request isKindOfClass:[NSDictionary class]]) {
//                NSDictionary *dict = (NSDictionary *)request;
//                if ([dict[@"food_discount"] isKindOfClass:[NSArray class]]) {
//                    self->food_discount = dict[@"food_discount"];
//                }
//                self->food_cate = dict[@"food_cate"];
//                NSMutableArray *titArray = [NSMutableArray array];
//
//                if ([self->food_cate isKindOfClass:[NSArray class]]) {
//                    for (NSDictionary *dict in self->food_cate) {
//                        if ([NSString isNOTNull:self->cate_id]) {
//                            self->cate_id = MMNSStringFormat(@"%@",dict[@"cate_id"]);
//                        }
//                        [titArray addObject:dict[@"cate_name"]];
//                    }
//                    [NearNetRequest sharedInstance].food_cate = self->food_cate;
//                }
//
//
//                self.titles = titArray;
//                if (self.titles.count > 1) {
//                    self->titleString = self.titles[0];
//                }
//
//                [NearNetRequest sharedInstance].cate_titles = self.titles;
//                [weakSelf.containerTableView reloadData];
//                [self axcBaseRequestClassifyData];
//            }else{
//                self.containerTableView.bounces = YES;
//            }
//        }];
//    }
//}
//-(void)axcBaseRequestClassifyData{
//    NSString *city = [MMNSUserDefaults objectForKey:@"currentCity"];
//    WS(weakSelf);
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
//                               @"cate_id":[NSString judgeNullReturnString:cate_id]
//                               };
//        [self getFoodHomeClassifyDataParameter:dict ListRequestDataType:(ListPullOnLoadingType) successBlock:^(id  _Nonnull request) {
//            [weakSelf.containerTableView endLoadMore];
//            if ([request isKindOfClass:[NSArray class]]) {
//                [self->cate_Array addObjectsFromArray:request];
//                [weakSelf.containerTableView reloadData];
//                NSArray *ara = (NSArray *)request;
//                if (ara.count < 10) {
//                    [weakSelf.containerTableView  setLoadMoreViewHidden:YES];
//                }
//            }else{
//
//            }
//
//        }];
//    }else{
//        [WXZTipView showCenterWithText:@"定位获取失败，暂无法获取店铺信息"];
//        [weakSelf.containerTableView endLoadMore];
//    }
//
//}
- (void)setupNavigationItem {
    UIButton *signinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [signinBtn setImage:[UIImage new] forState:UIControlStateNormal];
    signinBtn.frame = CGRectMake(0, 0, WidthRatio(30), 44);
    UIBarButtonItem *signin = [[UIBarButtonItem alloc] initWithCustomView:signinBtn];
    
    self.navigationItem.rightBarButtonItems = @[signin];
    
//    self.navigationItem.titleView = self.searchTextField;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (![scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    if (scrollView != _containerTableView) {
        return;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
        // 向上滑动的距离
    NSLog(@"%lf", scrollView.contentOffset.y);
    CGFloat scrollUpHeight = offsetY - NAVBAR_TRANSLATION_POINT;
        // 除数表示 -> 导航栏从完全不透明到完全透明的过渡距离
    CGFloat progress = scrollUpHeight / NavBarHeight;
    if (offsetY > NAVBAR_TRANSLATION_POINT){
        if (scrollUpHeight > 44){
            NSLog(@"33333");
            if (_containerTableView.frame.origin.y >= -44) {
                _containerTableView.frame = CGRectMake(0, -44, _containerTableView.frame.size.width, self.view.frame.size.height+44);
            }
            [self setNavigationBarTransformProgress:1];
            
            CGFloat offy = scrollView.contentOffset.y;
            CGFloat he = HeightRatio(437) + HeightRatio(242) + FoodPreferentialCellHeight + (SCREEN_HEIGHT - self.heightStatus - HeightRatio(195));
            CGFloat hh = SCREEN_HEIGHT - self.heightStatus - HeightRatio(195);
            NSLog(@"he = %f offY = %f hh=%f FoodPreferentialCellHeight = %f",he,offy,hh,FoodPreferentialCellHeight);
            if (offy >= hh) {
                self.containerTableView.bounces = NO;
            }else{
                self.containerTableView.bounces = YES;
            }
        }
        else{
            NSLog(@"22222");
            _containerTableView.frame = CGRectMake(0, -scrollUpHeight, _containerTableView.frame.size.width, self.view.frame.size.height+scrollUpHeight);
            [self setNavigationBarTransformProgress: progress];
        }
    }
    else{
        NSLog(@"11111111");
        if (_containerTableView.frame.origin.y <=0) {
            _containerTableView.frame = CGRectMake(0, 0, _containerTableView.frame.size.width, self.view.frame.size.height);
            
        }
        if (scrollView.contentOffset.y < 44) {
            self.containerTableView.bounces = YES;
        }else{
            self.containerTableView.bounces = NO;
        }
        [self setNavigationBarTransformProgress:0];
        
    }
    
    
    NSLog(@"%lf   %lf", scrollView.contentSize.height - scrollView.contentOffset.y - 44, _containerTableView.frame.size.height);
    
    if (scrollView.contentSize.height - scrollView.contentOffset.y - 44 <= _containerTableView.frame.size.height) {
        self.containerTableView.bounces = YES;
        if (cate_Array.count <= 4) {
            self.containerTableView.bounces = NO;
        }
    }
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress{
    [self.navigationController.navigationBar wr_setTranslationY:(-NavBarHeight * progress)];
    // 没有系统返回按钮，所以 hasSystemBackIndicator = NO
    // 如果这里不设置为NO，你会发现，导航栏无缘无故多出来一个返回按钮
    [self.navigationController.navigationBar wr_setBarButtonItemsAlpha:(1 - progress) hasSystemBackIndicator:NO];
}




#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }else{
        return cate_Array.count;
//        return 10;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        FoodClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoodClassifyCell"];
        if (!cell) {
            cell = [[FoodClassifyCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"FoodClassifyCell"];
        }
        cell.delegate = self.delegateManage;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        CGFloat width = CGRectGetWidth(cell.bounds);
//        cell.separatorInset = UIEdgeInsetsMake(0, width, 0, 0); // 向左偏移
//        cell.indentationWidth = -width; // adjust the cell's content to show normally
//        cell.indentationLevel = 1;
        return cell;
    }else if (indexPath.section==0&&indexPath.row==1){
        FoodAdvertisingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoodAdvertisingCell"];
        if (!cell) {
            cell = [[FoodAdvertisingCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"FoodAdvertisingCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==0&&indexPath.row==2){
        FoodPreferentialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoodPreferentialCell"];
        if (!cell) {
            cell = [[FoodPreferentialCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"FoodPreferentialCell"];
        }
        cell.delegate = self.delegateManage;
        cell.dataModel = food_discount;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        NearFoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NearFoodListCell"];
        if (!cell) {
            cell = [[NearFoodListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"NearFoodListCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSDictionary *dict = cate_Array[indexPath.row];
//        cell.imageName = dict[@"photo"];
//
//        cell.titleString = dict[@"food_name"];
////        cell.upToSend = @"20";
////        cell.distributionMoney = @"®4";
//        cell.star_level = 4;
//        cell.salesString = MMNSStringFormat(@"月售%@",dict[@"month_num"]) ;
//        cell.sentiment = MMNSStringFormat(@"%@",dict[@"moods"]);
//        cell.timeDistance = MMNSStringFormat(@"%@KM",dict[@"is_open"]);
//        cell.near = @"";
//        cell.preferentialArray = dict[@"coupon"];
        cell.dataDict = dict;
        return cell;
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        if (indexPath.row==0) {
            return HeightRatio(437);
        }else if (indexPath.row==1){
//            return HeightRatio(242);
            return 0;
        }else if (indexPath.row==2){
             FoodPreferentialCellHeight = [tableView cellHeightForIndexPath:indexPath model:food_discount keyPath:@"dataModel" cellClass:[FoodPreferentialCell class] contentViewWidth:[self cellContentViewWith]];
            return FoodPreferentialCellHeight;
        }
        return 100;
    }else{
         NSDictionary *dict = cate_Array[indexPath.row];
        NSArray *couponArray = dict[@"food_cate"];
        NSArray *ticketArray = dict[@"coupon"];
        if (couponArray.count>0 && ticketArray.count>0	) {
            return HeightRatio(290);
        }else if (couponArray.count>0 || ticketArray.count>0){
            return HeightRatio(280);
        }else{
            return HeightRatio(230);
        }
//        return SCREEN_HEIGHT - self.heightStatus - HeightRatio(195);
//        return HeightRatio(304);
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section>0) {
         NSDictionary *dict = cate_Array[indexPath.row];
        WKWebViewController *wkWebView = [[WKWebViewController alloc]init];
        wkWebView.isNavigationHidden = YES;
        wkWebView.urlString = [NSString judgeNullReturnString:dict[@"url"]];
        [self.navigationController pushViewController:wkWebView animated:YES];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
        return view;
    }else if (section==1){
        
        return self.optionsView;
    }
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.01;
    }else if (section==1){
        return HeightRatio(195);
    }
    return 0.01;
}
#pragma mark JXCategoryViewDelegate 代理
//点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
        //侧滑手势处理
//    if (_shouldHandleScreenEdgeGesture) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
//    }
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if (food_cate.count > index) {
        NSDictionary *dict =  food_cate[index];
        cate_id = MMNSStringFormat(@"%@",[NSString judgeNullReturnString:dict[@"cate_id"]]);
    }
    if (self.titles.count > index) {
        titleString = self.titles[index];
    }
    
    [cate_Array removeAllObjects];
    // !!!: [self axcBaseRequestClassifyData];
}
// 滚动选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"2222");
}
//点击选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"1111");
}
#pragma mark CLLocationManagerDelegate 代理
//开启定位后会先调用此方法，判断有没有权限
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)
    {
            //判断ios8 权限
        
        if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//            [self.locationManager requestAlwaysAuthorization]; // 永久授权
            [self.locationManager requestWhenInUseAuthorization]; //使用中授权
        }
        
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.locationManager startUpdatingLocation];
    }
}

//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    // 获取经纬度
//    NSLog(@"纬度:%f",newLocation.coordinate.latitude);
//    NSLog(@"经度:%f",newLocation.coordinate.longitude);
//        // 停止位置更新
//    [manager stopUpdatingLocation];
//}
//成功获取到经纬度
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    locationArray = nil;
    locationArray = locations;
}
// 定位失败错误信息
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error");
}
-(void)searchClick{
    NSLog(@"searchClick");
        // 1. 创建一个流行搜索数组
    NSArray *hotSeaches = @[@"黄焖鸡", @"鸡公煲", @"茄汁面", @"烧烤", @"必胜客", @"肯德基", @"花千代"];
        // 2. 创建一个搜索视图控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"请输入搜索内容" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
            // 搜索开始时呼叫。
            // eg：推送到临时视图控制器
//        [searchViewController.navigationController pushViewController:[[SearchForDetailsVC alloc] init] animated:YES];
    }];
        // 3. 为流行搜索和搜索历史设置样式
    searchViewController.hotSearchStyle = PYHotSearchStyleNormalTag;
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
        // 4. Set delegate
    searchViewController.delegate = self;
        // 5. 呈现(模态)或推送搜索视图控制器
        // Present(Modal)
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:nil];
        // Push
        // 显示搜索视图控制器的设置模式，默认为' PYSearchViewControllerShowModeModal '
        //    searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowModePush;
        // Push search view controller
        //    [self.navigationController pushViewController:searchViewController animated:YES];
}
#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
            // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            //Refresh and display the search suggustions
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

#pragma mark 懒加载
- (UITableView *)containerTableView
{
    if (_containerTableView == nil) {
        WS(weakSelf);
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH,self.view.frame.size.height);
        _containerTableView = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
        _containerTableView.delegate = self;
        _containerTableView.dataSource = self;
        _containerTableView.backgroundColor = HEX_COLOR(0xffffff);
        _containerTableView.tableFooterView = [UIView new];
        _containerTableView.separatorStyle = UITableViewCellEditingStyleNone;//让tableview不显示分割线
//        [_containerTableView loadMoreDada:^{
//            [weakSelf axcBaseRequestClassifyData];
//        }];
    }
    return _containerTableView;
}
- (UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(560), HeightRatio(68))];
        _searchTextField.backgroundColor = HEX_COLOR(0x6e66b1);
        _searchTextField.font = [UIFont systemFontOfSize:HeightRatio(22)];
        _searchTextField.textColor = [UIColor whiteColor];
        _searchTextField.text = @"	星巴克咖啡（裕鸿国际店）";
//        _searchTextField.borderStyle = UITextBorderStyleRoun？？？dedRect;
//        _searchTextField.enabled = NO;
        _searchTextField.alpha = 0.7;
        MMViewBorderRadius(_searchTextField, WidthRatio(25), 0, [UIColor clearColor]);
        UIButton *search = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,  WidthRatio(560), HeightRatio(68))];
        search.backgroundColor = [UIColor clearColor];
        [search addTarget:self action:@selector(searchClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_searchTextField addSubview:search];
    }
    return _searchTextField;
}
- (JXCategoryTitleView *)myCategoryView {
    if (_myCategoryView == nil) {
        _myCategoryView = [[[JXCategoryTitleView class] alloc] init];
        _myCategoryView.delegate = self;
    }
    return _myCategoryView;
}
- (UIView *)optionsView{
    if (!_optionsView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeightRatio(195))];
        UIImageView *bgImageView =[UIImageView new];
        bgImageView.image = MMGetImage(@"meisihguangchang");
        [view addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view.mas_left).offset(-WidthRatio(20));
            make.right.mas_equalTo(view.mas_right).offset(WidthRatio(20));
            make.bottom.mas_equalTo(view.mas_bottom).offset(HeightRatio(20));;
            make.top.mas_equalTo(view.mas_top).offset(-HeightRatio(20));
        }];
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"美食\n广场";
        titleLabel.numberOfLines = 2;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font  = [UIFont fontWithName:@"Helvetica-Bold" size:WidthRatio(30)];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view.mas_left).offset(WidthRatio(20));
            make.top.mas_equalTo(view.mas_top);
            make.width.mas_equalTo(WidthRatio(100));
            make.height.mas_equalTo(HeightRatio(95));
        }];
        
        UILabel *titleLabel1 = [UILabel new];
        titleLabel1.text = @"各种美食应有尽有，让你流连忘返";
        titleLabel1.numberOfLines = 2;
        titleLabel1.textColor = HEX_COLOR(0xE3D5F9);
        titleLabel1.font  = [UIFont systemFontOfSize:WidthRatio(20)];
        [view addSubview:titleLabel1];
        [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view.mas_left).offset(WidthRatio(152));
            make.top.mas_equalTo(view.mas_top).offset(HeightRatio(38));
            make.width.mas_greaterThanOrEqualTo(1);
            make.height.mas_equalTo(HeightRatio(20));
        }];
        
        JXCategoryTitleView *titleCategoryView = self.myCategoryView;
        _myCategoryView.titleColor = HEX_COLOR(0xcc9af1);
        _myCategoryView.titleSelectedColor = [UIColor whiteColor];
        titleCategoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorLineWidth = 20;
        lineView.indicatorLineViewColor = [UIColor whiteColor];
//        lineView.indicatorLineViewHeight = 5;
        lineView.lineStyle = JXCategoryIndicatorLineStyle_JD;
        titleCategoryView.indicators = @[lineView];
        
        [view addSubview:self.myCategoryView];
        [self.myCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view.mas_left).offset(WidthRatio(52));
            make.top.mas_equalTo(view.mas_top).offset(HeightRatio(117));
            make.right.mas_equalTo(view.mas_right).offset(-HeightRatio(77));
            make.height.mas_equalTo(HeightRatio(60));
        }];
        self.myCategoryView.delegate = self;
        
       
        
//        self.myCategoryView.contentScrollView = self.containerScrollView;
//        self.myCategoryView.contentScrollView = self.scrollView;

        
        _optionsView = view;
    }
    self.myCategoryView.titles = self.titles;
    [self.myCategoryView reloadData];
    return _optionsView;
}
-(UIScrollView *)containerScrollView{
    if (!_containerScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.heightStatus - HeightRatio(195))];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.titles.count, scrollView.height);
        scrollView.bounces = NO;
        for (int i = 0; i < self.titles.count; i ++) {
            NearFoodListVC *listVC = [[NearFoodListVC alloc] init];
            listVC.foodTitle = self.titles[i];
            [self addChildViewController:listVC];
            listVC.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, scrollView.height);
            [scrollView addSubview:listVC.view];
        }
        _containerScrollView = scrollView;
    }
    return _containerScrollView;
}
-(NearFoodDelegateManage *)delegateManage{
    if (!_delegateManage) {
        _delegateManage = [NearFoodDelegateManage shareInstance];
        _delegateManage.superVC = self;
    }
    return _delegateManage;
}
-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
            // 设置定位精度，十米，百米，最好
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
            //每隔多少米定位一次（这里的设置为任何的移动）
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.delegate = self; //代理设置
            // 开始时时定位
        if ([CLLocationManager locationServicesEnabled]){
            // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
            [self.locationManager startUpdatingLocation];
        }else{
            NSLog(@"请开启定位功能");
        }
    }
    return _locationManager;
}
//-(void)getFoodHomeClassifyDataParameter:(NSDictionary *)parameter ListRequestDataType:(ListRequestDataType)type successBlock:(SuccessBlock)successBlock{
//    if (!foodHomeClassify) {
//        foodHomeClassify  = [[HP_FoodHomeClassifyNetApi alloc] initWithParameter:parameter];
//    }else{
//        NSString *str1 = parameter[@"cate_id"];
//        NSString *str2 = foodHomeClassify.parameter[@"cate_id"];
//        if (![str1 isEqualToString:str2]) {
//            [foodHomeClassify againPag];
//        }
//        foodHomeClassify.parameter = parameter;
//    }
//    foodHomeClassify.requestDataType = type;
//    [foodHomeClassify startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        HP_FoodHomeClassifyNetApi *classifyRequest = (HP_FoodHomeClassifyNetApi *)request;
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
