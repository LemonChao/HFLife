//
//  SynthesizeMerchantListVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/4/19.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "SynthesizeMerchantListVC.h"
#import "WKWebViewController.h"
#import "SynthesizeMerchantCell.h"
#import "MerchantsCell.h"
//#import "GetComprehensiveBusinessListNetApi.h"
@interface SynthesizeMerchantListVC ()<UITableViewDelegate,UITableViewDataSource>
{
//    GetComprehensiveBusinessListNetApi *getcb;
}
@property (nonatomic,strong)UITableView *contentTableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)NSArray *bannerArray;
@end

@implementation SynthesizeMerchantListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = [NSMutableArray array];
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
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar setOnClickRightButton:^{
        
    }];
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
//    self.customNavBar.title = self.titleString;
    NSString *title = @"";
    if ([self.type isEqualToString:@"1"]) {
        title = @"美在中国";
    }else if ([self.type isEqualToString:@"2"]){
        title = @"休闲娱乐";
    }else if ([self.type isEqualToString:@"3"]){
        title = @"超市生鲜";
    }else if ([self.type isEqualToString:@"4"]){
        title = @"结婚摄影";
    }else if ([self.type isEqualToString:@"5"]){
        title = @"亲子乐园";
    }
    self.customNavBar.title = title;
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}
-(void)initWithUI{
    [self.view addSubview:self.contentTableView];
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
}
-(void)axcBaseRequestData{
    WS(weakSelf);
//    if (!getcb) {
//        getcb = [[GetComprehensiveBusinessListNetApi alloc]initWithParameter:@{@"class_id":self.type}];
//    }
    NSDictionary *parm = @{@"class_id":self.type};
    [self.view showAlertViewToViewImageTYpe:IMAGETYPE_NOLIST msg:@"无数据" forView:TYPE_VIEW imageCenter:0 errorBlock:^{
        
    }];
//    [networkingManagerTool requestToServerWithType:POST withSubUrl:kGet_general_shop_list withParameters:parm withResultBlock:^(BOOL result, id value) {
//        
//        if (result) {
//            if (value && [value isKindOfClass:[NSDictionary class]]) {
//                NSDictionary *dict = value;
//                if ([dict isKindOfClass:[NSDictionary class]]) {
//                    self.bannerArray = dict[@"banner"];
//                    NSArray *array = dict[@"list"];
//                    [weakSelf.dataSource addObjectsFromArray:array];
//                    [weakSelf.contentTableView reloadData];
//                    if (array.count < 10) {
//                        //                        [weakSelf.contentTableView  setLoadMoreViewHidden:YES];
//                    }
//                }
//               
//            }else{
//                [WXZTipView showCenterWithText:@"暂无数据"];
////                [weakSelf.contentTableView  setLoadMoreViewHidden:YES];
//                
//            }
//            if (weakSelf.dataSource.count == 0 && (![self.bannerArray isKindOfClass:[NSArray class]]||self.bannerArray.count == 0)) {
//                
//            }else {
//                [self.view removeAlertView];
//            }
//            
//        }else {
//            [WXZTipView showCenterWithText:@"请求错误"];
//        }
//    }];
    
}
#pragma mark UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return dataArray.count;
    
    if (section==0&&([self.bannerArray isKindOfClass:[NSArray class]]&&self.bannerArray.count>0)) {
        return 1;
    }
    return self.dataSource.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.bannerArray isKindOfClass:[NSArray class]]&&self.bannerArray.count>0) {
        return 2;
    }else{
        return 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 &&([self.bannerArray isKindOfClass:[NSArray class]]&&self.bannerArray.count>0)) {
        SynthesizeMerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SynthesizeMerchantCell"];
        if (!cell) {
             cell = [[SynthesizeMerchantCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"SynthesizeMerchantCell"];
        }
        [cell setDataArr:self.bannerArray];
        
        return cell;
    }
    MerchantsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantsCell"];
    if (!cell) {
        cell = [[MerchantsCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"MerchantsCell"];
    }
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.titleString = [NSString judgeNullReturnString:dict[@"shop_name"]];
    cell.location = [NSString judgeNullReturnString:dict[@"shop_address"]];
    cell.benefit = [NSString judgeNullReturnString:dict[@"fan_percent"]];
    cell.distance = [NSString judgeNullReturnString:dict[@"distance"]];
    cell.iconString = [NSString judgeNullReturnString:dict[@"img_logo"]];;
    cell.star_level = [MMNSStringFormat(@"%@",dict[@"score_star"]) integerValue];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 &&([self.bannerArray isKindOfClass:[NSArray class]]&&self.bannerArray.count>0)) {
        return HeightRatio(344);
    }
    return HeightRatio(258);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, section == 0?HeightRatio(10):0.1)];
    footerView.backgroundColor = HEX_COLOR(0xeeeeee);
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 0?HeightRatio(10):0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.dataSource[indexPath.row];
    WKWebViewController *wkWebView = [[WKWebViewController alloc]init];
    wkWebView.isNavigationHidden = NO;
    wkWebView.urlString = dict[@"url"];
    wkWebView.webTitle = @"店铺详情";
    [self.navigationController pushViewController:wkWebView animated:YES];
}
-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.backgroundColor = HEX_COLOR(0xf5f8f8);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = HEX_COLOR(0xffffff);
        _contentTableView.tableFooterView = [UIView new];
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 10)];
        _contentTableView.tableHeaderView = headView;
//        [_contentTableView loadMoreDada:^{
//            self->getcb.requestDataType = ListPullOnLoadingType;
//            [self axcBaseRequestData];
//        }];
//        [_contentTableView refreshingData:^{
//            [self.dataSource removeAllObjects];
//            self->getcb.requestDataType = ListDropdownRefreshType;
//            [self axcBaseRequestData];
//        }];
    }
    return _contentTableView;
}

@end
