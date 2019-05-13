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

@interface ZC_HF_ShopClassifyVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *leftTableView;

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
        make.width.mas_equalTo(84);
    }];
    [self.rightVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.view);
        make.left.equalTo(self.leftTableView.mas_right);
    }];
}

- (void)setupNavBar {
    [super setupNavBar];
    
    ZC_HF_ShopHomeSearchButton *searchBtn = [[ZC_HF_ShopHomeSearchButton alloc] initWithFrame:CGRectMake(ScreenScale(12), self.navBarHeight-28-8, SCREEN_WIDTH- ScreenScale(45), 28)];
    searchBtn.backgroundColor = BackGroundColor;
    [self.customNavBar addSubview:searchBtn];
}

#pragma mark - event response

- (void)loadServerData{
    [networkingManagerTool requestToServerWithType:POST withSubUrl:@"" withParameters:@{} withResultBlock:^(BOOL result, id value) {
        if (result){
        }
    }];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScreenScale(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCShopClassifyLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZCShopClassifyLeftCell class])];
    
    return cell;
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

#pragma mark - private




@end
