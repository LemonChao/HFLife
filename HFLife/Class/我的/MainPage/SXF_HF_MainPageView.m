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
@end

@implementation SXF_HF_MainPageView
{
    NSArray *_titleArr;
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
    self.tableView.mj_footer = nil;
    self.tableView.mj_header = nil;
}

- (void)layoutSubviews{
    [super layoutSubviews];
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
        cell.modelArr = @[@"", @"", @""];
        cell.selectItemBlock = ^(NSInteger index) {
            !weakSelf.selectedItemCallback? : weakSelf.selectedItemCallback([NSIndexPath indexPathForRow:index inSection:indexPath.section]);
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
        return ScreenScale(180);
    }else{
        return 50;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ScreenScale(40);
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
        _tableView = [[baseTableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //header
        [_tableView registerClass:[SXF_HF_MianPageSectionView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SXF_HF_MianPageSectionView class])];
        //cells
        [_tableView registerClass:[SXF_HF_MainPageCycleScrollCell class] forCellReuseIdentifier:NSStringFromClass([SXF_HF_MainPageCycleScrollCell class])];
        [_tableView registerClass:[SXF_HF_MainPageMenuCell class] forCellReuseIdentifier:NSStringFromClass([SXF_HF_MainPageMenuCell class])];
        
    }
    return _tableView;
}

- (SXF_HF_MainTableHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[SXF_HF_MainTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(210))];
    }
    return _headerView;
}
@end
