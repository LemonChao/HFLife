//
//  PaymentMethodsVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/19.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "PaymentMethodsVC.h"
#import "PaymentMethodsCell.h"
#import "MKShowDynamic.h"
#import "UIView+LLXAlertPop.h"
#import "BindingPayWayVC.h"
#import "BindingAlipayVC.h"
#import "Per_MethodsToDealWithManage.h"
#import "LXEmptyDataView.h"
@interface PaymentMethodsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArray;
    NSArray *typeArray;
}
@property (nonatomic,strong)UITableView *contentTableView;

@end
@implementation PaymentMethodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithUI];
    [self setupNavBar];
    
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
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
//    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    [self.customNavBar wr_setRightButtonWithImage:MMGetImage(@"tianjia")];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    self.customNavBar.backgroundColor = RGBA(136, 53, 230, 1);
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar setOnClickRightButton:^{
        NSLog(@"添加");
        
        if ([NSString isNOTNull:[UserCache getUserPhone]]) {
            //设置手机号
            LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"温馨提示" message:MMNSStringFormat(@"您未进行手机号绑定,暂时无法进行银行卡添加") cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
                
            }];
            alert.animationStyle=LXASAnimationTopShake;
            [alert showLXAlertView];
            return;// 手机号未绑定返回
        }
        
        NSArray *arrayTitle = @[@"银行卡",@"支付宝"];
        
        UIColor *color = [UIColor blackColor];
        
        [weakSelf.view createAlertViewTitleArray:arrayTitle textColor:color font:[UIFont systemFontOfSize:WidthRatio(29)] actionBlock:^(UIButton * _Nullable button, NSInteger didRow) {
            //获取点击事件
            NSLog(@"%@,%ld",button.currentTitle,(long)didRow);
            if (didRow==0) {
                BindingPayWayVC *vc = [[BindingPayWayVC alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                //                vc.addSuccess = ^{
                //                    [weakSelf axcBaseRequestData];
                //                };
            }else if (didRow==1){
                BindingAlipayVC *vc = [[BindingAlipayVC alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                //                vc.addSuccess = ^{
                //                    [weakSelf axcBaseRequestData];
                //                };
            }
            
        }];
    }];
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"收款方式";
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
}
-(void)initWithUI{
    [self.view addSubview:self.contentTableView];
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight);
    }];
}
-(void)axcBaseRequestData{
    WS(weakSelf);
    [[Per_MethodsToDealWithManage sharedInstance]getPaymentMethodsList:^(id  _Nonnull request) {
        if ([request isKindOfClass:[NSArray class]]) {
            self->dataArray = request;
            NSArray *aray1 = self->dataArray[0];
            NSArray *aray2 = self->dataArray[1];
            if (aray1.count==0&&aray2.count==0) {
//                [self initEmptyDataViewbelowSubview:self.customNavBar touchBlock:^{
//                    [weakSelf axcBaseRequestData];
//                }];
            }
            
        }else{
            self->dataArray = @[];
//            [self initEmptyDataViewbelowSubview:self.customNavBar touchBlock:^{
//                [weakSelf axcBaseRequestData];
//            }];
        }
        [self.contentTableView reloadData];
    }];
}
#pragma mark 列表代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arry = dataArray[section];
    return arry.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PaymentMethodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentMethodsCell"];
    if (!cell) {
        cell = [[PaymentMethodsCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"PaymentMethodsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    WS(weakSelf);
    [cell setUnbundlingClick:^(id  _Nonnull dataModel) {
        [MKShowDynamic setDefaultMKShowShowStyle:MKShowShowStyleDefault]; //设置为普通显示
        [MKShowDynamic setDefaultMKShowDynamicStyle:MKShowDynamicStyleCenter]; //设置为中间的显示
        [MKShowDynamic setMessageColor:HEX_COLOR(0x000000)];
        [MKShowDynamic setMessageFont:[UIFont systemFontOfSize:WidthRatio(29)]];
        [MKShowDynamic setLinColor:HEX_COLOR(0xeaeaea)];
        [MKShowDynamic setCancelColor:HEX_COLOR(0xa24acd)];
        [MKShowDynamic setSureColor:HEX_COLOR(0x666666)];
        [MKShowDynamic showMkViewWithMessage:@"您确定对该方式解绑嘛？" sureCallBack:^(id backObject) {
            [[Per_MethodsToDealWithManage sharedInstance]removeBindCollectionWayParameter:@{@"id":MMNSStringFormat(@"%@",dataModel[@"id"])} SuccessBlock:^(id  _Nonnull request) {
                if ([request boolValue]) {
                    [weakSelf axcBaseRequestData];
                }
            }];
        } cancelCallBack:^(id backObject) {
            
        }];
    }];
    if (indexPath.section == 0) {
        NSDictionary *dict = dataArray[indexPath.section][indexPath.row];
        
        if (indexPath.section > 0) {
            cell.gatheringType = PaymentMethodsAlipay;
        }else{
            NSString *bankName = [[NSString getBankName:dict[@"bank_card"]] componentsSeparatedByString:@"·"].firstObject;
            
            if ([bankName containsString:@"邮政"] || [bankName containsString:@"邮储"]) {
                cell.gatheringType = PaymentMethodsPSBC;
            }else if ([bankName containsString:@"农业"]) {
                cell.gatheringType = PaymentMethodsABC;
            }else if ([bankName containsString:@"建设"]) {
                cell.gatheringType = PaymentMethodsCCB;
            }else if ([bankName containsString:@"工商"]) {
                cell.gatheringType = PaymentMethodsICBC;
            }else if ([bankName containsString:@"中国银行"]) {
                cell.gatheringType = PaymentMethodsBOC;
            }else if ([bankName containsString:@"民生"]) {
                cell.gatheringType = PaymentMethodsCMBC;
            }else if ([bankName containsString:@"招商"]) {
                cell.gatheringType = PaymentMethodsCMB;
            }else if ([bankName containsString:@"光大"]) {
                cell.gatheringType = PaymentMethodsCEB;
            }else if ([bankName containsString:@"广东"]) {
                cell.gatheringType = PaymentMethodsGDB;
            }else if ([bankName containsString:@"浦东银行"]) {
                cell.gatheringType = PaymentMethodsSPDB;
            }else if ([bankName containsString:@"交通银行"]) {
                cell.gatheringType = PaymentMethodsCOMM;
            }else{//默认银行卡背景
                cell.gatheringType = HotelReservationNone;//arc4random() % 13;
            }
        }
        cell.account = dict[@"bank_card"];
        cell.dataModel = dict;
    }else{
        NSString *str = dataArray[indexPath.section][indexPath.row];
        cell.gatheringType = PaymentMethodsAlipay;
        cell.account = str;
        //支付宝
        cell.dataModel = @{@"id" : @(0)};
        
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRatio(240);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeightRatio(74))];
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"其他方式";
        titleLabel.font = [UIFont systemFontOfSize:WidthRatio(29)];
        titleLabel.textColor = [UIColor blackColor];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view.mas_left).offset(WidthRatio(30));
            make.height.mas_greaterThanOrEqualTo(1);
            make.width.mas_greaterThanOrEqualTo(1);
            make.bottom.mas_equalTo(view.mas_bottom).offset(-HeightRatio(13));
        }];
        return view;
    }
    
    
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return HeightRatio(74);
    }
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
#pragma mark 懒加载
-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                         style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = HEX_COLOR(0xffffff);
        _contentTableView.bounces = NO;
        //        _contentTableView.tableFooterView = [UIView new];
        _contentTableView.tableHeaderView = [UIView new];
    }
    return _contentTableView;
}
@end
