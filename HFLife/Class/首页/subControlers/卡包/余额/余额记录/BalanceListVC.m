//
//  BalanceListVC.m
//  HFLife
//
//  Created by sxf on 2019/4/16.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "BalanceListVC.h"
#import "BalanceListCell.h"
//#import "CardBagRecordNetAPi.h"
@interface BalanceListVC ()<UITableViewDelegate,UITableViewDataSource>
{
//    CardBagRecordNetAPi *recordNetApi;
}
@property (nonatomic,strong)UITableView *contentTableView;
@property (nonatomic,strong) NSMutableArray <BalanceRecordModel *>*dataSourceArray;
@end

@implementation BalanceListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSourceArray = [NSMutableArray array];
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
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = self.titleStr;
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}
-(void)axcBaseRequestData{
    WS(weakSelf);
    /*
    if (!recordNetApi) {
        recordNetApi = [[CardBagRecordNetAPi alloc]initWithType:self.type];
    }
    [recordNetApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.contentTableView endLoadMore];
        [weakSelf.contentTableView endRefreshing];
        CardBagRecordNetAPi *recordRequest = (CardBagRecordNetAPi *)request;
        if ([[recordRequest getContent] isKindOfClass:[NSArray class]]) {
            NSArray *requestArr = (NSArray *)[recordRequest getContent];
            if (requestArr.count>0) {
                if ((self->recordNetApi.requestDataType == ListDropdownRefreshType)) {
                    [self.dataSourceArray removeAllObjects];
                }
                [self.dataSourceArray addObjectsFromArray:requestArr];
                [self deleteEmptyDataView];
                
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
-(void)initWithUI{
    [self.view addSubview:self.contentTableView];
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight);
            //        make.edges.mas_equalTo(self.view);
    }];
}
#pragma mark 列表代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return dataArray.count;
    return self.dataSourceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRatio(176);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BalanceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BalanceListCell"];
    if (!cell) {
        cell = [[BalanceListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"BalanceListCell"];
    }
    BalanceRecordModel *model = self.dataSourceArray[indexPath.row];
    cell.title = model.other_account;
    cell.typeString = model.log_class;
    cell.timer = model.createdate;
    cell.price = model.real_num;
    cell.payType = model.status;
    cell.isPayclose = [model.status isEqualToString:@"等待付款"];
    cell.iconImage = model.icon;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([self.type isEqualToString:@"0"]) {
        return;
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BalanceRecordModel *model = self.dataSourceArray[indexPath.row];
    if (model.vcName.length > 0) {
        Class vcclass = NSClassFromString(model.vcName);
        UIViewController *vc=  [[vcclass alloc] init];
            //        vc.dataParameter = @{@"id":model.idStr};
        [vc setValue:@{@"id":model.idStr, @"type" :self.type} forKey:@"dataParameter"];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
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
        
        
        /*
        
        [_contentTableView loadMoreDada:^{
            self->recordNetApi.requestDataType = ListPullOnLoadingType;
            [self axcBaseRequestData];
        }];
        [_contentTableView refreshingData:^{
            [self.dataSourceArray removeAllObjects];
            self->recordNetApi.requestDataType = ListDropdownRefreshType;
            [self axcBaseRequestData];
        }];
         
         */
//        _contentTableView.backgroundColor = [UIColor yellowColor];
    }
    return _contentTableView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
