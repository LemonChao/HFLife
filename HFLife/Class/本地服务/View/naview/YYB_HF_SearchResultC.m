//
//  YYB_HF_SearchResultC.m
//  HFLife
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_SearchResultC.h"
#import "YYB_HF_SearchResultCell.h"
#import "YYB_HF_SearchResultHotelCell.h"
@interface YYB_HF_SearchResultC ()<UITableViewDelegate,UITableViewDataSource> {
    BOOL _isAllPage;//是否加载完页数
}
@property(nonatomic, strong) baseTableView *myTable;
@property(nonatomic, strong) NSMutableArray *searResultArr;//

@end

@implementation YYB_HF_SearchResultC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    // Do any additional setup after loading the view.
    
    self.searResultArr = [NSMutableArray array];
    [self.view addSubview:self.myTable];
    [self.myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavBar.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-SafeAreaBottomHeight);
    }];
    WEAK(weakSelf)
    self.myTable.refreshHeaderBlock = ^{
        weakSelf.myTable.page = 1;
        self->_isAllPage = NO;
        [weakSelf.searResultArr removeAllObjects];
        [weakSelf getData];
    };
    
    self.myTable.refreshFooterBlock = ^{
        [weakSelf getData];
    };
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.myTable.page = 1;
    [self getData];
}

//数据搜索
- (void)getData {
    
    if (_isAllPage) {
        [self.myTable endRefreshData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.myTable.mj_footer.state = MJRefreshStateNoMoreData;
        });
        return;
    }
    [[WBPCreate sharedInstance]showWBProgress];
    NSString *urlStr;
    if ([self.searchType isEqualToString:@"1"]) {//美食
        urlStr = kGetSearchFoodList;
    }else {
        urlStr = kGetSearchHotelList;
    }
    NSDictionary *parm = @{@"keyword":self.searchStr,@"sort":@"0",@"page":@(self.myTable.page)};
    
    [networkingManagerTool requestToServerWithType:POST withSubUrl:urlStr withParameters:parm withResultBlock:^(BOOL result, id value) {
        [[WBPCreate sharedInstance]hideAnimated];
        [self.myTable endRefreshData];
        if (result) {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                if ([self.searchType isEqualToString:@"1"]) {//美食
                    NSDictionary *dataDic = value[@"data"];
                    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]]) {
                        NSArray *dataArr = dataDic[@"data"];
                        if (dataArr && dataArr.count > 0) {
                            [self.searResultArr addObjectsFromArray:[SearchFoodList mj_objectArrayWithKeyValuesArray:dataArr]];
                            [self.myTable reloadData];
                        }else {
                            self->_isAllPage = YES;
                        }
                        
                        if (self.searResultArr.count == 0) {
                            NSArray *arr = @[
                                             @{
                                                 @"id": @(1),
                                                 @"food_name": @"个人美食店铺 test",
                                                 @"score_star": @(3),
                                                 @"consume_avg": @(60),
                                                 @"logo_image": @"http://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/locallife/admin/eec4236b95f3abace045babf97ae0ef9.jpg",
                                                 @"distance": @(1.71),
                                                 @"coupon": @"100元代金券",
                                                 @"detail_list": @"披萨（8寸）,披萨（10寸）,雪碧"
                                                 },
                                             @{
                                                 @"id": @(2),
                                                 @"food_name": @"企业美食店铺",
                                                 @"score_star": @(5),
                                                 @"consume_avg":@(70),
                                                 @"logo_image": @"http://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/locallife/admin/f57ebce8a72b823912904fe76eda0909.png",
                                                 @"distance": @(0.03),
                                                 @"coupon": @"200元代金券",
                                                 @"detail_list": @"小龙虾,大闸蟹,水果沙拉"
                                                 }
                                             ];
                            [self.searResultArr addObjectsFromArray:[SearchFoodList mj_objectArrayWithKeyValuesArray:arr]];
                            
                            [self.myTable reloadData];
                        }
                    }
                    
                    
                }else {
                    NSArray *dataArr = value[@"data"];
                    if (dataArr && dataArr.count > 0) {
                        [self.searResultArr addObjectsFromArray:[SearchHotelList mj_objectArrayWithKeyValuesArray:dataArr]];
                        [self.myTable reloadData];
                    }else {
                        self->_isAllPage = YES;
                    }
                    
                    if (self.searResultArr.count == 0) {
                        
                        NSArray *arr = @[
                                         @{
                                             @"id": @(3),   //酒店id
                                             @"logo_image": @"http://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/food/611269fafaaa2921027b980c4526c4b8.jpg",    //logo图
                                             @"hotel_name": @"如家酒店（郑州CBD会展中心店）",    //酒店名称
                                             @"hotel_address": @"商务内环路与通泰路交叉口往东20米新浦大厦",   //酒店地址
                                             @"evaluate_num": @(0),    //评价人数
                                             @"evaluate_star": @(3),   //评分
                                             @"consume_min": @(100),   //最低消费
                                             @"distance": @(4.74)    //距离（km）
                                             },
                                         @{
                                             @"id": @(2),
                                             @"logo_image": @"http://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/locallife/admin/f179911bf47eae2f07fdd261274a4537.jpg",
                                             @"hotel_name": @"私人酒店test",
                                             @"hotel_address": @"裕鸿国际A座",
                                             @"evaluate_num": @(0),
                                             @"evaluate_star": @(3),
                                             @"consume_min": @(260),
                                             @"distance": @(0.04)
                                             }
                                         ];
                        [self.searResultArr addObjectsFromArray:[SearchHotelList mj_objectArrayWithKeyValuesArray:arr]];
                        [self.myTable reloadData];
                    }
                    
                }
            }
            
        }else {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络错误"];
            }
        }
    }];
}

