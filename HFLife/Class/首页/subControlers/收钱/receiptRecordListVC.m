
//
//  receiptRecordListVC.m
//  HFLife
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "receiptRecordListVC.h"
#import "receiptRecordListView.h"
//#import "receiRecordNetApi.h"
@interface receiptRecordListVC ()
@property (nonatomic, strong)receiptRecordListView *listView;
@property (nonatomic, strong)NSMutableArray *listModelArr;
@end

@implementation receiptRecordListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    self.customNavBar.title = self.payType ? @"收款记录" : @"付款记录";
    self.listView = [[receiptRecordListView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];
    
    [self.view addSubview:self.listView];
    
    WS(weakSelf);
    self.listView.reloadData = ^(BOOL isUp) {
        if (isUp) {
            //上拉
//            [weakSelf getListDataType:ListPullOnLoadingType];
        }else{
            //下拉
//            [weakSelf getListDataType:ListDropdownRefreshType];
        }
    };
    
//    [self.listView.tableView beginRefreshing];
    
    
    //假数据
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<10; i++) {
        reciveModel *model = [[reciveModel alloc] init];
        model.log_date = @"2019-05";
        model.log_count = @(10);
        model.log_date_amount = @(10);
        subReciveModel *subModel = [[subReciveModel alloc] init];
        subModel.real_num = @(100);
        subModel.pay_username = @"sxf";
        subModel.createdate = @"2019-06";
        subModel.createtime = @"2019-09";
        model.logModelArr = @[subModel, subModel,subModel, subModel,subModel, subModel,subModel, subModel,subModel, subModel];
        [arr addObject:model];
    }
    self.listView.reciveModelArr = arr;
    
}


/*
- (void) getListDataType:(ListRequestDataType)requestType{
    receiRecordNetApi *receiApi = [[receiRecordNetApi alloc] initWithParameter:@{}];
    receiApi.requestDataType = requestType;
    [receiApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.listView.tableView endLoadMore];
        [self.listView.tableView endUpdates];
        [self deleteEmptyDataView];
        receiRecordNetApi *receiRequest = (receiRecordNetApi *)request;
        if ([receiRequest getCodeStatus]) {
             [self.listView.tableView endRefreshing];
            NSArray *array = [receiRequest getContent];
            self.listModelArr = array.mutableCopy;
            self.listView.reciveModelArr = self.listModelArr;
            if (self.listModelArr.count == 0 &&
                [receiApi.requestArgument[@"page"] integerValue] == 1) {
                self.listView.hidden = YES;
                [WXZTipView showCenterWithText:@"暂无数据"];
                [self initEmptyDataViewbelowSubview:self.customNavBar touchBlock:^{
                    //数显数据
                    [self getListDataType:ListDropdownRefreshType];
                }];
            }else{
                self.listView.hidden = NO;
            }
        }else{
            [WXZTipView showCenterWithText:@"暂无数据"];
            self.listView.hidden = YES;
            [self initEmptyDataViewbelowSubview:self.customNavBar touchBlock:^{
                //数显数据
                [self getListDataType:ListDropdownRefreshType];
            }];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [WXZTipView showCenterWithText:@"获取列表失败！"];
        self.listView.hidden = YES;
        [self initEmptyDataViewbelowSubview:self.customNavBar touchBlock:^{
            //数显数据
            [self getListDataType:ListDropdownRefreshType];
        }];
    }];
    
}
 */



- (NSMutableArray *)listModelArr{
    if (!_listModelArr) {
        _listModelArr = [NSMutableArray array];
    }
    return _listModelArr;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

@end
