
//
//  WithdrawVC.m
//  HFLife
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "WithdrawVC.h"
#import "withdrawAlertView.h"
//#import "widthrawNetApi.h"
#import "BalanceListVC.h"
#import "BindingPayWayVC.h"
//#import "getMoneyNetApi.h"
#import "HHPayPasswordView.h"
#import "balanceOrderDetaileVC.h"
@interface WithdrawVC ()<UITextFieldDelegate, HHPayPasswordViewDelegate>
@property (nonatomic, strong)UILabel  *bankNameLb;
@property (nonatomic, strong)UIImageView *bankImgV;
@property (nonatomic, strong)UILabel *bankSubTitleLb;
@property (nonatomic, strong)UILabel *balanceMoneyLb;
@property (nonatomic, strong)UIView *topV;
@property (nonatomic, strong)NSArray *bankModelListArr;
@property (nonatomic, strong)UILabel *topMeddolLb;
@property (nonatomic, strong)UITextField *moneyTF;

@property (nonatomic, strong)UIView *alertBgView;

@property (nonatomic, assign)BOOL isHaveBank;//是否有银行卡没有则添加
@end

@implementation WithdrawVC
{
    UIButton *_getMoneyBtn;
    UIView *_recoardAlertV;
    NSDictionary *value;
    bankListModel *selectedModel;
    UIButton *_getAllMoneyBtn;
    HHPayPasswordView *_payPasswordView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setUpSubViews];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    self.isHaveBank = YES;//默认有银行卡  等待数据加载
    
    //限制 小数点后 输入的后几位
    self.limitCount = 2;
    [self getData];
}
- (void) getData{
    self.bankModelListArr = [NSArray array];
    
    /*
     
     
    widthrawNetApi *api = [[widthrawNetApi alloc] init];
    
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        widthrawNetApi *widthrawApi = (widthrawNetApi *)request;
        if ([widthrawApi getCodeStatus] == 1) {
            NSDictionary *valueDict = [widthrawApi getContent];
            if ([valueDict isKindOfClass:[NSDictionary class]]) {
                self->value = valueDict;
                self.balanceMoneyLb.text = [NSString stringWithFormat:@"账户余额￥%@", valueDict[@"coin"] ? valueDict[@"coin"] : @""];
                //解析model
                if ([valueDict[@"bank_list"] isKindOfClass:[NSArray class]]) {
                    self.bankModelListArr = [dataManager getModelArrWithArr:valueDict[@"bank_list"] class:[bankListModel class]];
                    self.isHaveBank = YES;
                }else{
                    self.isHaveBank = NO;
                }
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        self.isHaveBank = NO;
    }];
    
     
     */
    
    
}
- (void) getMoney:(UIButton *)sender{
    
    NSInteger index = sender.tag - 9;
    if (index == 0) {
        if (self.bankModelListArr.count > 0) {
            //点击头部
            
            [withdrawAlertView showAlert:self.bankModelListArr complace:^(bankListModel * _Nonnull bankModel) {
                [self hiddenBank:NO];
                self.bankNameLb.text = [NSString stringWithFormat:@"%@（%@）", bankModel.bank_name ? bankModel.bank_name : @"", bankModel.bank_card ? bankModel.bank_card : @""];
                [self.bankImgV sd_setImageWithURL:[NSURL URLWithString:bankModel.bank_icon ? bankModel.bank_icon : @"http://www.ccc"]];
                self->selectedModel = bankModel;
            } bottomBtn:^{
               //跳转添加新卡
                BindingPayWayVC *vc = [BindingPayWayVC new];
                vc.isAlipay = NO;
                [self.navigationController pushViewController:vc animated:YES];
            }];
        }else{
            //跳转添加银行卡
            BindingPayWayVC *vc = [BindingPayWayVC new];
            vc.isAlipay = NO;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }else{
        if (index == 1) {
            //全部提现
            if (value) {
                self.moneyTF.text = value[@"coin"] ? value[@"coin"] : @"";
                _getMoneyBtn.backgroundColor = HEX_COLOR(0x2285EB);
                _getMoneyBtn.userInteractionEnabled = YES;
            }
        }else{
            if (!selectedModel) {
                [WXZTipView showCenterWithText:@"请输选择提现银行账户"];
                return;
            }
            if (self.balanceMoneyLb.text.length == 0) {
                [WXZTipView showCenterWithText:@"请输入金额"];
                return;
            }
            if([self.bankNameLb.text floatValue] > [value[@"coin"] floatValue]) {
                [WXZTipView showCenterWithText:@"不能超出账户余额"];
            }else{
                if ([self.bankNameLb.text floatValue] > 100000){
                    [WXZTipView showCenterWithText:@"最大额度不能超过100000"];
                    return;
                }else{
                    //弹密码
                    HHPayPasswordView *payPasswordView = [[HHPayPasswordView alloc] init];
                    payPasswordView.delegate = self;
                    [payPasswordView showInView:self.view];
                    _payPasswordView = payPasswordView;
                }
            }
            
        }
        NSLog(@"提现");
    }
    
    
    
}
#pragma mark - HHPayPasswordViewDelegate
- (void)passwordView:(HHPayPasswordView *)passwordView didFinishInputPayPassword:(NSString *)password{
    
    [self getMoney:self.moneyTF.text pwd:password cardID:[NSString stringWithFormat:@"%@", selectedModel.ID ? selectedModel.ID : @""]];
}
- (void) getMoney:(NSString *)money pwd:(NSString *)pwd cardID:(NSString *)cardId {
    NSDictionary *param = @{
                            @"money" : money,
                            @"paypassword" : pwd,
                            @"card_id" : cardId,
                            };
    /*
    
    getMoneyNetApi *api = [[getMoneyNetApi alloc] initWithParameter:param];
   
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        getMoneyNetApi *getApi = (getMoneyNetApi *)request;
        [self->_payPasswordView hide];
        
        if ([getApi getCodeStatus] == 1) {
            NSDictionary *valueDict = [getApi responseJSONObject];
            [WXZTipView showCenterWithText:valueDict[@"msg"]];
            balanceOrderDetaileVC *vc = [balanceOrderDetaileVC new];
            [vc setValue:@{@"id" :valueDict[@"data"][@"id"] ? valueDict[@"data"][@"id"] : @"0"  , @"type" : @"1"} forKey:@"dataParameter"];
            
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSDictionary *valueDict = [getApi responseJSONObject];
            [WXZTipView showCenterWithText:valueDict[@"msg"]];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self->_payPasswordView hide];
    }];
     
     */
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"--%@--", string);
    if ([string isEqualToString:@""]) {
        //删除
        return YES;
    }
    if (string.length == 0 && textField.text.length <= 1) {
        textField.text = @"";
        [textField endEditing:YES];
        _getMoneyBtn.backgroundColor = HEX_COLOR(0x91C4F8);
        _getMoneyBtn.userInteractionEnabled = NO;
    }else{
        _getMoneyBtn.backgroundColor = HEX_COLOR(0x2285EB);
        _getMoneyBtn.userInteractionEnabled = YES;
    }
    
    NSString *str = [NSString stringWithFormat:@"%@%@", textField.text , string];
    if ([textField.text floatValue] > [value[@"coin"] integerValue]) {
//        [textField endEditing:YES];
        [WXZTipView showTopWithText:@"输入金额超过余额"];
        return NO;
    }
    
    return [self limiTtextFled:textField shouldChangeCharactersInRange:range replacementString:string];
    
    return YES;
}
- (void) textFieldDidChange:(UITextField *) sender {
    NSLog(@"---%@", sender.text);
    if ([sender.text floatValue] > [value[@"coin"] integerValue]) {
        self.balanceMoneyLb.textColor = [UIColor redColor];
        _getAllMoneyBtn.hidden = YES;
        self.balanceMoneyLb.text = @"输入金额超过余额";
        [sender endEditing:YES];
    }else{
        self.balanceMoneyLb.textColor = HEX_COLOR(0x999999);
        _getAllMoneyBtn.hidden = NO;
        self.balanceMoneyLb.text = [NSString stringWithFormat:@"账户余额￥%@", value[@"coin"] ? value[@"coin"] : @""];
    }
   
}
- (void) setUpSubViews{
    UIView *bgView          = [UIView new];
    UIView *topView         = [UIView new];
    UIView *bottomView      = [UIView new];
    
    UILabel *topTitleLb     = [UILabel new];
    UILabel *topMeddileTitle= [UILabel new];
    UIImageView *bankImageV = [UIImageView new];
    UIImageView *incoderImgV= [UIImageView new];
    UIImageView *rIncoImgV  = [UIImageView new];
    UILabel *bankNameLb     = [UILabel new];
    UILabel *bankSunTitleLb = [UILabel new];
    UILabel *getMoneyTitle  = [UILabel new];
    UIButton *upBtn         = [UIButton new];
    UILabel *moneyLeadingLb = [UILabel new];
    UITextField *moneyTF    = [UITextField new];
    UIView *lineView        = [UIView new];
    UILabel *balanceMoneyLb = [UILabel new];//余额
    UIButton *getAllMoneyBtn= [UIButton new];
    UIButton *getMoneyBtn   = [UIButton buttonWithType:UIButtonTypeSystem];
    _getMoneyBtn = getMoneyBtn;
    _getAllMoneyBtn = getAllMoneyBtn;
    moneyTF.keyboardType = UIKeyboardTypeDecimalPad;
    moneyTF.contentMode = UIViewContentModeScaleAspectFit;
    moneyTF.delegate = self;
    
    [self.view addSubview:bgView];
    [bgView addSubview:topView];
    [bgView addSubview:bottomView];
    
    [topView addSubview:topTitleLb];
    [topView addSubview:topMeddileTitle];
    [topView addSubview:bankImageV];
    [topView addSubview:incoderImgV];
    [topView addSubview:bankNameLb];
    [topView addSubview:bankSunTitleLb];
    [topView addSubview:rIncoImgV];
    [topView addSubview:upBtn];
    
    [bottomView addSubview:getMoneyTitle];
    [bottomView addSubview:moneyLeadingLb];
    [bottomView addSubview:moneyTF];
    [bottomView addSubview:lineView];
    [bottomView addSubview:balanceMoneyLb];
    [bottomView addSubview:getAllMoneyBtn];
    [bottomView addSubview:getMoneyBtn];
    
    
    self.topV = topView;
    self.bankNameLb = bankNameLb;
    self.bankImgV = bankImageV;
    self.bankSubTitleLb = bankSunTitleLb;
    self.balanceMoneyLb = balanceMoneyLb;
    self.topMeddolLb = topMeddileTitle;
    
    
    
    
    
    topTitleLb.textColor = [UIColor blackColor];
    topTitleLb.font = [UIFont systemFontOfSize:WidthRatio(30)];
    
    topMeddileTitle.textColor = topTitleLb.textColor;
    topMeddileTitle.font = [UIFont systemFontOfSize:WidthRatio(30)];
    
    topView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    rIncoImgV.image = [UIImage imageNamed:@"icon_jiantou"];
    rIncoImgV.contentMode = UIViewContentModeScaleAspectFit;
    
    bankImageV.layer.cornerRadius = WidthRatio(32 * 0.5);
    bankImageV.clipsToBounds = YES;
    bankImageV.backgroundColor = HEX_COLOR(0x999999);
    
    bankNameLb.textColor = [UIColor blackColor];
    bankNameLb.font = [UIFont systemFontOfSize:WidthRatio(30)];
    bankSunTitleLb.textColor = HEX_COLOR(0x999999);
    bankSunTitleLb.font = [UIFont systemFontOfSize:WidthRatio(24)];
    
    getMoneyTitle.textColor = [UIColor blackColor];
    getMoneyTitle.font = [UIFont systemFontOfSize:WidthRatio(30)];
    moneyLeadingLb.font = [UIFont systemFontOfSize:WidthRatio(72)];
    moneyLeadingLb.textColor = HEX_COLOR(0x333333);
    
    moneyTF.font = moneyLeadingLb.font;
    moneyTF.textColor = moneyLeadingLb.textColor;
    
    [moneyTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.moneyTF = moneyTF;
    
    
    lineView.backgroundColor = HEX_COLOR(0xE1E1E1);
    
    balanceMoneyLb.textColor = HEX_COLOR(0x999999);
    balanceMoneyLb.font = [UIFont systemFontOfSize:WidthRatio(24)];
    [getAllMoneyBtn setTitle:@"全部提现" forState:UIControlStateNormal];
    [getAllMoneyBtn setTitleColor:[UIColor colorWithRed:153/255.0 green:166/255.0 blue:186/255.0 alpha:1.0] forState:UIControlStateNormal];
    getAllMoneyBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    
    [getMoneyBtn setTitle:@"提现" forState:UIControlStateNormal];
    [getMoneyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getMoneyBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(36)];
    getMoneyBtn.layer.cornerRadius = 5;
    getMoneyBtn.layer.masksToBounds = YES;
    getMoneyBtn.userInteractionEnabled = NO;
    getMoneyBtn.backgroundColor = HEX_COLOR(0x91C4F8);
//    getMoneyBtn.backgroundColor = HEX_COLOR(0x2285EB);
    
    getAllMoneyBtn.tag = 10;
    getMoneyBtn.tag = 11;
    upBtn.tag = 9;
    [getAllMoneyBtn addTarget:self action:@selector(getMoney:) forControlEvents:UIControlEventTouchUpInside];
    [getMoneyBtn addTarget:self action:@selector(getMoney:) forControlEvents:UIControlEventTouchUpInside];
    [upBtn addTarget:self action:@selector(getMoney:) forControlEvents:UIControlEventTouchUpInside];
    
    bankSunTitleLb.text = @"2小时内到账";
    moneyLeadingLb.text = @"￥";
    getMoneyTitle.text = @"提现金额";
    topTitleLb.text = @"到银行卡";
    getMoneyTitle.text = @"提现金额";
    
    
    bankNameLb.text = @"招商银行（0214）";
    balanceMoneyLb.text = @"账户余额￥0.00";
    topMeddileTitle.text = @"选择到账银行卡";
    
    
    
    [self hiddenBank:YES];
    
    
    
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WidthRatio(31) + self.navBarHeight);
        make.left.mas_equalTo(WidthRatio(20));
        make.right.mas_equalTo(WidthRatio(-20));
    }];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WidthRatio(138));
        make.top.right.left.mas_equalTo(bgView);
    }];

    [topTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRatio(29));
        make.top.mas_equalTo(WidthRatio(32));
    }];
    
    [topMeddileTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(topView.mas_centerX);
        make.centerY.mas_equalTo(topView.mas_centerY);
    }];
    [bankImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topTitleLb.mas_right).offset(WidthRatio(108));
        make.width.height.mas_equalTo(WidthRatio(32));
        make.centerY.mas_equalTo(topTitleLb.mas_centerY);
    }];
    [bankNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bankImageV.mas_right).offset(WidthRatio(19));
        make.centerY.mas_equalTo(bankImageV.mas_centerY);
    }];
    
    [bankSunTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bankNameLb.mas_bottom).offset(WidthRatio(20));
        make.left.mas_equalTo(bankNameLb.mas_left);
        make.bottom.mas_equalTo(topView.mas_bottom).offset(WidthRatio(-34));
    }];
    [incoderImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topView.mas_right).offset(WidthRatio(35));
        make.top.bottom.mas_equalTo(topView);
        make.width.mas_equalTo(WidthRatio(20));
    }];
    
    [rIncoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(topView);
        make.right.mas_equalTo(topView.mas_right).offset(WidthRatio(-30));
        make.height.mas_equalTo(WidthRatio(20));
    }];
    [upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.mas_equalTo(topView);
    }];
    
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(bgView);
        make.top.mas_equalTo(topView.mas_bottom);
        make.bottom.mas_equalTo(bgView.mas_bottom);
    }];
    
    [getMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top).offset(WidthRatio(81));
        make.left.mas_equalTo(bottomView.mas_left).offset(WidthRatio(29));
    }];
    
    [moneyLeadingLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(getMoneyTitle.mas_left);
        make.top.mas_equalTo(getMoneyTitle.mas_bottom).offset(WidthRatio(77));
        make.width.mas_equalTo(WidthRatio(70));
    }];
    
    [moneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(moneyLeadingLb.mas_right).offset(WidthRatio(10));
        make.bottom.top.mas_equalTo(moneyLeadingLb);
        make.right.mas_equalTo(bottomView.mas_right).offset(-10);
        make.height.mas_equalTo(30);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(getMoneyTitle.mas_leading);
        make.right.mas_equalTo(bottomView.mas_right).offset(WidthRatio(-29));
        make.top.mas_equalTo(moneyLeadingLb.mas_bottom).offset(WidthRatio(20));
        make.height.mas_equalTo(1);
    }];
    
    [balanceMoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(getMoneyTitle.mas_leading);
        make.top.mas_equalTo(lineView.mas_bottom).offset(WidthRatio(34));
    }];
    
    [getAllMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(balanceMoneyLb.mas_right).offset(5);
        make.centerY.mas_equalTo(balanceMoneyLb.mas_centerY);
    }];
    
    [getMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView.mas_left).offset(WidthRatio(57));
        make.right.mas_equalTo(bottomView.mas_right).offset(WidthRatio(-57));
        make.height.mas_equalTo(WidthRatio(77));
        make.top.mas_equalTo(balanceMoneyLb.mas_bottom).offset(WidthRatio(50)); make.bottom.mas_equalTo(bottomView.mas_bottom).offset(WidthRatio(-65));
    }];
    
}