-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    //    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"NearFoodSousuo"]];
    //    [self.customNavBar wr_setRightButtonWithTitle:@"发布" titleColor:HEX_COLOR(0xC04CEB)];
    //    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"yynavi_bg"];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
        //        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.customNavBar setOnClickRightButton:^{
        
        
    }];
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:NO];
    self.customNavBar.title = self.searchStr;
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}

- (baseTableView *)myTable {
    if (!_myTable) {
        _myTable = [[baseTableView alloc]initWithFrame:CGRectZero];
        _myTable.delegate = self;
        _myTable.dataSource = self;
        _myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTable;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searResultArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier1 = @"YYB_HF_SearchResultCell";
    static NSString *identifier2 = @"YYB_HF_SearchResultHotelCell";
    
    if ([self.searchType isEqualToString:@"1"]) {//美食
        SearchFoodList *food = self.searResultArr[indexPath.row];
        YYB_HF_SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell) {
            cell = [[YYB_HF_SearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString judgeNullReturnString:food.logo_image]] placeholderImage:image(@"image1")];
        cell.titleL.text = food.food_name;
        cell.priceL.text = [NSString stringWithFormat:@"￥%@/人",[food.consume_avg stringValue]];
        cell.addressL.text = food.detail_list;
        cell.cashL.text = food.coupon;
        cell.starNum = [food.score_star intValue];
        cell.distanceL.text = [NSString stringWithFormat:@"%.2fkm",[food.distance floatValue]];
        return cell;
    }else {
        SearchHotelList *hotel = self.searResultArr[indexPath.row];
        YYB_HF_SearchResultHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (!cell) {
            cell = [[YYB_HF_SearchResultHotelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString judgeNullReturnString:hotel.logo_image]] placeholderImage:image(@"image1")];
        cell.titleL.text = hotel.hotel_name;
        cell.scoreL.text = [NSString stringWithFormat:@"%.1f分",[hotel.evaluate_star floatValue]];
        cell.addressL.text = [NSString stringWithFormat:@"%.2fkm|%@",[hotel.distance floatValue],hotel.hotel_address];
        cell.pingjiaL.text = [NSString stringWithFormat:@"%@人评价",[hotel.evaluate_num stringValue]];
        cell.consume_minL.text = [NSString stringWithFormat:@"￥%@",[hotel.consume_min stringValue]];
        cell.starNum = [hotel.evaluate_star intValue];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *url;;
    
    SearchFoodList *foodModel = self.searResultArr[indexPath.row];
    url = foodModel.url;
    
    if (url && url.length > 0) {
        YYB_HF_WKWebVC *vc = [[YYB_HF_WKWebVC alloc]init];
        vc.isTop = NO;
        vc.urlString = url;
        vc.isNavigationHidden = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [WXZTipView showCenterWithText:@"click -line"];
    }
}

@end
