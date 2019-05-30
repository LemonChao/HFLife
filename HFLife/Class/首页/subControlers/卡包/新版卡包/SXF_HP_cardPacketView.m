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
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
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
    SXF_HF_cardCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SXF_HF_cardCellTableViewCell class]) forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    !self.selectRow ? : self.selectRow(indexPath);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenScale(175);
}
- (baseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[baseTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = HEX_COLOR(0xF5F5F5);
        //header
       
        //cells
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SXF_HF_cardCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SXF_HF_cardCellTableViewCell class])];
    }
    return _tableView;
}

@end
