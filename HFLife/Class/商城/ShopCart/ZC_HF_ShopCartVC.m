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

@interface ZC_HF_ShopCartVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ZC_HF_ShopCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"购物车";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customNavBar.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(SCREEN_HEIGHT-88-TabBarHeight);
    }];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZCShopCartSctionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([ZCShopCartSctionHeader class])];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    return footer;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCShopCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCShopCartTableViewCell class])];
    
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
        
        _tableView.tableHeaderView = [[ZCShopCartTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(33))];
        _tableView.tableFooterView = [[ZCShopCartTableFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
        [_tableView registerClass:[ZCShopCartSctionHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([ZCShopCartSctionHeader class])];
        [_tableView registerClass:[ZCShopCartTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ZCShopCartTableViewCell class])];
    }
    return _tableView;
}

@end
