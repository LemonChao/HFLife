//
//  getOutFQ_VC.m
//  HFLife
//
//  Created by mac on 2019/4/22.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "getOutFQ_VC.h"
//#import "FQ_getOutNetApi.h"
#import "RichRightListVC.h"
//#import "FQ_collecteNetApi.h"
@interface getOutFQ_VC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
//当前富权价格
@property (weak, nonatomic) IBOutlet UILabel *currentMoneyLb;
//最山取出
//@property (weak, nonatomic) IBOutlet UILabel *LimitGetoutMoneyLb;

@property (weak, nonatomic) IBOutlet UITextField *limitGetoutMoneyTF;

@property (weak, nonatomic) IBOutlet UIButton *configerGetoutBtn;

@property (weak, nonatomic) IBOutlet UILabel *bottomTitleLb;

@property (nonatomic, strong)NSDictionary *valurDic;
@property (nonatomic, assign)CGFloat scale;//手续费比例

@property (weak, nonatomic) IBOutlet UILabel *getOutTitleLb;

@property (nonatomic, assign)CGFloat limitValue;//最小值

@end

@implementation getOutFQ_VC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    self.limitGetoutMoneyTF.delegate = self;
    self.limitCount = 10;
    
    //默认取出余额
    [self selectedBtnClick:self.selectedBtn];
    
}

- (void) reloadData{    
    self.currentMoneyLb.text = [NSString stringWithFormat:@"%@", self.valurDic[@"data"][@"static_coin"] ? self.valurDic[@"data"][@"static_coin"]: @"0.00"];
    
    self.limitGetoutMoneyTF.placeholder = [NSString stringWithFormat:@"最少兑换%@", self.valurDic[@"data"][@"acc_to_bn_min"] ? self.valurDic[@"data"][@"acc_to_bn_min"]: @"0.00"];
    
    self.scale = [self.valurDic[@"data"][@"acc_bn_bl"] floatValue];
    
    self.limitValue = [self.valurDic[@"data"][@"acc_to_bn_min"] floatValue];
}

