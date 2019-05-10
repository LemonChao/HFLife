
//
//  BalanceVC.m
//  HFLife
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "BalanceHomeVC.h"
#import "BalanceTfAtHomeVC.h"
#import "WithdrawVC.h"
#import "WithdrawItemView.h"
#import "balanceRecoardView.h"
#import "BalanceListVC.h"
#import "balanceOrderDetaileVC.h"
#import "TransferAccountsOrderDetails.h"
#import "BillDetailsVC.h"
//#import "CardBagBalanceHomeNetApi.h"
@interface BalanceHomeVC ()
{
    BOOL is_bn_bn;//是否可转账
    BOOL is_tx ;//是否可提现
}
@property (nonatomic, strong)UILabel *balanceMoneyLb;//消费金额的余额数
@property (nonatomic, strong)UILabel *balanceRewardLb;//余额奖励
@property (nonatomic, strong)UILabel *fqMoneyLb;//余额数
@property (nonatomic, strong)balanceRecoardView *tabV;
@end

@implementation BalanceHomeVC
{
    UIButton *_balanceGetMoneyBtn;
    UIButton *_balanceTransBtn;
    UIButton *_fqGoExchangeBtn;
//    CardBagBalanceHomeNetApi *_balanceHome;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     
    [self setUpUI];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    
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
- (void)setUpUI{
    [self setupNavBar];
    [self setUpSubViews];
    
    
    self.fqMoneyLb.text = @"00.00";
    self.balanceMoneyLb.text = @"00.00";
    self.balanceRewardLb.text = [NSString stringWithFormat:@"累计奖励 %@", @"35.42"];
    
    
}
-(void)axcBaseRequestData{
    WS(weakSelf);
    
    
    /*
    
    if (!_balanceHome) {
        _balanceHome = [[CardBagBalanceHomeNetApi alloc]init];
    }

    [_balanceHome startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        CardBagBalanceHomeNetApi *balanceHomeRequests = (CardBagBalanceHomeNetApi *)request;
        if ([balanceHomeRequests getCodeStatus]==1) {
            NSDictionary *dict = [balanceHomeRequests getContent];
            if ([dict isKindOfClass:[NSDictionary class]]) {
                NSDictionary *coin = dict[@"coin"];
                if ([coin isKindOfClass:[NSDictionary class]]) {
                    weakSelf.balanceRewardLb.text = [NSString stringWithFormat:@"累计奖励 %@", [NSString judgeNullReturnString:coin[@"reward_coin"]]];
                    weakSelf.balanceMoneyLb.text = [NSString judgeNullReturnString:coin[@"dynamic_shop"]];
                }
                NSDictionary *config = dict[@"config"];
                if ([config isKindOfClass:[NSDictionary class]]) {
                    self->is_bn_bn = [[NSString judgeNullReturnString:config[@"is_bn_bn"]] isEqualToString:@"1"];
                    self->is_tx = [[NSString judgeNullReturnString:config[@"is_tx"]] isEqualToString:@"1"];
                }
                NSArray *log = dict[@"log"];
                if ([log isKindOfClass:[NSArray class]]) {
                    NSMutableArray *dataArray  = [NSMutableArray array];
                    for (NSDictionary *dict in log) {
                        BalanceRecordModel *model = [[BalanceRecordModel alloc]init:dict];
                        [dataArray addObject:model];
                    }
                    weakSelf.tabV.dataSourceArray = dataArray;
                }
            }
        }else{
            [WXZTipView showCenterWithText:[balanceHomeRequests getMsg]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [WXZTipView showCenterWithText:@"数据获取失败"];
    }];
     
     
     */
}
//按钮点击
- (void) clickButton:(UIButton *)sender{
    NSInteger index = sender.tag - 99;
    UIViewController * vc;
    if (index == 1){
        if (!is_bn_bn) {
            [WXZTipView showCenterWithText:@"暂无法进行转账"];
            return;
        }
        vc = [BalanceTfAtHomeVC new];
    }
    else if (index == 0) {
        if (!is_tx) {
            [WXZTipView showCenterWithText:@"暂无法进行提现"];
            return;
        }
        vc = [WithdrawVC new];
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void) selectedItem:(NSInteger)index{
    NSLog(@"%ld", index);
    NSString *titleStr;
    NSString *type;
    switch (index) {
        case 0:
            titleStr = @"余额记录";
            type = @"0";
            break;
        case 1:
            titleStr = @"提现记录";
            type = @"1";
            break;
        case 2:
            titleStr = @"转账记录";
            type = @"2";
            break;
        default:
            break;
    }
    Class vcclass = NSClassFromString(@"BalanceListVC");
    BalanceListVC *vc=  [[vcclass alloc] init];
    vc.titleStr = titleStr;
    vc.type = type;
    [self.navigationController pushViewController:vc animated:YES];
}











- (void) setUpSubViews{
    self.balanceMoneyLb           = [UILabel new];
    self.balanceRewardLb          = [UILabel new];
    self.fqMoneyLb                = [UILabel new];
    UIView *balanceView           = [UIView new];
    UIView *fqView                = [UIView new];
    UIView *balanceSpaceView      = [UIView new];
    UIView *lineView1             = [UIView new];
    UIView *lineView2             = [UIView new];
    UIImageView *imageBgView1     = [UIImageView new];
    UIImageView *imageBgView2     = [UIImageView new];
    UILabel *balanceTitleLb       = [UILabel new];
    UILabel *balanceBottomLb      = [UILabel new];
    UIButton *balanceGetMoneyBtn  = [UIButton new];
    UIButton *balanceTransBtn     = [UIButton new];
    
    UILabel *fqTitleLb            = [UILabel new];
    UILabel *fqCountLb            = [UILabel new];
    UIButton *fqGoExchangeBtn     = [UIButton new];
    
    [self.view addSubview:balanceView];
    
    WithdrawItemView *itemView = [WithdrawItemView new];
    [self.view addSubview:itemView];
    WS(weakSelf);
    itemView.selectedAtIndex = ^(NSInteger index) {
      //选择的是
        [weakSelf selectedItem:index];
    };
    
    self.tabV = [balanceRecoardView new];
    self.tabV.superVC = self;
    [self.view addSubview:self.tabV];
    
    
    
    
    
    [self.view addSubview:fqView];
    [balanceView addSubview:imageBgView1];
    [balanceView addSubview:balanceTitleLb];
    [balanceView addSubview:self.balanceMoneyLb];
    [balanceView addSubview:self.balanceRewardLb];
    [balanceView addSubview:balanceBottomLb];
    [balanceView addSubview:lineView1];
    [balanceView addSubview:balanceGetMoneyBtn];
    [balanceView addSubview:balanceTransBtn];
    [balanceView addSubview:balanceSpaceView];
    
    [fqView addSubview:imageBgView2];
    [fqView addSubview:self.fqMoneyLb];
    [fqView addSubview:fqTitleLb];
    [fqView addSubview:fqCountLb];
    [fqView addSubview:lineView2];
    [fqView addSubview:fqGoExchangeBtn];
    
    lineView1.backgroundColor = [UIColor whiteColor];
    lineView2.backgroundColor = [UIColor whiteColor];
    balanceSpaceView.backgroundColor = [UIColor whiteColor];
    lineView1.alpha = lineView2.alpha = 0.3;
    imageBgView1.image = [UIImage imageNamed:@"余额bgView"];
    imageBgView2.image = [UIImage imageNamed:@"余额_富权bgView"];
    balanceTitleLb.text = @"余额账户（元）";
    balanceBottomLb.text = @"可购物可消费";
    fqTitleLb.text = @"可兑换富权";
    
    
    balanceTitleLb.textColor = [UIColor whiteColor];
    balanceTitleLb.font = [UIFont systemFontOfSize:WidthRatio(30)];
    
    self.balanceMoneyLb.textColor = [UIColor whiteColor];
    self.balanceMoneyLb.font = [UIFont systemFontOfSize:WidthRatio(65)];
    self.balanceMoneyLb.textAlignment = NSTextAlignmentCenter;
    
    self.balanceRewardLb.textColor = [UIColor whiteColor];
    self.balanceRewardLb.font      = [UIFont systemFontOfSize:WidthRatio(26)];
    
    balanceBottomLb.font = [UIFont systemFontOfSize:WidthRatio(22)];
    balanceBottomLb.textColor = [UIColor whiteColor];
    
    [balanceGetMoneyBtn setTitle:@"提现" forState:UIControlStateNormal];
    [balanceGetMoneyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    balanceGetMoneyBtn.titleLabel.font = self.balanceRewardLb.font;
    
    [balanceTransBtn setTitle:@"转账" forState:UIControlStateNormal];
    [balanceTransBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    balanceTransBtn.titleLabel.font = self.balanceRewardLb.font;
    
    
    fqTitleLb.textColor = [UIColor whiteColor];
    fqTitleLb.font = [UIFont systemFontOfSize:WidthRatio(28)];
    
    self.fqMoneyLb.textColor = [UIColor whiteColor];
    self.fqMoneyLb.font = [UIFont systemFontOfSize:WidthRatio(54) weight:1];
    [fqGoExchangeBtn setTitle:@"去兑换" forState:UIControlStateNormal];
    [fqGoExchangeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    fqGoExchangeBtn.titleLabel.font = self.balanceRewardLb.font;
    
    balanceGetMoneyBtn.tag = 99;
    balanceTransBtn.tag = 100;
    fqGoExchangeBtn.tag = 101;
    
    
    _balanceGetMoneyBtn = balanceGetMoneyBtn;
    _balanceTransBtn = balanceTransBtn;
    _fqGoExchangeBtn = fqGoExchangeBtn;
    [_balanceGetMoneyBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_balanceTransBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_fqGoExchangeBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(WidthRatio(31) + self.navBarHeight);
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
//        make.height.mas_equalTo(WidthRatio(360));
    }];
    [imageBgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(balanceView);
    }];
    
    [balanceTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(balanceView.mas_centerX);
        make.top.mas_equalTo(balanceView.mas_top).offset(WidthRatio(52));
    }];
    [self.balanceMoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(balanceView.mas_centerX);
        make.top.mas_equalTo(balanceTitleLb.mas_bottom).offset(WidthRatio(42));
    }];
    [self.balanceRewardLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(balanceView.mas_centerX);
        make.top.mas_equalTo(self.balanceMoneyLb.mas_bottom).offset(WidthRatio(22));
    }];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(balanceView.mas_left).offset(WidthRatio(34));
        make.height.mas_equalTo(1); make.right.mas_equalTo(balanceView.mas_right).offset(-WidthRatio(34));
        make.top.mas_equalTo(self.balanceRewardLb.mas_bottom).offset(WidthRatio(49));
    }];
    [balanceBottomLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView1.mas_left);
        make.top.mas_equalTo(lineView1.mas_bottom).offset(WidthRatio(28));
        make.bottom.mas_equalTo(balanceView.mas_bottom).offset(-WidthRatio(40));
    }];
    
    [balanceTransBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(balanceBottomLb.mas_centerY);
        make.right.mas_equalTo(balanceView).offset(-WidthRatio(36));
    }];
    [balanceSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(balanceTransBtn.mas_left).offset(-5);
        make.centerY.mas_equalTo(balanceTransBtn.mas_centerY);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(1);
    }];
    [balanceGetMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(balanceTransBtn.mas_centerY);
        make.right.mas_equalTo(balanceSpaceView.mas_left).offset(-5);
    }];
    
    
    
    
    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(balanceView.mas_bottom).offset(WidthRatio(29));
        make.height.mas_equalTo(WidthRatio(183));
    }];
    
    
    
    [self.tabV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(itemView.mas_bottom).offset(WidthRatio(10));
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    
    
    
    
    
    /**
    
    
    [fqView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(balanceView.mas_bottom).offset(WidthRatio(29));
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
//        make.height.mas_equalTo(WidthRatio(256));
    }];
    [imageBgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(fqView);
    }];
    
    [fqTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(fqView.mas_top).offset(WidthRatio(41));
        make.centerX.mas_equalTo(fqView.mas_centerX);
    }];
    [self.fqMoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(fqTitleLb.mas_bottom).offset(WidthRatio(30));
        make.centerX.mas_equalTo(fqView.mas_centerX);
    }];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.fqMoneyLb.mas_bottom).offset(WidthRatio(38));
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(balanceView.mas_left).offset(WidthRatio(34));
        make.right.mas_equalTo(balanceView.mas_right).offset(-WidthRatio(34));
    }];
    
    [fqGoExchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView2.mas_bottom).offset(WidthRatio(27));
        make.centerX.mas_equalTo(fqView.mas_centerX);
        make.bottom.mas_equalTo(fqView.mas_bottom).offset(-WidthRatio(27));
    }];
     
     */
    
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
    self.customNavBar.title = @"余额";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    
//    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"组余额记录"]];
//    [self.customNavBar setOnClickRightButton:^{
////        Class vcclass = NSClassFromString(@"BalanceListVC");
////        BalanceListVC *vc=  [[vcclass alloc] init];
////        vc.titleStr = @"余额记录";
//
//        //测试详情
//        BillDetailsVC *vc = [BillDetailsVC new];
//        [weakSelf.navigationController pushViewController:vc animated:YES];
//    }];
    
    
}
@end
