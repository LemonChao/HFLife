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

@interface ZC_HF_ShopOrderVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ZC_HF_ShopOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.view);
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self getData];
    }];
}

- (void)setupNavBar {
    [super setupNavBar];
    [self.customNavBar wr_setBackgroundAlpha:0];
    self.customNavBar.backgroundColor = RGBA(1, 1, 1, 0);
}

#pragma mark - event response

- (void)getData {
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return ScreenScale(135);
    }else {
        return ScreenScale(105);
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
        ZCShopCouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCShopCouponsCell class])];
        cell.model = [NSObject new];
        return cell;
    }
    
}


#pragma mark - getters and setters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.tableHeaderView = [[ZCShopOrderTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(280))];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerClass:[ZCShopOrderCell class] forCellReuseIdentifier:NSStringFromClass([ZCShopOrderCell class])];
        [_tableView registerClass:[ZCShopCouponsCell class] forCellReuseIdentifier:NSStringFromClass([ZCShopCouponsCell class])];
    }
    return _tableView;
}

#pragma mark - private





@end
