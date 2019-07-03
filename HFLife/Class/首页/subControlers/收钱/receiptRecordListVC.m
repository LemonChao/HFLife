
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
{
    NSString *_currentDate;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    self.customNavBar.title = self.payType ? @"收款记录" : @"付款记录";
    self.listView = [[receiptRecordListView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];
    
    [self.view addSubview:self.listView];
    self.listView.payType = self.payType;
    
    WS(weakSelf);
   
    self.listView.refreshData = ^(NSInteger page, NSString * _Nonnull dateStr) {
        [weakSelf loadServerData:page date:dateStr];
    };
}


- (void)loadServerData:(NSInteger)page date:(NSString *)date{
    self.listView.tableView.mj_footer.hidden = NO;
    //收款数据
    NSDictionary *param = @{
                            @"month":date,
                            @"page" : @(page),
                            };
    [networkingManagerTool requestToServerWithType:POST withSubUrl:SXF_LOC_URL_STR(QrcodeGetMoneyCore) withParameters:param withResultBlock:^(BOOL result, id value) {
        [self.listView.tableView endRefreshData];
        if (result){
            if (value) {
                if (value[@"data"][@"list"]) {
                    NSArray *modelsArr = [HR_dataManagerTool getModelArrWithArr:value[@"data"][@"list"] withClass:[payRecordModel class]];
                    if (page == 1) {
                        [self.listModelArr removeAllObjects];
                        self.listModelArr = [modelsArr mutableCopy];
                        self.listView.dataSourceArr = self.listModelArr;
                    }else{
                        [self.listModelArr addObjectsFromArray:modelsArr];
                        self.listView.dataSourceArr = self.listModelArr;
                        if (modelsArr.count < 10) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                //必须先结束刷新 在改变此状态
                                self.listView.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                            });
                            
                        }
                    }
                    
                    if (self.listModelArr.count == 0) {
                        self.listView.tableView.mj_footer.hidden = YES;
                        [self.listView.tableView showAlertViewToViewImageTYpe:IMAGETYPE_NOLIST msg:@"暂无数据" forView:TYPE_VIEW imageCenter:0 errorBlock:^{
                            [self.listView.tableView.mj_header beginRefreshing];
                        }];
                    }else{
                        [self.listView.tableView removeAlertView];
                    }
                    
                    
                }
            }
        }
    } witnVC:self];
}




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
