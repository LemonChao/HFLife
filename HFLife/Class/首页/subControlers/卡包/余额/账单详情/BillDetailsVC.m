//
//  BillDetailsVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/4/17.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "BillDetailsVC.h"
#import "BillDetailsCell.h"
#import "HeadUserView.h"
@interface BillDetailsVC ()<UITableViewDelegate,UITableViewDataSource>

/**
 容器
 */
@property (nonatomic, strong)UITableView *tableView;

/**
 头部视图
 */
@property (nonatomic, strong)UIView *headerView;

/**
 信息
 */
@property (nonatomic, strong)HeadUserView *informationView;

/**
 金额
 */
@property (nonatomic, strong)UILabel *moneyLb;

/**
 订单类型
 */
@property (nonatomic, strong)UILabel *typeLb;
@end

@implementation BillDetailsVC
{
    NSArray <NSArray <NSString *>*>*titleArr;
    NSArray <NSArray <NSString *>*>*valueArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    self.view.backgroundColor = HEX_COLOR(0xEEEEEE);
    titleArr = @[@[@"付款方式", @"账单分类"], @[@"创建时间",@"订单号",@"商家订单号"]];
    valueArr = @[@[@"余额", @"其他"], @[@"2019-01-01 09:55:16", @"16425487513942674521",@"商家可扫码退款或查询交易"]];
    [self setUpTableView];
}
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"账单详情";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void) setUpTableView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthRatio(290))];
    self.headerView = headerView;
    [self.view addSubview:self.tableView];
    
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    self.informationView = [[HeadUserView alloc]init];
    [headerView addSubview:self.informationView];
    
        //    [informationBtn sd_setImageWithURL:[NSURL URLWithString:@""] forState:(UIControlStateNormal)];
    self.typeLb = [UILabel new];
    self.moneyLb = [UILabel new];
    
    
    [headerView addSubview:self.typeLb];
    [headerView addSubview:self.moneyLb];
    
    
    self.moneyLb.text  = @"-23.84";
    self.typeLb.text = @"等待付款";
    self.moneyLb.textColor = HEX_COLOR(0x333333);
    self.moneyLb.font  = [UIFont systemFontOfSize:WidthRatio(56)];
    
    
    self.typeLb.textColor = HEX_COLOR(0xEA4B2C);
    self.typeLb.font = [UIFont systemFontOfSize:WidthRatio(24)];
    
    
    
    
        //    [self.bankImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.mas_equalTo(headerView.mas_left).offset(WidthRatio(234));
        //        make.top.mas_equalTo(headerView.mas_top).offset(WidthRatio(40));
        //        make.width.height.mas_equalTo(WidthRatio(51));
        //
        //    }];
    [self.informationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headerView.mas_centerX);
            //        make.left.right.mas_equalTo(headerView);
        make.top.mas_equalTo(headerView.mas_top).offset(HeightRatio(30));
        make.height.mas_equalTo(HeightRatio(51));
    }];
        //    [self.bankNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.mas_equalTo(self.bankImageV.mas_right).offset(WidthRatio(10));
        //        make.centerY.mas_equalTo(self.bankImageV.mas_centerY);
        //    }];
    
    [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.informationView.mas_bottom).offset(WidthRatio(49));
        make.centerX.mas_equalTo(self.headerView.mas_centerX);
    }];
    
    [self.typeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.moneyLb.mas_centerX);
        make.top.mas_equalTo(self.moneyLb.mas_bottom).offset(WidthRatio(30));
    }];
    
    
    
    UIView *sectionV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthRatio(122))];
    sectionV.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLb = [UILabel new];
    titleLb.frame = CGRectMake(WidthRatio(30), 0, 100, sectionV.frame.size.height);
    titleLb.font = [UIFont systemFontOfSize:12];
    titleLb.textColor = [UIColor blackColor];
    titleLb.text = @"标签和备注";
    UIButton *btn = [UIButton new];
    [btn setTitle:@"添加" forState:UIControlStateNormal];
    [btn setTitleColor:HEX_COLOR(0x999999) forState:UIControlStateNormal];
        //    [btn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    btn.frame = CGRectMake(SCREEN_WIDTH - WidthRatio(30) - 60, 0, 60, sectionV.frame.size.height);
    [sectionV addSubview:titleLb];
    [sectionV addSubview:btn];
    
    self.tableView.tableFooterView = sectionV;
    
    self.tableView.tableHeaderView = headerView;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArr[section].count;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == (titleArr[indexPath.section].count-1)) {
        NSLog(@"%ld ==== %ld",indexPath.section,indexPath.row);
        BillDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BillDetailsCell"];
        if (!cell) {
            cell = [[BillDetailsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"BillDetailsCell"];
        }
        cell.textLabel.text = titleArr[indexPath.section][indexPath.row];
        cell.detailTextLabel.text = valueArr[indexPath.section][indexPath.row];
            // 禁止cell点击选中
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    cell.textLabel.textColor = HEX_COLOR(0x999999);
    
    cell.detailTextLabel.font = cell.textLabel.font;
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = titleArr[indexPath.section][indexPath.row];
    cell.detailTextLabel.text = valueArr[indexPath.section][indexPath.row];
        // 禁止cell点击选中
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section>0&&indexPath.row == titleArr[indexPath.section].count-1) {
        return HeightRatio(297);
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return WidthRatio(10);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor whiteColor];
        _tableView.backgroundColor = HEX_COLOR(0xEEEEEE);
            //        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    
    return _tableView;
}
-(void)setDataParameter:(id)dataParameter{
    NSLog(@"dataParameter = %@",dataParameter);
}
@end
