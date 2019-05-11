
//
//  balanceOrderDetaileVC.m
//  HFLife
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "balanceOrderDetaileVC.h"
//#import "WithdrawalParticularsNetApi.h"
#import "RemarkBallView.h"
@interface balanceOrderDetaileVC ()<UITableViewDelegate, UITableViewDataSource>
/**
 账单ID
 */
@property (nonatomic,strong)NSString *orderID;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIImageView *bankImageV;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, strong)UILabel *bankNameLb;
@property (nonatomic, strong)UILabel *moneyLb;
@property (nonatomic, strong)UILabel *typeLb;

@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)NSString *remarkString;
@property (nonatomic, strong)NSString *type;
@end

@implementation balanceOrderDetaileVC
{
    NSArray <NSArray <NSString *>*>*titleArr;
     NSArray <NSArray <NSString *>*>*valueArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    self.view.backgroundColor = HEX_COLOR(0xEEEEEE);
    titleArr = @[@[@"付款方式", @"当前状态", @"服务费", @"提现银行"], @[@"申请时间", @"到账时间", @"提现单号"]];
    valueArr = @[@[@"余额", @"已到账", @"-0.10", @"工商银行"], @[@"2019-01-01 09:34:25", @"2019-01-01 09:55:16", @"16425487513942674521 "]];
    
    
    [self setUpTableView];
    [self axcBaseRequestData];
}
- (void)axcBaseRequestData{
    WS(weakSelf);
    /*
    WithdrawalParticularsNetApi *transfer = [[WithdrawalParticularsNetApi alloc]initWithParameter:@{@"id":self.orderID}];
    [transfer startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        WithdrawalParticularsNetApi *transferRequest = (WithdrawalParticularsNetApi *)request;
        if ([transferRequest getCodeStatus]==1) {
            NSDictionary *dict = [transferRequest getContent];
            if ([dict isKindOfClass:[NSDictionary class]]) {
                self->valueArr = @[@[[NSString judgeNullReturnString:dict[@"pay_type"]],
                                     [NSString judgeNullReturnString:dict[@"status"]],
                                     MMNSStringFormat(@"%@",dict[@"fee"]),
                                     [NSString judgeNullReturnString:dict[@"bank_name"]]],
                                   @[[NSString judgeNullReturnString:dict[@"createdate"]],
                                     [NSString judgeNullReturnString:dict[@"arrivedate"]],
                                     [NSString judgeNullReturnString:dict[@"log_sn"]]]];
                    //
                weakSelf.moneyLb.text  = [NSString judgeNullReturnString:dict[@"real_num"]];
                weakSelf.typeLb.text = [NSString judgeNullReturnString:dict[@"status"]];
                if ([weakSelf.typeLb.text isEqualToString:@"等待付款"]) {
                    weakSelf.typeLb.textColor = HEX_COLOR(0xEA4B2C);
                }else{
                    weakSelf.typeLb.textColor = HEX_COLOR(0x999999);
                }
                [weakSelf.bankImageV sd_setImageWithURL:[NSURL URLWithString:[NSString judgeNullReturnString:dict[@"icon"]]] placeholderImage:MMGetImage(@"barCode_icon")];
                weakSelf.bankNameLb.text = [NSString judgeNullReturnString:dict[@"account_name"]];
                weakSelf.remarkString = [NSString judgeNullReturnString:dict[@"tag_remark"]];
                weakSelf.contentLabel.text = [NSString isNOTNull:self.remarkString]? @"添加":self.remarkString;
                [weakSelf.tableView reloadData];
            }else{
                [WXZTipView showCenterWithText:@"账单详情数据出错"];
            }
        }else{
            [WXZTipView showCenterWithText:[transferRequest getMsg]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [WXZTipView showCenterWithText:@"账单详情数据出错"];
    }];
     
     */
    
}
//添加
- (void) addBtnClick{
    WS(weakSelf);
    RemarkBallView *remark = [[RemarkBallView alloc] initWithTitleImage:@"" messageTitle:@"请填写备注" messageString:self.remarkString sureBtnTitle:@"确定" sureBtnColor:[UIColor blueColor]];
    remark.billID = self.orderID;
    [remark setSureClick:^(NSString * _Nonnull string) {
        weakSelf.remarkString = [NSString judgeNullReturnString:string];
        weakSelf.contentLabel.text = [NSString isNOTNull:self.remarkString]? @"添加":self.remarkString;
    }];
}



