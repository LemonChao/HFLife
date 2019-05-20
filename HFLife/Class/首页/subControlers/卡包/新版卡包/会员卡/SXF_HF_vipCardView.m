//
//  SXF_HF_vipCardView.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_vipCardView.h"
#import "SXF_HF_vipCardCellTableViewCell.h"
#import "SXF_HF_vipCardHeaderV.h"
@interface SXF_HF_vipCardView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)baseTableView *tableView;
@property (nonatomic, strong)SXF_HF_vipCardHeaderV *tableViewHeaderV;
@end

@implementation SXF_HF_vipCardView

{
    NSArray *_titleArr;
    NSArray *_subTitleArr;
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
    [self addSubview:self.tableView];
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    _titleArr = @[@"附近门店", @"会员卡详情", @"公众号"];
    _subTitleArr = @[@"", @"", @"该商户暂无公众号"];
    self.tableViewHeaderV = [[SXF_HF_vipCardHeaderV alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(292))];
    self.tableView.tableHeaderView = self.tableViewHeaderV;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXF_HF_vipCardCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SXF_HF_vipCardCellTableViewCell class]) forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLb.text = _titleArr[indexPath.row];
    cell.subTitleLb.text = _subTitleArr[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    !self.selectRow ? : self.selectRow(indexPath);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenScale(53);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (baseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[baseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = HEX_COLOR(0xF5F5F5);
        //cells
        [_tableView registerClass:[SXF_HF_vipCardCellTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SXF_HF_vipCardCellTableViewCell class])];
    }
    return _tableView;
}

@end
