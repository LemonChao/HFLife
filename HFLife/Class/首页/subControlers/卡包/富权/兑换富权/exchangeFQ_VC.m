
//
//  exchangeFQ_VC.m
//  HFLife
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "exchangeFQ_VC.h"
//#import "FQ_exchangeNetApi.h"
//#import "FQ_exchangePageNetApi.h"
#import "RichRightListVC.h"

@interface exchangeFQ_VC ()<UITextFieldDelegate>
//可兑换
@property (weak, nonatomic) IBOutlet UILabel *exchangeMoneyLb;
//当前富权价格
@property (weak, nonatomic) IBOutlet UILabel *currentMoneyLb;
//最少兑换价格
@property (weak, nonatomic) IBOutlet UILabel *limitExchangeMoneyLb;
@property (weak, nonatomic) IBOutlet UITextField *limitExchangeMoneyTF;

@property (weak, nonatomic) IBOutlet UIButton *configerExchangeBtn;
@property (nonatomic, strong)NSDictionary *valurDic;
@property (nonatomic, assign)CGFloat scale;//手续费比例

@property (weak, nonatomic) IBOutlet UILabel *bottomTitleLb;
@property (nonatomic, assign)CGFloat limitValue;//最小值
@end


@implementation exchangeFQ_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    self.limitExchangeMoneyTF.delegate = self;
    self.limitCount = 10;
}

- (void) reloadData{
    self.exchangeMoneyLb.text = [NSString stringWithFormat:@"%@", self.valurDic[@"data"][@"dynamic_dh"] ? self.valurDic[@"data"][@"dynamic_dh"]: @"0.00"];
    self.currentMoneyLb.text = [NSString stringWithFormat:@"%@", self.valurDic[@"data"][@"bn_acc_ratio"] ? self.valurDic[@"data"][@"bn_acc_ratio"]: @"0.00"];
    
    self.limitExchangeMoneyTF.placeholder = [NSString stringWithFormat:@"最少兑换%@", self.valurDic[@"data"][@"kdh_to_dh_min"] ? self.valurDic[@"data"][@"kdh_to_dh_min"]: @"0.00"];
    
    self.scale = [self.valurDic[@"data"][@"bn_acc_bl"] floatValue];
    self.limitValue = [self.valurDic[@"data"][@"kdh_to_dh_min"] floatValue];

}

//加载数据
- (void) getData{
    /*
    FQ_exchangePageNetApi *exchangeNetApi = [[FQ_exchangePageNetApi alloc] init];
    WS(weakSelf);
    [exchangeNetApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        FQ_exchangePageNetApi *exchangeApi = (FQ_exchangePageNetApi *)request;
        NSDictionary *valueDic = [exchangeApi responseJSONObject];
        if ([valueDic isKindOfClass:[NSDictionary class]]) {
            
            if ([exchangeApi getCodeStatus] == 1) {
                //更新数据
                weakSelf.valurDic = valueDic;
                [weakSelf reloadData];
            }else{
                [WXZTipView showCenterWithText:valueDic[@"msg"]];
            }
        }else{
            [WXZTipView showCenterWithText:@"数据加载失败"];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [WXZTipView showCenterWithText:@"数据加载失败"];
    }];
     
     */
}





//全部兑换
- (IBAction)exchangeAllBtnClick:(UIButton *)sender {
    self.limitExchangeMoneyTF.text = self.exchangeMoneyLb.text;
    self.limitExchangeMoneyTF.textColor = [UIColor blackColor];
    self.limitExchangeMoneyTF.font = [UIFont systemFontOfSize:19 weight:1.5];
    
    [self textFieldChange:self.limitExchangeMoneyTF];
}


- (IBAction)textFieldChange:(UITextField *)sender {
    if (sender.text.length == 0) {
        sender.text = @"";
        [sender endEditing:YES];
        _configerExchangeBtn.backgroundColor = HEX_COLOR(0x91C4F8);
        _configerExchangeBtn.userInteractionEnabled = NO;
        _bottomTitleLb.text = @"兑换成富权，获取更大收益";
        [self.limitExchangeMoneyTF setFont:[UIFont systemFontOfSize:14 weight:1]];
    }else{
        [self.limitExchangeMoneyTF setFont:[UIFont systemFontOfSize:19 weight:1.5]];
        self.limitExchangeMoneyTF.textColor = [UIColor blackColor];
        
        //根据比率计算可兑换富权值
        CGFloat fqValue = 0.0000000000;
        if ([self.valurDic isKindOfClass:[NSDictionary class]]) {
            //分母不能为0
            if ([self.valurDic[@"data"][@"bn_acc_ratio"] doubleValue] != 0) {
                fqValue = [sender.text doubleValue] / [self.valurDic[@"data"][@"bn_acc_ratio"] doubleValue] * (1 - [self.valurDic[@"data"][@"bn_acc_bl"] doubleValue]);
            }
        }
        NSLog(@"%@\n%@\n%@",self.valurDic[@"data"][@"bn_acc_ratio"], self.valurDic[@"data"][@"bn_acc_ratio"], self.valurDic[@"data"][@"bn_acc_bl"]);
        
        
        NSString *atrStr = [NSString stringWithFormat:@"%@份", [self getcontent]];
        
        //特殊字符
        NSString *holeStr = [NSString stringWithFormat:@"可兑换：%@富权", atrStr];
        NSMutableAttributedString *atrM = [[NSMutableAttributedString alloc] initWithString:holeStr];
        [atrM setAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} range:NSMakeRange(4, atrStr.length)];
        self.bottomTitleLb.attributedText = atrM;
        

        _configerExchangeBtn.backgroundColor = HEX_COLOR(0x2285EB);
        _configerExchangeBtn.userInteractionEnabled = YES;
    }
    if ([sender.text floatValue] > [self.exchangeMoneyLb.text floatValue]) {
        [WXZTipView showCenterWithText:@"不能超出当前可兑换总额"];
    }
    if ([sender.text floatValue] < self.limitValue) {
        [WXZTipView showCenterWithText:@"输入金额不得小于最低兑换值"];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([textField.text floatValue] > [self.exchangeMoneyLb.text floatValue]) {
        [WXZTipView showCenterWithText:@"输入金额超过余额"];
        return NO;
    }
   
    return [self limiTtextFled:textField shouldChangeCharactersInRange:range replacementString:string];
}