- (void) setUpTableView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthRatio(290))];
    self.headerView = headerView;
    [self.view addSubview:self.tableView];
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    self.bankImageV = [UIImageView new];
    self.bankNameLb = [UILabel new];
    self.typeLb = [UILabel new];
    self.moneyLb = [UILabel new];
    
    [headerView addSubview:self.bankImageV];
    [headerView addSubview:self.bankNameLb];
    [headerView addSubview:self.typeLb];
    [headerView addSubview:self.moneyLb];
    
    
    
    
    self.bankNameLb.text = @"余额提现-工商银行";
    self.moneyLb.text  = @"-23.84";
    self.typeLb.text = @"交易成功";
    
//    self.bankImageV.backgroundColor = [UIColor redColor];
    
    
    self.bankNameLb.font = [UIFont systemFontOfSize:WidthRatio(26)];
    self.bankNameLb.textColor = HEX_COLOR(0x333333);
    
    self.moneyLb.textColor = HEX_COLOR(0x333333);
    self.moneyLb.font  = [UIFont systemFontOfSize:WidthRatio(56)];
    
    
    self.typeLb.textColor = HEX_COLOR(0x999999);
    self.typeLb.font = [UIFont systemFontOfSize:WidthRatio(24)];
    
    
    
    
    [self.bankImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView.mas_left).offset(WidthRatio(234));
        make.top.mas_equalTo(headerView.mas_top).offset(WidthRatio(40));
        make.width.height.mas_equalTo(WidthRatio(51));
        
    }];
    MMViewBorderRadius(self.bankImageV, WidthRatio(51)/2, 0, [UIColor clearColor]);
    
    [self.bankNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bankImageV.mas_right).offset(WidthRatio(10));
        make.centerY.mas_equalTo(self.bankImageV.mas_centerY);
    }];
    
    [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bankNameLb.mas_bottom).offset(WidthRatio(49));
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
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.text = @"添加";
    contentLabel.textColor = HEX_COLOR(0x999999) ;
    contentLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    contentLabel.textAlignment = NSTextAlignmentRight;
    [sectionV addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sectionV.mas_left).offset(110+WidthRatio(30));
        make.right.mas_equalTo(sectionV.mas_right).offset(-WidthRatio(30));
        make.top.bottom.mas_equalTo(sectionV);
    }];
    
    UIButton *btn = [UIButton new];
        //    [btn setTitle:@"添加" forState:UIControlStateNormal];
    [btn setTitleColor:HEX_COLOR(0x999999) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
        //    btn.frame = CGRectMake(SCREEN_WIDTH - WidthRatio(30) - 60, 0, 60, sectionV.frame.size.height);
    [sectionV addSubview:titleLb];
    [sectionV addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(sectionV);
    }];
    
    self.contentLabel = contentLabel;
    
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
    self.customNavBar.title = @"提现详情";
    if ([self.type isEqualToString:@"1"]) {
        self.customNavBar.title = @"提现详情";
    }
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
-(void)setDataParameter:(id)dataParameter{
    NSLog(@"dataParameter = %@",dataParameter);
    if ([dataParameter isKindOfClass:[NSDictionary class]]) {
        self.orderID = dataParameter[@"id"];
        self.type = dataParameter[@"type"];
    }else{
        self.orderID = @"";
        self.type = @"";
    }
}
@end
