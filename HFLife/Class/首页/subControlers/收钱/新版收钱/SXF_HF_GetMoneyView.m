
//
//  SXF_HF_GetMoneyView.m
//  HFLife
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_GetMoneyView.h"
#import "SXF_HF_getMoneyTabHeaderView.h"
#import "SXF_HF_getMoneyCellTableViewCell.h"
@interface SXF_HF_GetMoneyView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, strong)SXF_HF_getMoneyTabHeaderView *tableHeader;

@property (nonatomic, strong)UITableView *tableView;

@end



@implementation SXF_HF_GetMoneyView

- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self addChildrenViews];
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
    
    
    
    
    self.tableHeader = [[SXF_HF_getMoneyTabHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 432)];
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SXF_HF_getMoneyCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SXF_HF_getMoneyCellTableViewCell class])];
    self.tableView.tableFooterView = [UIView new];
    [self addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableHeader;
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = HEX_COLOR(0xCA1400);
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXF_HF_getMoneyCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SXF_HF_getMoneyCellTableViewCell class]) forIndexPath:indexPath];
    if (indexPath.section == 1) {
        cell.cellType = NO;
    }else{
        cell.cellType = YES;
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return 1.0f;
    }
    return 10.0f;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (void)layoutSubviews{
    [super layoutSubviews];
}



@end
