//
//  SXF_HF_MainPageView.m
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_MainPageView.h"
#import "SXF_HF_MainTableHeaderView.h"
#import "SXF_HF_MianPageSectionView.h"
#import "SXF_HF_MainPageCycleScrollCell.h"
#import "SXF_HF_MainPageMenuCell.h"
@interface SXF_HF_MainPageView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)baseTableView *tableView;
@property (nonatomic, strong)SXF_HF_MainTableHeaderView *headerView;
@property (nonatomic, strong)NSMutableArray *modelArrM;
@end

@implementation SXF_HF_MainPageView
{
    NSArray *_titleArr;
    CGFloat tableHeaderH;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    _titleArr = @[@"资产", @"综合服务"];
    [self addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.backgroundColor = rgb(245.0, 245.0, 245.0);
    self.tableView.refreshHeaderBlock = ^{
        
    };
    tableHeaderH = ScreenScale(40);
    self.tableView.mj_footer = nil;
    self.tableView.mj_header = nil;
}
- (void)refreshUser{
    userInfoModel *user = [userInfoModel sharedUser];
    NSArray *titleArr = @[@"余额", @"可兑换富权", @"富权"];
    NSArray *subTitleArr = @[@"可支付可提现", @"实时手动兑换", @"可变现"];
    NSArray *moneyArr = @[user.dynamic_shop, user.dynamic_dh, user.static_coin];
    NSArray *gifNameArr = @[@"mian余额.gif", @"mian可兑换.gif", @"mian富权.gif"];
    self.modelArrM = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        mainScrollModel *model = [[mainScrollModel alloc] init];
        model.title = titleArr[i];
        model.subTitle = subTitleArr[i];
        model.money = moneyArr[i];
        model.imageName = gifNameArr[i];
        [self.modelArrM addObject:model];
    }
    [self.tableView reloadData];
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

//设置数据
- (void)setMemberInfoModel:(userInfoModel *)memberInfoModel {
    _memberInfoModel = memberInfoModel;
    self.headerView.memberInfoModel = memberInfoModel;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 10;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *anyCell;
    WEAK(weakSelf);
    if (indexPath.section == 0) {
        SXF_HF_MainPageCycleScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SXF_HF_MainPageCycleScrollCell class]) forIndexPath:indexPath];
        cell.modelArr = self.modelArrM;
//        cell.modelArr = @[@"", @"", @""];
        cell.selectItemBlock = ^(NSInteger index) {
            !weakSelf.selectedItemCallback? : weakSelf.selectedItemCallback([NSIndexPath indexPathForRow:index inSection:indexPath.section]);
        };
        cell.autoScrollItemBlock = ^(NSInteger index) {
            //发通知 i修改 menu的背景色
            [NOTIFICATION postNotificationName:@"changeBgColor" object:@(index)];
        };
        anyCell = cell;
    }else
        if (indexPath.section == 1){
        SXF_HF_MainPageMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SXF_HF_MainPageMenuCell class]) forIndexPath:indexPath];
            cell.selecteItem = ^(NSInteger index) {
                !weakSelf.selectedItemCallback? : weakSelf.selectedItemCallback([NSIndexPath indexPathForRow:index inSection:indexPath.section]);
            };
        anyCell = cell;
    }else{
        anyCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    anyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return anyCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return (710.0 / 389.0) * 0.5 * SCREEN_WIDTH ;
    }else if (indexPath.section == 1){
        return ScreenScale(280);
    }else{
        return 50;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return tableHeaderH;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SXF_HF_MianPageSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SXF_HF_MianPageSectionView class])];
    sectionView.titleLb.text = _titleArr[section];
    return sectionView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (baseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[baseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //header
        [_tableView registerClass:[SXF_HF_MianPageSectionView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SXF_HF_MianPageSectionView class])];
        //cells
        [_tableView registerClass:[SXF_HF_MainPageCycleScrollCell class] forCellReuseIdentifier:NSStringFromClass([SXF_HF_MainPageCycleScrollCell class])];
        [_tableView registerClass:[SXF_HF_MainPageMenuCell class] forCellReuseIdentifier:NSStringFromClass([SXF_HF_MainPageMenuCell class])];
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

- (SXF_HF_MainTableHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[SXF_HF_MainTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(210))];
    }
    return _headerView;
}
//去掉UItableview headerview黏性(sticky)
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = tableHeaderH;  //sectionHeaderHeight
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}
@end
