
    //
//  HotPotVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/3/8.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "HotPotVC.h"
#import "WKWebViewController.h"
#import "NewStoresCell.h"
//#import "NearNetRequest.h"
//#import "HP_FootHotPotNetApi.h"
@interface HotPotVC ()<UITableViewDelegate, UITableViewDataSource>
{
//    HP_FootHotPotNetApi *hotPot;
    NSMutableArray *dataArray;
//    ListRequestDataType type;
}
/** 容器TableView*/
@property (nonatomic,strong)UITableView *containerTableView;
@end

@implementation HotPotVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self.customNavBar wr_setBackgroundAlpha:1];
    [self.customNavBar wr_setBottomLineHidden:YES];
    // 设置导航栏显示图片
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"topFoodImage"];
    self.customNavBar.title = @"火锅";
//    [self.customNavBar wr_setRightButtonWithImage:MMGetImage(@"NearFoodSousuo")];
}
-(void)initWithUI{
    [self.view addSubview:self.containerTableView];
    [self.containerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight);
    }];
}
-(void)axcBaseRequestData{
    NSString *city = [MMNSUserDefaults objectForKey:selectedCity];
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
//                               };
//        [self getHotPotDataParameter:dict ListRequestDataType:(type) successBlock:^(id  _Nonnull request) {
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
//                [weakSelf.containerTableView reloadData];
//                [weakSelf.containerTableView  setLoadMoreViewHidden:YES];
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
    cell.star_level = [dict[@"star"] intValue];
    cell.address = MMNSStringFormat(@"当前人气%@",dict[@"address"]);;
        //    cell.preferential = @"3人餐99.9元，4人餐129元，6人餐179.9元";
    cell.preferential =  @"";
    cell.price = @"";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dataSource = dict;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//      return HeightRatio(237);
//    }
////
    NSDictionary *dict = dataArray[indexPath.row];
    CGFloat height = [tableView cellHeightForIndexPath:indexPath model:dict keyPath:@"dataSource" cellClass:[NewStoresCell class] contentViewWidth:[self cellContentViewWith]];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = dataArray[indexPath.row];
    WKWebViewController *wkWebView = [[WKWebViewController alloc]init];
    wkWebView.isNavigationHidden = YES;
    wkWebView.urlString = dict[@"url"];
    [self.navigationController pushViewController:wkWebView animated:YES];
}

#pragma mark 懒加载
- (UITableView *)containerTableView{
    if (_containerTableView == nil) {
        _containerTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                           style:UITableViewStylePlain];
        _containerTableView.delegate = self;
        _containerTableView.dataSource = self;
        _containerTableView.backgroundColor = HEX_COLOR(0xf5f8f8);
        _containerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _containerTableView.backgroundColor = HEX_COLOR(0xffffff);
            //        _containerTableView.tableFooterView = [UIView new];
            //        _containerTableView.tableHeaderView = [UIView new];
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

//-(void)getHotPotDataParameter:(NSDictionary *)parameter ListRequestDataType:(ListRequestDataType)type successBlock:(SuccessBlock)successBlock{
//    if (!hotPot) {
//        hotPot  = [[HP_FootHotPotNetApi alloc] initWithParameter:parameter];
//    }
//    hotPot.requestDataType = type;
//    [hotPot startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        HP_FootHotPotNetApi *classifyRequest = (HP_FootHotPotNetApi *)request;
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
