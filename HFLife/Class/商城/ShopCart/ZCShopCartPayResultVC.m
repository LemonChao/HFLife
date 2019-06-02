//
//  ZCShopCartPayResultVC.m
//  HFLife
//
//  Created by zchao on 2019/6/2.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopCartPayResultVC.h"
#import "ZCShopCartTableHeaderFooter.h"
#import "ZCShopCartViewModel.h"

@interface ZCShopCartPayResultVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ZCShopCartViewModel *viewModel;

@end

@implementation ZCShopCartPayResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self.viewModel.gussLikeResultCmd execute:nil];
}

- (void)setupNavBar {
    [super setupNavBar];
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar setTitle:@"支付成功"];
}

- (void)getData {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavBarHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = BackGroundColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
        ZCShopCartTableFooterView *footer = [[ZCShopCartTableFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        footer.viewModel = self.viewModel;
        _tableView.tableFooterView = footer;
        _tableView.tableHeaderView = [[ZCShopCartPayResultHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(150))];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}

- (ZCShopCartViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZCShopCartViewModel alloc] init];
    }
    return _viewModel;
}


@end
