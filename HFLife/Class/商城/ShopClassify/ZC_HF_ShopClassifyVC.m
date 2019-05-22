//
//  ZC_HF_ShopClassifyVC.m
//  HFLife
//
//  Created by zchao on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "ZC_HF_ShopClassifyVC.h"
#import "ZC_HF_ShopHomeSearchButton.h"
#import "ZCShopClassifyLeftCell.h"
#import "ZC_HF_ClassifyRightVC.h"
#import "ZCClassifyViewModel.h"

@interface ZC_HF_ShopClassifyVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *leftTableView;
@property(nonatomic, strong) ZCClassifyViewModel *viewModel;
@property(nonatomic, strong) ZC_HF_ClassifyRightVC *rightVC;
@end

@implementation ZC_HF_ShopClassifyVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"分类";
    
    [self.view addSubview:self.leftTableView];
    self.rightVC = [[ZC_HF_ClassifyRightVC alloc] init];
    [self addChildViewController:self.rightVC];
    [self.view addSubview:self.rightVC.view];

    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.top.equalTo(self.customNavBar.mas_bottom);
        make.width.mas_equalTo(ScreenScale(84));
    }];
    [self.rightVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.view);
        make.left.equalTo(self.leftTableView.mas_right);
    }];
    

    [self getData];
}

- (void)setupNavBar {
    [super setupNavBar];
    
    ZC_HF_ShopHomeSearchButton *searchBtn = [[ZC_HF_ShopHomeSearchButton alloc] initWithFrame:CGRectMake(ScreenScale(12), self.navBarHeight-28-8, SCREEN_WIDTH- ScreenScale(45), 28)];
    searchBtn.backgroundColor = BackGroundColor;
    [self.customNavBar addSubview:searchBtn];
}

#pragma mark - event response

- (void)getData{
    [[self.viewModel.classifyCmd execute:nil] subscribeNext:^(id  _Nullable x) {
        if ([x boolValue]) {
            [self.leftTableView reloadData];
            [self selectedIndex:0];
        }
        
    } error:^(NSError * _Nullable error) {
        
    }];
}

- (void)selectedIndex:(NSUInteger)index {
    if (self.viewModel.dataArray.count) {
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        ZCShopClassifyModel *model = self.viewModel.dataArray[index];
        self.rightVC.dataArray = model.class_list;
    }
}
#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScreenScale(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCShopClassifyLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCShopClassifyLeftCell class])];
    ZCShopClassifyModel *model = self.viewModel.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCShopClassifyModel *model = self.viewModel.dataArray[indexPath.row];

    self.rightVC.dataArray = model.class_list;
}


#pragma mark - getters and setters
- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.showsHorizontalScrollIndicator = NO;
        [_leftTableView registerClass:[ZCShopClassifyLeftCell class] forCellReuseIdentifier:NSStringFromClass([ZCShopClassifyLeftCell class])];
        _leftTableView.backgroundColor = BackGroundColor;
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
    }
    return _leftTableView;
}

- (ZCClassifyViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZCClassifyViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - private




@end