//加载数据
- (void) getData{
    NSDictionary *param = @{
                            @"t" : @"acc_to_bn_view",
                            @"w" : @"warrant",
                            };
    /*
    FQ_collecteNetApi *collecteNetApi = [[FQ_collecteNetApi alloc] initWithParameter:param];
    WS(weakSelf);
    [collecteNetApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        FQ_collecteNetApi *collecteApi = (FQ_collecteNetApi *)request;
        NSDictionary *valueDic = [collecteApi responseJSONObject];
        if ([valueDic isKindOfClass:[NSDictionary class]]) {
            if ([collecteApi getCodeStatus] == 1) {
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







//全部取出
- (IBAction)getOutAllBtnClick:(UIButton *)sender{
    self.limitGetoutMoneyTF.text = self.currentMoneyLb.text;
    self.limitGetoutMoneyTF.textColor = [UIColor blackColor];
    self.limitGetoutMoneyTF.font = [UIFont systemFontOfSize:19 weight:1.5];
    [self textFieldChnage:self.limitGetoutMoneyTF];
}


- (IBAction)textFieldChnage:(UITextField *)sender {
    if (sender.text.length == 0) {
        sender.text = @"";
        [sender endEditing:YES];
        _configerGetoutBtn.backgroundColor = HEX_COLOR(0x91C4F8);
        _configerGetoutBtn.userInteractionEnabled = NO;
        _bottomTitleLb.text = @"持有天数越长，回报率越高";
        [self.limitGetoutMoneyTF setFont:[UIFont systemFontOfSize:14 weight:1]];
    }else{
        [self.limitGetoutMoneyTF setFont:[UIFont systemFontOfSize:19 weight:1.5]];
        self.limitGetoutMoneyTF.textColor = [UIColor blackColor];
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
        NSString *holeStr = [NSString stringWithFormat:@"预估到账：%@元", atrStr];
        NSMutableAttributedString *atrM = [[NSMutableAttributedString alloc] initWithString:holeStr];
        [atrM setAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} range:NSMakeRange(5, atrStr.length)];
        self.bottomTitleLb.attributedText = atrM;
        
        _configerGetoutBtn.backgroundColor = HEX_COLOR(0x2285EB);
        _configerGetoutBtn.userInteractionEnabled = YES;
    }
    if ([sender.text floatValue] > [self.currentMoneyLb.text floatValue]) {
        [WXZTipView showCenterWithText:@"不能超出当前可取出总额"];
    }
    if ([sender.text floatValue] < self.limitValue) {
        [WXZTipView showCenterWithText:@"输入金额不得小于最低取出额"];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([textField.text floatValue] > [self.currentMoneyLb.text floatValue]) {
        [WXZTipView showCenterWithText:@"输入金额超过余额"];
        return NO;
    }
    
    return [self limiTtextFled:textField shouldChangeCharactersInRange:range replacementString:string];
}



//取出
- (IBAction)getOutBtnClick:(UIButton *)sender{
    NSLog(@"取出");
    if (self.limitGetoutMoneyTF.text.length == 0) {
        [WXZTipView showCenterWithText:@"请输入兑换金额"];
        return;
    }
    if (!self.selectedBtn.selected) {
        [WXZTipView showCenterWithText:@"请选择取出方式"];
        return;
    }
    /*
    FQ_getOutNetApi *getOutNetApi = [[FQ_getOutNetApi alloc] initWithParameter:@{@"qc_num" : self.limitGetoutMoneyTF.text}];
    [getOutNetApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        FQ_getOutNetApi *getOutApi = (FQ_getOutNetApi *)request;
        NSDictionary *valurDic = [request responseJSONObject];
        if ([valurDic isKindOfClass:[NSDictionary class]]) {
            self.valurDic = valurDic;
            if ([[NSString stringWithFormat:@"%ld", (long)[getOutApi getCodeStatus]] isEqualToString:@"1"]) {
                [self getData];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
            }
            [WXZTipView showCenterWithText:valurDic[@"msg"]];
        }else{
            [WXZTipView showCenterWithText:@"取出失败！"];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [WXZTipView showCenterWithText:@"取出失败！请检查网络设置"];
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
    
    
//    富权取出记录
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"富权取出记录"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickRightButton:^{
        //跳转记录
        RichRightListVC *listVC = [RichRightListVC new];
        listVC.cellTitleArray = @[@"汉富商业发展", @"取出到余额",@"时间"];
//        listVC.cellValueArray = @[@"-1453.2546251487", @"1.0546287593份",@"2019-04-20"];
        listVC.recordType = 2;
        listVC.vcTitle = @"取出记录";
        [weakSelf.navigationController pushViewController:listVC animated:YES];
    }];
    
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:NO];
    self.customNavBar.title = @"富权取出";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    
    
    self.selectedBtn.layer.borderColor = HEX_COLOR(0xEEEEEE).CGColor;
    self.selectedBtn.layer.borderWidth = 1;
    self.selectedBtn.layer.cornerRadius = 10;
}






- (IBAction)selectedBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [sender setImage:[UIImage imageNamed:sender.selected ? @"icon_xuanzhong" : @""] forState:UIControlStateNormal];
    self.getOutTitleLb.text = sender.selected ? @"余额" : @"";
}

//用于货币高精度计算
- (NSDecimalNumber *) getcontent{
    
    NSString *static_coin = self.limitGetoutMoneyTF.text;
    NSString *bn_acc_ratio = [NSString stringWithFormat:@"%@", self.valurDic[@"data"][@"bn_acc_ratio"]];
    NSString *bn_acc_bl = [NSString stringWithFormat:@"%@", self.valurDic[@"data"][@"acc_bn_bl"]];
    //富权值
    NSDecimalNumber *static_coinNum = [NSDecimalNumber decimalNumberWithString:static_coin];
    //富权价格
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
    
    
    //富权价格：(富权值*富权价格)*(1-手续费比例)=可兑换余额
    
    //(1-手续费比例)
    NSDecimalNumber *subNum = [oneNum decimalNumberBySubtracting:bn_acc_blNum withBehavior:rounUp];
    
    
    NSDecimalNumber *valueNum = [[static_coinNum decimalNumberByMultiplyingBy:bn_acc_ratioNum] decimalNumberByMultiplyingBy:subNum withBehavior:rounUp];
    
    NSLog(@"%@", valueNum);
    
    return valueNum;
    
}

@end
