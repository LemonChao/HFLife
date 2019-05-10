//
//  RichRightListVC.m
//  HFLife
//
//  Created by sxf on 2019/4/20.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "RichRightListVC.h"
#import "RichRightRecordCell.h"
//#import "FQ_incomeRecordNetApi.h"
@interface RichRightListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_sectionArray;
}
@property (nonatomic,strong)UITableView *contentTableView;
//@property (nonatomic, strong)FQ_incomeRecordNetApi *recordNetApi;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@end

@implementation RichRightListVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.dataSourceArray = [NSMutableArray array];
    _sectionArray = @[@"2019年04月",@"2019年03月",@"2019年01月",@"2018年12月"];
    [self initWithUI];
    [self setupNavBar];
    [self axcBaseRequestData];
    self.dataSourceArray = [NSMutableArray array];
}














-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)initWithUI{
    [self.view addSubview:self.contentTableView];
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(self.navBarHeight);
    }];
}
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = self.vcTitle;
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    
}



-(void)axcBaseRequestData{
    WS(weakSelf);
    NSDictionary *param;
    if (self.recordType == 0) {
        param = @{@"t" : @"get_dynamic_dh_log"};
    }else if (self.recordType == 1){
        param = @{@"t" : @"static_coin_exchange_log",
                  @"type" : @"1"
                  };
    }else if (self.recordType == 2){
        param = @{@"t" : @"static_coin_exchange_log",
                  @"type" : @"2"
                  };
    }
    /*
    if (!self.recordNetApi) {
        self.recordNetApi = [[FQ_incomeRecordNetApi alloc] initWithParameter:param];
    }
//    self.recordNetApi.requestUrl = @"";
    [self.recordNetApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.contentTableView endLoadMore];
        [weakSelf.contentTableView endRefreshing];
        FQ_incomeRecordNetApi *recordRequest = (FQ_incomeRecordNetApi *)request;
        if ([[recordRequest getContent] isKindOfClass:[NSArray class]]) {
            NSArray *requestArr = (NSArray *)[recordRequest getContent];
            if (requestArr.count>0) {
                if ((self.recordNetApi.requestDataType == ListDropdownRefreshType)) {
                    [self.dataSourceArray removeAllObjects];
                }
                [self.dataSourceArray addObjectsFromArray:requestArr];
                [self deleteEmptyDataView];
                
                
                //组装
                [weakSelf exchangeDataSource];
            }else{
                if (self.dataSourceArray.count == 0) {
                    [self initEmptyDataViewbelowSubview:self.customNavBar touchBlock:^{
                        [weakSelf axcBaseRequestData];
                    }];
                }else{
                    [self deleteEmptyDataView];
                }
            }
            [weakSelf.contentTableView reloadData];
            if (requestArr.count<10) {
                [weakSelf.contentTableView setLoadMoreViewHidden:YES];
            }
            
        }else{
            if (self.dataSourceArray.count == 0) {
                [self initEmptyDataViewbelowSubview:self.customNavBar touchBlock:^{
                    [weakSelf axcBaseRequestData];
                }];
            }
            
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
     
     */
}










#pragma mark 列表代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    incomeRecord *model  = self.dataSourceArray[section];
    return model.logModelArr.count;
//    return self.dataSourceArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [tableView cellHeightForIndexPath:indexPath model:self.cellTitleArray keyPath:@"titleArray" cellClass:[RichRightRecordCell class] contentViewWidth:[self cellContentViewWith]];
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RichRightRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RichRightRecordCell"];
    if (!cell) {
        cell = [[RichRightRecordCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"RichRightRecordCell"];
    }
    //组装cell数据
    incomeRecord *model = self.dataSourceArray[indexPath.section];
    subIncomeRecord *subModel = model.logModelArr[indexPath.row];
    cell.titleArray = self.cellTitleArray;
    if (self.cellTitleArray.count == 2) {
        cell.isMarked = YES;
        cell.valueArray = @[subModel.real_num, subModel.createdate];
    }else if (self.cellTitleArray.count == 3){
        
        if (self.recordType == 1) {
            //兑换
            cell.valueArray = @[subModel.real_num, [NSString stringWithFormat:(self.recordType == 2) ? @"%@元" : @"%@份", subModel.acc_num], subModel.createdate];
        }else{
            cell.valueArray = @[subModel.acc_num, [NSString stringWithFormat:(self.recordType == 2) ? @"%@元" : @"%@份", subModel.real_num], subModel.createdate];
        }
        
        
        cell.isMarked = NO;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeightRatio(74))];
    headView.backgroundColor = HEX_COLOR(0xEEEEEE);
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    titleLabel.textColor = HEX_COLOR(0x999999);
    titleLabel.text = _sectionArray[section];
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView.mas_left).offset(WidthRatio(38));
        make.centerY.mas_equalTo(headView.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HeightRatio(74);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
#pragma mark 懒加载
-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                         style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
            //        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = HEX_COLOR(0xffffff);
            //        _contentTableView.bounces = NO;
        _contentTableView.tableFooterView = [UIView new];
        _contentTableView.tableHeaderView = [UIView new];
//        [_contentTableView loadMoreDada:^{
//            self->recordNetApi.requestDataType = ListPullOnLoadingType;
//            [self axcBaseRequestData];
//        }];
//        [_contentTableView refreshingData:^{
//            [self.dataSourceArray removeAllObjects];
//            self->recordNetApi.requestDataType = ListDropdownRefreshType;
//            [self axcBaseRequestData];
//        }];
            //            //        _contentTableView.backgroundColor = [UIColor yellowColor];
    }
    return _contentTableView;
}



//组装数据源
- (void) exchangeDataSource{
//    listVc.cellTitleArray = @[@"兑换总额", @"兑换到富权",@"时间"];
//    listVc.cellValueArray = @[@"-1453.2546251487", @"1.0546287593份",@"2019-04-20"];
    NSMutableArray *arrM = [NSMutableArray array];
    for (incomeRecord *model in self.dataSourceArray) {
        //组装标题
        [arrM addObject:model.month];
    }
    _sectionArray = [arrM copy];
}



@end
