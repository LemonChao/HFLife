//
//  CardPackageVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/22.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "CardPackageVC.h"
#import "CardPackageCell.h"
//#import "HP_CardPackageNetApi.h"
#import "BalanceHomeVC.h"
#import "FQ_homeVC.h"
@interface CardPackageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArray;
}
@property (nonatomic,strong)UITableView *contentTableView;
@end

@implementation CardPackageVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSArray *dataArr = @[@[@{@"title":@"富宝",@"explain":@"通过富权兑换获得，可以用来购物及进行提现",@"content":@"20.5600000000"},
//                    @{@"title":@"富权",@"explain":@"会员通过进行消费、推荐好友消费获得的奖励收益",@"content":@"20.5600000000"}],
//                 @[@{@"title":@"15折折扣券",@"explain":@"美在中国连锁",@"content":@"",@"bgName":@"haircut"}]];
    NSArray *dataArr = @[@[@{@"title":@"富宝",@"explain":@"通过富权兑换获得，可以用来购物及进行提现",@"content":@"20.5600000000"},
                           @{@"title":@"富权",@"explain":@"会员通过进行消费、推荐好友消费获得的奖励收益",@"content":@"20.5600000000"}]
                    ];
    dataArray = [NSMutableArray arrayWithArray:dataArr];
    [self initWithUI];
     self.customNavBar.title = @"卡包";
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self axcBaseRequestData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)initWithUI{
    [self.view addSubview:self.contentTableView];
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navBarHeight);
    }];
}
-(void)axcBaseRequestData{
    /*
    HP_CardPackageNetApi *car = [[HP_CardPackageNetApi alloc]init];
    [car startWithoutCacheCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_CardPackageNetApi *carRequest = (HP_CardPackageNetApi *)request;
        if ([carRequest getCodeStatus]==1) {
            NSDictionary *dict = [carRequest getContent];
            if ([dict isKindOfClass:[NSDictionary class]]) {
                
                NSArray *array = @[@{@"title":@"余额",@"explain":@"通过富权兑换获得，可以用来购物及进行提现",@"content":[NSString judgeNullReturnString:dict[@"dynamic_shop"]],@"bgName":@"RichTreasure"},
                                   @{@"title":@"富权",@"explain":@"会员通过进行消费、推荐好友消费获得的奖励收益",@"content":[NSString judgeNullReturnString:dict[@"static_coin"]],@"bgName":@"RichRight"}];
                [self->dataArray replaceObjectAtIndex:0 withObject:array];

                [self.contentTableView reloadData];
            }
        }else{
            
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
     
     */
}
#pragma mark 列表代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = dataArray[section];
    return arr.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    CardPackageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CardPackageCell"];
    if (!cell) {
        cell = [[CardPackageCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"CardPackageCell"];
    }
     NSArray *arr = dataArray[indexPath.section];
    NSDictionary *dict = arr[indexPath.row];
    cell.titleString= dict[@"title"];
    cell.explainString = dict[@"explain"];
    cell.contentString = dict[@"content"];
    cell.bgName = dict[@"bgName"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc;
    if (indexPath.row == 0) {
            //余额
        vc = [BalanceHomeVC new];
    }else if (indexPath.row == 1){
        vc = [FQ_homeVC new];
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRatio(231);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeightRatio(50))];
    UILabel *label = [UILabel new];
    label.text = section == 0 ?@"卡包":@"会员卡";
    label.font = [UIFont systemFontOfSize:WidthRatio(24)];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(WidthRatio(21));
        make.centerY.mas_equalTo(view.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HeightRatio(50);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
#pragma mark 懒加载
-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                         style:UITableViewStyleGrouped];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = HEX_COLOR(0xffffff);
        _contentTableView.bounces = NO;
        _contentTableView.tableFooterView = [UIView new];
//        _contentTableView.tableHeaderView = [UIView new];
    }
    return _contentTableView;
}
@end
