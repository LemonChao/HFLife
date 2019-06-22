//
//  FQ_homeTableV.m
//  HFLife
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "FQ_homeTableV.h"
#import "FQ_homeHeaderView.h"
@interface FQ_homeTableV ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)FQ_homeHeaderView *headerView;
@property (nonatomic, strong)NSArray *listModelArr;
@end

@implementation FQ_homeTableV
{
    NSArray <NSString *>*titleArr;
    NSArray <NSString *>*subTitleArr;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addChildrenViews];
    }
    return self;
}
- (void)setDataForView:(id)dataSource{
    if ([dataSource isKindOfClass:[NSDictionary class]]) {
        //解析数据
        NSArray *modelArr = [HR_dataManagerTool getModelArrWithArr:dataSource[@"data"][@"intro"] withClass:[introListModel class]];
        self.listModelArr = modelArr;
        [self.tableView reloadData];
    }
    
    //header
    self.headerView.dataSource = dataSource;
    
    
    
    
    
}
- (void) addChildrenViews{
    titleArr = @[@"1、可兑换富权怎么来的？可兑换富权怎么来的？可兑换富权怎么来的？", @"2、兑换成富权有哪些好处？", @"3、富权的增值？"];
    subTitleArr = @[@"通过购物消费，分享好友可得到可兑换付富权。通过购物消费，分享好友可得到可兑换付富权。", @"富权可增值，增加收益，取出到余额，能获得更大利益。", @"平台拿出商家的共享值，用于平台会员所有的富权增值。"];
    [self addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    WS(weakSelf);
    self.headerView.clickBtn = ^(NSInteger index) {
        
        !weakSelf.selectedBtn ? : weakSelf.selectedBtn(index);
    };
}



- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    introListModel *model = self.listModelArr[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = HEX_COLOR(0x999999);
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld、%@", indexPath.row + 1, model.intro_ask];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"        %@", model.intro_answer];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击%ld", indexPath.row);
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    sectionHeader.backgroundColor = [UIColor whiteColor];
    UIView *incoderView = [[UIView alloc] initWithFrame:CGRectMake(10, (49 - 21) * 0.5, 5, 21)];
    incoderView.backgroundColor = HEX_COLOR(0xFDB555);
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 200, sectionHeader.frame.size.height)];
    titleLb.font = [UIFont systemFontOfSize:15 weight:1.5];
    titleLb.textColor = [UIColor blackColor];
    titleLb.text = @"解释说明";
    
    UIView *bottomLineV = [[UIView alloc] initWithFrame:CGRectMake(0, 48, SCREEN_WIDTH, 1)];
    bottomLineV.backgroundColor = HEX_COLOR(0xE1E1E1);
    
    
    [sectionHeader addSubview:incoderView];
    [sectionHeader addSubview:titleLb];
    [sectionHeader addSubview:bottomLineV];
    return sectionHeader;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 49;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
}




- (FQ_homeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[FQ_homeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
    }
    return _headerView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
//        _tableView.autoHeight = 60;
    }
    
    return _tableView;
}

@end
