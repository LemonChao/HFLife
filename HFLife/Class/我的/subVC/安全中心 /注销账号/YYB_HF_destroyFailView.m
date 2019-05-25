//
//  YYB_HF_destroyFailView.m
//  HFLife
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_destroyFailView.h"
@interface YYB_HF_destroyFailView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *myTable;//

@end
@implementation YYB_HF_destroyFailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    self.myTable = [[UITableView alloc]init];
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.backgroundColor = HEX_COLOR(0xF5F5F5);

    self.myTable.tableHeaderView = [self headView];
    self.myTable.tableFooterView = [self footView];
    self.myTable.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self addSubview:self.myTable];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView removeAllSubviews];
    [cell.contentView addSubview:[self failView]];
    cell.contentView.backgroundColor = HEX_COLOR(0xF5F5F5);
    return cell;
}

//head
- (UIView *)headView {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 120)];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 5;
    
    UIImageView *imageVeiw = [UIImageView new];
//    imageVeiw.backgroundColor = [UIColor redColor];
    [imageVeiw setImage:image(@"icon_tip")];
    [view addSubview:imageVeiw];
    [imageVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).mas_offset(ScreenScale(44));
        make.centerX.mas_equalTo(view);
        make.width.height.mas_equalTo(ScreenScale(32));
    }];
    
    UILabel *titleLabel = [UILabel wh_labelWithText:@"报歉由于以下原因，注销账户失败" textFont:17 textColor:HEX_COLOR(0x0C0B0B) frame:CGRectZero];
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageVeiw.mas_bottom).mas_offset(ScreenScale(15));
        make.height.mas_equalTo(ScreenScale(17));
        make.centerX.mas_equalTo(view);
    }];
    
    
    return view;
}

//food

- (UIView *)footView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    UIButton *button = [UIButton wh_buttonWithTitle:@"确定" backColor:HEX_COLOR(0xCA1400) backImageName:nil titleColor:[UIColor whiteColor] fontSize:18 frame:CGRectZero cornerRadius:5];
    [button wh_addActionHandler:^{
        NSLog(@"click");
        if (self.sureBlock) {
            self.sureBlock();
        }
    }];
    
    [view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).mas_offset(ScreenScale(44));
        make.height.mas_equalTo(ScreenScale(44));
        make.left.mas_equalTo(ScreenScale(12));
        make.right.mas_equalTo(ScreenScale(-12));
    }];
    
    
    
    return view;
}
//cellVeiw

- (UIView *)failView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 90)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageVeiw = [[UIImageView alloc]initWithFrame:CGRectMake(12, 20, 14, 14)];
    [imageVeiw setImage:image(@"icon_fail")];
    [view addSubview:imageVeiw];
    
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(36, 20, 300, 0)];
    textLabel.font = FONT(14);
    textLabel.numberOfLines = 0;
    textLabel.text = self.tipMsg;
    [view addSubview:textLabel];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).mas_offset(20);
        make.left.mas_equalTo(view).mas_offset(36);
        make.width.mas_equalTo(ScreenScale(300));
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    return view;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