- (void) hiddenBank:(BOOL)isHidden{
    self.bankSubTitleLb.hidden = isHidden;
    self.bankImgV.hidden = isHidden;
    self.bankNameLb.hidden = isHidden;
    self.topMeddolLb.hidden = !isHidden;
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
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.title = @"提现";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"icon_gegnduo"]];
    [self.customNavBar setOnClickRightButton:^{
        [weakSelf showRecoardView];
        
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - 提现记录弹窗
- (void) showRecoardView{
    
    UIView *alertView = [UIView new];
    _recoardAlertV = alertView;
    UIButton *firstCellBtn = [UIButton new];
    UIButton *secondCellBtn = [UIButton new];
    firstCellBtn.tag = 1000;
    secondCellBtn.tag = 1001;
    firstCellBtn.backgroundColor = [UIColor whiteColor];
    [firstCellBtn setTitle:@"提现记录" forState:UIControlStateNormal];
    firstCellBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [firstCellBtn setTitleColor:HEX_COLOR(0x333333) forState:UIControlStateNormal];
    secondCellBtn.backgroundColor = [UIColor whiteColor];
    secondCellBtn.titleLabel.font = firstCellBtn.titleLabel.font;
    [secondCellBtn setTitleColor:HEX_COLOR(0x333333) forState:UIControlStateNormal];
    [secondCellBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [firstCellBtn addTarget:self action:@selector(clickRecoardBtn:) forControlEvents:UIControlEventTouchUpInside];
    [secondCellBtn addTarget:self action:@selector(clickRecoardBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    firstCellBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 57);
    secondCellBtn.frame = CGRectMake(0, 57 + 5, SCREEN_WIDTH, 52);
    
    
    [alertView addSubview:firstCellBtn];
    [alertView addSubview:secondCellBtn];
    
    UIWindow *kw = [UIApplication sharedApplication].keyWindow;
    if (!kw) {
        kw = [UIApplication sharedApplication].windows.lastObject;
    }
    self.alertBgView = [[UIView alloc] initWithFrame:kw.bounds];
    [kw addSubview:self.alertBgView];
    self.alertBgView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.7];
    alertView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 114);
//    kw.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.7];
    [self.alertBgView addSubview:alertView];
    [UIView animateWithDuration:0.2 animations:^{
        alertView.frame = CGRectMake(0, SCREEN_HEIGHT - 114, SCREEN_WIDTH, 114);
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}

- (void) clickRecoardBtn:(UIButton *)sender{
    NSInteger index=  sender.tag - 1000;
    if (index == 0) {
        //跳转提现记录
        Class vcclass = NSClassFromString(@"BalanceListVC");
        BalanceListVC *vc=  [[vcclass alloc] init];
        vc.titleStr = @"提现记录";
        vc.type = @"1";
        [self.navigationController pushViewController:vc animated:YES];
        
        [self removeAlert];
        
    }else{
        [self removeAlert];
        
    }
}
- (void) removeAlert{
    for (UIView * subview in _recoardAlertV.subviews) {
        [subview removeFromSuperview];
    }
    [_recoardAlertV removeFromSuperview];
    _recoardAlertV = nil;
    [self.alertBgView removeFromSuperview];
    self.alertBgView = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
