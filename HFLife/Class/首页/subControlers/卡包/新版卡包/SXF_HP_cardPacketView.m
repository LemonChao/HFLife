//
//  SXF_HP_cardPacketView.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HP_cardPacketView.h"
#import "SXF_HF_cardCellTableViewCell.h"
@interface SXF_HP_cardPacketView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)baseTableView *tableView;

@end


@implementation SXF_HP_cardPacketView

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
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXF_HF_cardCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SXF_HF_cardCellTableViewCell class]) forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 168;
}
- (baseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[baseTableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //header
       
        //cells
        [_tableView registerClass:[SXF_HF_cardCellTableViewCell class] forCellReuseIdentifier:NSStringFromClass([SXF_HF_cardCellTableViewCell class])];
    }
    return _tableView;
}

@end
