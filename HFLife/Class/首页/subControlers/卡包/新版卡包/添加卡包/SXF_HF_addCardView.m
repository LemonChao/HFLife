
//
//  SXF_HF_addCardView.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_addCardView.h"
#import "SXF_HF_addCardSectionHeaderView.h"
#import "SXF_HF_addCardViewCell.h"
@interface SXF_HF_addCardView ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic, strong)baseTableView *tableView;

@end

@implementation SXF_HF_addCardView
{
    CGFloat tableHeaderH;
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
    tableHeaderH = 40.0f;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
    [self addSubview:self.tableView];
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    self.backgroundColor = HEX_COLOR(0xC2E5F5);
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(50))];
    [self addSubview:headerView];
    UILabel *titleLb = [UILabel new];
    titleLb.font = FONT(18);
    titleLb.textColor = color0C0B0B;
    [headerView addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView.mas_left).offset(ScreenScale(12));
        make.top.mas_equalTo(headerView.mas_top).offset(21);
        make.height.mas_equalTo(ScreenScale(17));
    }];
    titleLb.text = @"加入会员 享会员权益";
    
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXF_HF_addCardViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SXF_HF_addCardViewCell class]) forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.selectedItem = ^(NSInteger index) {
        NSIndexPath *indeP = [NSIndexPath indexPathForRow:index inSection:indexPath.section];
        !self.selectRow ? : self.selectRow(indeP);
    };
    
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SXF_HF_addCardSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SXF_HF_addCardSectionHeaderView class])];
    [headerView setDataForView:@""];
    headerView.clickSectionHeaderCallBack = ^{
        !self.moreCardCallback ? : self.moreCardCallback(section);
    };
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerV = [UIView new];
    footerV.backgroundColor = [UIColor whiteColor];
    return footerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenScale(130);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return tableHeaderH;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (baseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[baseTableView alloc] initWithFrame:CGRectMake(ScreenScale(12), ScreenScale(50), SCREEN_WIDTH - ScreenScale(24), self.bounds.size.height - (iPhoneX ? 34 : 20) - ScreenScale(50)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //header
        [_tableView registerClass:[SXF_HF_addCardSectionHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SXF_HF_addCardSectionHeaderView class])];
        //cells
        [_tableView registerClass:[SXF_HF_addCardViewCell class] forCellReuseIdentifier:NSStringFromClass([SXF_HF_addCardViewCell class])];
        _tableView.layer.cornerRadius = ScreenScale(5);
        _tableView.layer.masksToBounds = YES;
    }
    return _tableView;
}
//去掉UItableview headerview黏性(sticky)
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = tableHeaderH;  //sectionHeaderHeight
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

@end
