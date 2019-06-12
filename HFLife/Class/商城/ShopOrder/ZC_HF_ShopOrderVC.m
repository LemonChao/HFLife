//
//  ZC_HF_ShopOrderVC.m
//  HFLife
//
//  Created by zchao on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "ZC_HF_ShopOrderVC.h"
#import "ZCShopOrderTableHeader.h"
#import "ZCShopOrderCell.h"
#import "ZCShopCouponsCell.h"
#import "ZCShopRuzhuCell.h"
#import "ZCShopOrderViewModel.h"

@interface ZC_HF_ShopOrderVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ZCShopOrderViewModel *viewModel;
@end

@implementation ZC_HF_ShopOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self getData];
    
}

- (void)setupNavBar {
    [super setupNavBar];
    [self.customNavBar wr_setBackgroundAlpha:0];
    self.customNavBar.backgroundColor = RGBA(1, 1, 1, 0);
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark - event response

- (void)getData {
    @weakify(self);
    [[self.viewModel.orderCenterCmd execute:nil] subscribeError:^(NSError * _Nullable error) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
    } completed:^{
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [(ZCShopOrderTableHeader*)self.tableView.tableHeaderView setModel:self.viewModel.model];
    }];
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return ScreenScale(135);
    }else {
        return ScreenScale(112);
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZCShopOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCShopOrderCell class])];
        cell.model = [NSObject new];
        return cell;

    }else if (indexPath.row == 1) {
        ZCShopCouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCShopCouponsCell class])];
        cell.model = [NSObject new];
        return cell;
    }else {
        ZCShopRuzhuCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCShopRuzhuCell class])];
        cell.model = [NSObject new];
        return cell;
    }
}


#pragma mark - getters and setters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TabBarHeight) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.tableHeaderView = [[ZCShopOrderTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(283))];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerClass:[ZCShopOrderCell class] forCellReuseIdentifier:NSStringFromClass([ZCShopOrderCell class])];
        [_tableView registerClass:[ZCShopCouponsCell class] forCellReuseIdentifier:NSStringFromClass([ZCShopCouponsCell class])];
        [_tableView registerClass:[ZCShopRuzhuCell class] forCellReuseIdentifier:NSStringFromClass([ZCShopRuzhuCell class])];
        
        @weakify(self);
        _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [self getData];
        }];
    }
    return _tableView;
}

- (ZCShopOrderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZCShopOrderViewModel alloc] init];
    }
    return _viewModel;
}


#pragma mark - private





@end
