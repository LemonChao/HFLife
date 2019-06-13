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

@property(nonatomic, strong) LYEmptyView *noDataView;//无数据

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
    if (self.searResultArr.count == 0) {
        self.myTable.page = 1;
        [self getData];
    }
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
    [self.noDataView setHidden:YES];
    [[WBPCreate sharedInstance]showWBProgress];
    NSString *urlStr;
    if ([self.searchType isEqualToString:@"1"]) {//美食
        urlStr = kLifeAdress(kGetSearchFoodList);
    }else {
        urlStr = kLifeAdress(kGetSearchHotelList);
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
                        }else {
                            self->_isAllPage = YES;
                        }
                    }
                }else {//酒店
                    NSArray *dataArr = value[@"data"];
                    if (dataArr && dataArr.count > 0) {
                        [self.searResultArr addObjectsFromArray:[SearchHotelList mj_objectArrayWithKeyValuesArray:dataArr]];
                    }else {
                        self->_isAllPage = YES;
                    }
                }
                [self.myTable reloadData];
                if (self.searResultArr.count == 0) {
                    [self.noDataView setHidden:NO];
                }
            }
            
        }else {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络错误"];
            }
            
            self.searResultArr = nil;
            [self.myTable reloadData];
            [self.noDataView setHidden:NO];
        }
    }];
}

//加载无数据视图

- (LYEmptyView *)noDataView {
    if (!_noDataView) {
         _noDataView = [LYEmptyView emptyActionViewWithImage:image(@"ic_empty_data") titleStr:nil detailStr:nil btnTitleStr:@"重新加载" btnClickBlock:^{
            self->_isAllPage = NO;
             [self->_noDataView setHidden:YES];
            [self getData];
        }];
        [self.view addSubview:_noDataView];
    }
    return _noDataView;
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
    self.customNavBar.title = [self.searchType isEqualToString:@"1"] ? @"美食" : @"酒店";
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
        vc.urlString = url;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [WXZTipView showCenterWithText:@"click -line"];
    }
}

@end