//立即兑换
- (IBAction)exchangeBtnClick:(UIButton *)sender{
    if (self.limitExchangeMoneyTF.text.length == 0) {
        [WXZTipView showCenterWithText:@"请输入兑换金额"];
        return;
    }
    /*
    FQ_exchangeNetApi *exchangeNetApi = [[FQ_exchangeNetApi alloc] initWithParameter:@{@"dh_num" : self.limitExchangeMoneyTF.text}];
    [exchangeNetApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        FQ_exchangeNetApi *exchangeApi = (FQ_exchangeNetApi *)request;
        NSDictionary *valurDic = [request responseJSONObject];
        if ([valurDic isKindOfClass:[NSDictionary class]]) {
            self.valurDic = valurDic;
            if ([[NSString stringWithFormat:@"%ld", (long)[exchangeApi getCodeStatus]] isEqualToString:@"1"]) {
                [self getData];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
            }
            [WXZTipView showCenterWithText:valurDic[@"msg"]];
        }else{
            [WXZTipView showCenterWithText:@"兑换失败！"];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [WXZTipView showCenterWithText:@"兑换失败！请检查网络设置"];
    }];
     
     */
}













-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self getData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    self.view.backgroundColor =  HEX_COLOR(0xEEEEEE);
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    
    
    
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"富权取出记录"]];
    [self.customNavBar setOnClickRightButton:^{
        //跳转记录
        RichRightListVC *listVC = [RichRightListVC new];
        listVC.cellTitleArray = @[@"兑换总额", @"兑换到富权",@"时间"];
//        listVC.cellValueArray = @[@"-1453.2546251487", @"1.0546287593份",@"2019-04-20"];
        listVC.recordType = 1;
        listVC.vcTitle = @"兑换记录";
        [weakSelf.navigationController pushViewController:listVC animated:YES];
    }];
    [self.customNavBar wr_setBottomLineHidden:NO];
    self.customNavBar.title = @"兑换富权";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    self.customNavBar.backgroundColor = [UIColor whiteColor];
}

//用于货币高精度计算
- (NSDecimalNumber *) getcontent{
    NSString *dynamic_dh = self.limitExchangeMoneyTF.text;
    NSString *bn_acc_ratio = [NSString stringWithFormat:@"%@", self.valurDic[@"data"][@"bn_acc_ratio"]];
    NSString *bn_acc_bl = [NSString stringWithFormat:@"%@", self.valurDic[@"data"][@"bn_acc_bl"]];
    
    NSDecimalNumber *dynamic_dhNum = [NSDecimalNumber decimalNumberWithString:dynamic_dh];
    NSDecimalNumber *bn_acc_ratioNum = [NSDecimalNumber decimalNumberWithString:bn_acc_ratio];
    NSDecimalNumber *bn_acc_blNum = [NSDecimalNumber decimalNumberWithString:bn_acc_bl];
    
    NSDecimalNumber *oneNum = [NSDecimalNumber decimalNumberWithString:@"1"];
    
    
    /*
             scale 结果保留几位小数
    
             raiseOnExactness 发生精确错误时是否抛出异常，一般为NO
    
             raiseOnOverflow 发生溢出错误时是否抛出异常，一般为NO
    
             raiseOnUnderflow 发生不足错误时是否抛出异常，一般为NO
    
             raiseOnDivideByZero 被0除时是否抛出异常，一般为YES
*/
    NSDecimalNumberHandler * rounUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:10 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];

    NSDecimalNumber *subNum = [oneNum decimalNumberBySubtracting:bn_acc_blNum withBehavior:rounUp];
    
    
    NSDecimalNumber *valueNum = [[dynamic_dhNum decimalNumberByDividingBy:bn_acc_ratioNum] decimalNumberByMultiplyingBy:subNum withBehavior:rounUp];
    
    NSLog(@"%@", valueNum);
    
    return valueNum;
    
}




@end
