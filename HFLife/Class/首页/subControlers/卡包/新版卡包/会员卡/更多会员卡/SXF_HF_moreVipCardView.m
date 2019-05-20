
//
//  SXF_HF_moreVipCardView.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_moreVipCardView.h"
#import "SXF_HF_moreVipCardCell.h"
@interface SXF_HF_moreVipCardView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)baseTableView *tableView;

@end

@implementation SXF_HF_moreVipCardView

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
    
    UIView *heaserV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(10))];
    heaserV.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableHeaderView = heaserV;
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXF_HF_moreVipCardCell *anyCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SXF_HF_moreVipCardCell class]) forIndexPath:indexPath];
    anyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [anyCell setDataForCell:@""];
    return anyCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    !self.selectRow ? : self.selectRow(indexPath);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenScale(94);
}

- (baseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[baseTableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = HEX_COLOR(0xF5F5F5);
        //cells
        [_tableView registerClass:[SXF_HF_moreVipCardCell class] forCellReuseIdentifier:NSStringFromClass([SXF_HF_moreVipCardCell class])];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}



@end
