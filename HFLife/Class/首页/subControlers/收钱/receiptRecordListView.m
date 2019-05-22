
//
//  receiptRecordListView.m
//  HFLife
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 sxf. All rights reserved.
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
    UIView *header = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,ScreenScale(54))];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 200, header.frame.size.height)];
    title.text = @"2019年3月21";
    reciveModel *model = self.reciveModelArr[section];
    if ([model.log_count integerValue] == 0) {
        header.hidden = YES;
    }else{
        header.hidden = NO;
        title.text = model.log_date;
    }
//    [header addSubview:title];
    
    if (section == 0) {
        title.text = @"本月";
    }else{
        title.text = @"2018年8月";
    }
    
    
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.cornerRadius = ScreenScale(12);
    [btn setTitle:title.text forState:UIControlStateNormal];
    btn.titleLabel.font = FONT(14);
    CGFloat btnW = [title.text isEqualToString:@"本月"] ? ScreenScale(60) : ScreenScale(100);
    btn.frame = CGRectMake(ScreenScale(12), (header.size.height - ScreenScale(24)) * 0.5, btnW, ScreenScale(24));
    [btn setImage:MY_IMAHE(@"三角下拉") forState:UIControlStateNormal];
    [btn setImagePosition:ImagePositionTypeRight WithMargin:10];
    
    [btn setTitleColor:color0C0B0B forState:UIControlStateNormal];
    [header addSubview:btn];
    
    
    
    
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
    return ScreenScale(54);
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
        _tableView.separatorColor = colorF5F5F5;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_tableView registerClass:[receiptRecordCell class] forCellReuseIdentifier:NSStringFromClass([receiptRecordCell class])];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[receiptRecordListCell class] forCellReuseIdentifier:NSStringFromClass([receiptRecordListCell class])];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
@end
