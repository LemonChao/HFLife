//
//  SXF_HF_HomePageView.m
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_HomePageView.h"
#import "SXF_HF_HomePageTableHeader.h"


@interface SXF_HF_HomePageView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)SXF_HF_HomePageTableHeader *tableHeader;
@property (nonatomic, strong)baseTableView *tableView;
@end


@implementation SXF_HF_HomePageView

{
    NSArray *_titleArr;
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
    _titleArr = @[@"活动推荐", @"汉富头条"];
    
    [self addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableHeader;
    
    
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.font = [UIFont systemFontOfSize:18 weight:1.5];
    titleLb.textColor = HEX_COLOR(0x131313);
    titleLb.text = _titleArr[section];
    [sectionHeader addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sectionHeader.mas_left).offset(12);
        make.height.mas_equalTo(40);
    }];
    
    return sectionHeader;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}


- (baseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[baseTableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    
    return _tableView;
}
- (SXF_HF_HomePageTableHeader *)tableHeader{
    if (!_tableHeader) {
        _tableHeader = [[SXF_HF_HomePageTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(290))];
    }
    return _tableHeader;
}


@end
