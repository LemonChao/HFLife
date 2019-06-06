
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

@property (nonatomic, strong)NSString *currentDate;

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
    
    WS(weakSelf);
    
    
    
    
    //获取当前日期
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    self.currentDate = destDateString;
    
    
    
    
    self.tableView.refreshHeaderBlock = ^{
        //上拉
        !weakSelf.refreshData ? : weakSelf.refreshData(weakSelf.tableView.page, weakSelf.currentDate );
    };
    
    self.tableView.refreshFooterBlock = ^{
       //下拉
       !weakSelf.refreshData ? : weakSelf.refreshData(weakSelf.tableView.page, weakSelf.currentDate);
    };
    [self.tableView beginRefreshing];
}



- (void)chooseTime:(UIButton *)sender{
    [SXF_HF_AlertView showTimeSlecterAlertComplete:^(NSString * _Nonnull year, NSString * _Nonnull month) {
        //拼接
        NSString *dateStr = [NSString stringWithFormat:@"%@-%@", year, month];
        self.currentDate = dateStr;
        [self.tableView beginRefreshing];
    }];
}

- (void)setDataSourceArr:(NSArray<payRecordModel *> *)dataSourceArr{
    _dataSourceArr = dataSourceArr;
    [self.tableView reloadData];
}

- (void)setReciveModelArr:(NSArray<reciveModel *> *)reciveModelArr{
    _reciveModelArr = reciveModelArr;
    
//    [self.tableView reloadData];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    reciveModel *model = self.reciveModelArr[section];
//    if ([model.log_count integerValue] > 0) {
//        return self.data[section].logModelArr.count;
//    }
    return self.dataSourceArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *anyCell;
    {
        receiptRecordListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([receiptRecordListCell class]) forIndexPath:indexPath];
        payRecordModel *model = self.dataSourceArr[indexPath.row];
        [cell setDataForCell:model];
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
    [btn addTarget:self action:@selector(chooseTime:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:color0C0B0B forState:UIControlStateNormal];
    [header addSubview:btn];
    
    
    
    
    header.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    return header;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        return 88;
//    }
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




- (baseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[baseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
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
