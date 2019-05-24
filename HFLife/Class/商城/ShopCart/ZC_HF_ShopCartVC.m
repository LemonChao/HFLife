//
//  ZC_HF_ShopCartVC.m
//  HFLife
//
//  Created by zchao on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "ZC_HF_ShopCartVC.h"
#import "ZCShopCartTableViewCell.h"
#import "ZCShopCartSctionHeader.h"
#import "ZCShopCartTableHeaderFooter.h"
#import "ZCShopCartBottomView.h"
#import "ZCShopCartViewModel.h"


@interface ZC_HF_ShopCartVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ZCShopCartBottomView *bottomView;
@property(nonatomic, strong) ZCShopCartViewModel *viewModel;
@end

@implementation ZC_HF_ShopCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customNavBar.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom);
        make.bottom.equalTo(self.view).inset(TabBarHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(ScreenScale(49));
    }];
    
    [self bindViewModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.viewModel.cartCmd execute:nil];
    
}

- (void)setupNavBar {
    [super setupNavBar];
    
    self.customNavBar.title = @"购物车";
    @weakify(self);
    [self.customNavBar setOnClickRightButton:^{
        @strongify(self);
        [self.viewModel.deleteCmd execute:nil];
    }];
}




- (void)bindViewModel {
    
    @weakify(self);
    
    [[RACObserve(self, viewModel.cartArray) skip:1] subscribeNext:^(NSArray <__kindof ZCShopCartModel *> * _Nullable cartArray) {
        @strongify(self);
        if (cartArray.count) {
            ZCShopCartTableHeaderView *tableHeader = [[ZCShopCartTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(33))];
            tableHeader.title = [NSString stringWithFormat:@"共%@件商品", self.viewModel.totalCount];
            self.tableView.tableHeaderView = tableHeader;
            
            [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view).inset(TabBarHeight);
            }];
            
        }else {
            self.tableView.tableHeaderView = [[ZCShopCartEmptyHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(135)+115)];
            [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view).inset(TabBarHeight-49);
            }];
        }
        [self.customNavBar wr_setRightButtonWithTitle:cartArray.count?@"删除 ":@"" titleColor:AssistColor];
        [self.tableView reloadData];
    }];
    
}





- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZCShopCartSctionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([ZCShopCartSctionHeader class])];
    ZCShopCartModel *shopModel = self.viewModel.cartArray[section];
    header.model = shopModel;
  return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    return footer;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.cartArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZCShopCartModel *shopModel = self.viewModel.cartArray[section];
    
    return shopModel.goods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCShopCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCShopCartTableViewCell class])];
    ZCShopCartModel *shopModel = self.viewModel.cartArray[indexPath.section];

    cell.model = shopModel.goods[indexPath.row];
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.estimatedRowHeight = ScreenScale(96);
        _tableView.estimatedSectionHeaderHeight = ScreenScale(44);
        _tableView.estimatedSectionFooterHeight = ScreenScale(12);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = BackGroundColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
//        if (@available(iOS 11.0, *)) {
//            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        } else {
//            self.automaticallyAdjustsScrollViewInsets = NO;
//        }
        
        ZCShopCartTableFooterView *footer = [[ZCShopCartTableFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        footer.viewModel = self.viewModel;
        _tableView.tableFooterView = footer;
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
        [_tableView registerClass:[ZCShopCartSctionHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([ZCShopCartSctionHeader class])];
        [_tableView registerClass:[ZCShopCartTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ZCShopCartTableViewCell class])];
    }
    return _tableView;
}

- (ZCShopCartBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[ZCShopCartBottomView alloc] init];
        _bottomView.viewModel = self.viewModel;
    }
    return _bottomView;
}

- (ZCShopCartViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZCShopCartViewModel alloc] init];
    }
    return _viewModel;
}

@end
