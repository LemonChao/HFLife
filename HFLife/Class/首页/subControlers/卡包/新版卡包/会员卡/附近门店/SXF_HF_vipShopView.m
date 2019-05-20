
//
//  SXF_HF_vipShopView.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_vipShopView.h"
#import "SXF_HF_vipShopCellTableViewCell.h"

@interface SXF_HF_vipShopView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)baseTableView *tableView;

@end


@implementation SXF_HF_vipShopView

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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
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
    SXF_HF_vipShopCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SXF_HF_vipShopCellTableViewCell class]) forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDataForCell:@""];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    !self.selectRow ? : self.selectRow(indexPath);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 49;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(49))];
    
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(ScreenScale(12), 0,200, sectionView.bounds.size.height)];
    titleLb.font = FONT(14);
    titleLb.textColor = HEX_COLOR(0xAAAAAA);
    [sectionView addSubview:titleLb];
    titleLb.textAlignment = NSTextAlignmentLeft;
    titleLb.text = @"仅展示您附近门店";

    sectionView.backgroundColor = HEX_COLOR(0xF5F5F5);
    return sectionView;
    
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
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = ScreenScale(90);
        //cells
        [_tableView registerClass:[SXF_HF_vipShopCellTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SXF_HF_vipShopCellTableViewCell class])];
    }
    return _tableView;
}
@end
