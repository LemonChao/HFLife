//
//  friendListView.m
//  HanPay
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "friendListView.h"
#import "friendViewCell.h"
@interface friendListView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UILabel *totolLb;
@end

@implementation friendListView

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
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setTotleTitle:(NSString *)totleTitle{
    _totleTitle = totleTitle;
    self.totolLb.text = _totleTitle;
}
- (void)setDataSourceArr:(NSArray *)dataSourceArr{
    _dataSourceArr = dataSourceArr;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    friendViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([friendViewCell class]) forIndexPath:indexPath];
    
    [cell setDataForCell:self.dataSourceArr[indexPath.row]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    friengListModel *friendModel = [friengListModel new];
    !self.selectedItem ? : self.selectedItem(indexPath.row, friendModel);
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WidthRatio(195);
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return WidthRatio(10);
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}




- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[friendViewCell class] forCellReuseIdentifier:NSStringFromClass([friendViewCell class])];
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = WidthRatio(195);
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorColor = HEX_COLOR(0xE1E1E1);
        _tableView.backgroundColor = [UIColor colorWithRed:243.0 / 255.0 green:243.0 / 255.0 blue:243.0 / 255.0 alpha:1.0];
        
        self.totolLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthRatio(106))];
        self.totolLb.textColor = HEX_COLOR(0x999999);
        self.totolLb.font = [UIFont systemFontOfSize:WidthRatio(28)];
        self.totolLb.textAlignment = NSTextAlignmentCenter;
        _tableView.tableFooterView = self.totolLb;
    }
    return _tableView;
}
@end
