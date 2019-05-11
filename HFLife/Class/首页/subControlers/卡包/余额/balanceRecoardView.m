//
//  balanceRecoardView.m
//  HFLife
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "balanceRecoardView.h"
#import "BalanceListCell.h"
//#import "BaseViewController.h"
@interface balanceRecoardView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end


@implementation balanceRecoardView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChidrenViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChidrenViews];
    }
    return self;
}
- (void) addChidrenViews{
    [self addSubview:self.tableView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self);
    }];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BalanceListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BalanceListCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BalanceRecordModel *model = self.dataSourceArray[indexPath.row];
    cell.title = model.other_account;
    cell.typeString = model.log_class;
    cell.timer = model.createdate;
    cell.price = model.real_num;
    cell.payType = model.status;
    cell.isPayclose = [model.status isEqualToString:@"等待付款"];
    cell.iconImage = model.icon;
    return cell;
    
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *sectionHeaderV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthRatio(88))];
    
    UIView *incoderView = [[UIView alloc] init];
    incoderView.backgroundColor = HEX_COLOR(0x6F34D5);
    
    UILabel *titleLb = [UILabel new];
    titleLb.textColor = [UIColor blackColor];
    titleLb.font = [UIFont systemFontOfSize:WidthRatio(28)];
    titleLb.text = @"余额记录";
    
    [sectionHeaderV addSubview:incoderView];
    [sectionHeaderV addSubview:titleLb];
    
    [incoderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sectionHeaderV.mas_left).offset(WidthRatio(20));
        make.height.mas_equalTo(WidthRatio(32));
        make.width.mas_equalTo(WidthRatio(5));
        make.centerY.mas_equalTo(sectionHeaderV.mas_centerY);
    }];
    
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(incoderView.mas_right).offset(WidthRatio(19));
        make.centerY.mas_equalTo(incoderView.mas_centerY);
    }];
    sectionHeaderV.backgroundColor = [UIColor whiteColor];
    return sectionHeaderV;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    return;
    BalanceRecordModel *model = self.dataSourceArray[indexPath.row];
    if (model.vcName.length > 0) {
        Class vcclass = NSClassFromString(model.vcName);
        UIViewController *vc=  [[vcclass alloc] init];
//        vc.dataParameter = @{@"id":model.idStr};
        [vc setValue:@{@"id":model.idStr} forKey:@"dataParameter"];
        [self.superVC.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WidthRatio(174);
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return WidthRatio(88);
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[BalanceListCell class] forCellReuseIdentifier:NSStringFromClass([BalanceListCell class])];
    }
    
    return _tableView;
}

-(void)setDataSourceArray:(NSArray<BalanceRecordModel *> *)dataSourceArray{
    _dataSourceArray = dataSourceArray;
    [self.tableView reloadData];
}
@end
