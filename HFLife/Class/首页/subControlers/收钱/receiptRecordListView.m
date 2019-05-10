
//
//  receiptRecordListView.m
//  HanPay
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "receiptRecordListView.h"
#import "receiptRecordCell.h"
#import "receiptRecordListCell.h"
#import "UITableView+Refresh.h"
@interface receiptRecordListView()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation receiptRecordListView



- (instancetype)init{
    self = [super init];
    if (self) {
        [self addChilrenViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChilrenViews];
    }
    return self;
}
- (void) addChilrenViews{
    [self addSubview:self.tableView];
    [self.tableView beginRefreshing];
    WS(weakSelf);
    [self.tableView refreshingData:^{
        !weakSelf.reloadData ? : weakSelf.reloadData(NO);//下拉
    }];
    
    
    [self.tableView loadMoreDada:^{
        !weakSelf.reloadData ? : weakSelf.reloadData(YES);//上拉
    }];
}






- (void)setReciveModelArr:(NSArray<reciveModel *> *)reciveModelArr{
    _reciveModelArr = reciveModelArr;
    [self.tableView reloadData];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.reciveModelArr.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    reciveModel *model = self.reciveModelArr[section];
    if ([model.log_count integerValue] > 0) {
        return self.reciveModelArr[section].logModelArr.count + 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *anyCell;
    reciveModel *model = self.reciveModelArr[indexPath.section];
    if (indexPath.row == 0) {
        receiptRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([receiptRecordCell class]) forIndexPath:indexPath];
        [cell setDataForCell:model];
        anyCell = cell;
    }else{
        receiptRecordListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([receiptRecordListCell class]) forIndexPath:indexPath];
        subReciveModel *sunModel = model.logModelArr[indexPath.row - 1];
        [cell setDataForCell:sunModel];
        anyCell = cell;
    }
    anyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return anyCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 51)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 200, header.frame.size.height)];
    title.text = @"2019年3月21";
    reciveModel *model = self.reciveModelArr[section];
    if ([model.log_count integerValue] == 0) {
        header.hidden = YES;
    }else{
        header.hidden = NO;
        title.text = model.log_date;
    }
    [header addSubview:title];
    header.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    return header;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 88;
    }
    return 85;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    reciveModel *model = self.reciveModelArr[section];
    if ([model.log_count integerValue] == 0) {
        return 0.01;
    }
    return 51;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}




- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100;
        _tableView.separatorColor = HEX_COLOR(0xE1E1E1);
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_tableView registerClass:[receiptRecordCell class] forCellReuseIdentifier:NSStringFromClass([receiptRecordCell class])];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[receiptRecordListCell class] forCellReuseIdentifier:NSStringFromClass([receiptRecordListCell class])];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
@end
