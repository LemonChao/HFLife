//
//  SetAmountVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/22.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "SetAmountVC.h"

@interface SetAmountVC ()<UITextFieldDelegate>
/** 设置金额 */
@property (nonatomic,strong) UITextField *amountTextField;
@end

@implementation SetAmountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEX_COLOR(0xf9f9f9);
    [self initWithUI];
    [self setupNavBar];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"设置金额";
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    

}
-(void)initWithUI{
    [self.view addSubview:self.amountTextField];
    self.amountTextField.delegate = self;
    [self.amountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight+HeightRatio(10));
        make.height.mas_equalTo(HeightRatio(90));
    }];
    
    UIButton *button = [[UIButton alloc]init];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.top.mas_equalTo(self.amountTextField.mas_bottom).offset(HeightRatio(30));
        make.height.mas_equalTo(HeightRatio(88));
    }];
        // 0.1秒后获取frame
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0,  SCREEN_WIDTH-WidthRatio(20)-WidthRatio(20), HeightRatio(88));
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.38),@(0.6),@(0.8),@(1.0)];//渐变点
        
        [gradientLayer setColors:@[(id)[HEX_COLOR(0x9f22ff) CGColor],(id)[HEX_COLOR(0x9323ff) CGColor],(id)HEX_COLOR(0x7f23ff).CGColor]];//渐变数组
        [button.layer addSublayer:gradientLayer];
        MMViewBorderRadius(button, WidthRatio(10), 0, [UIColor clearColor]);
        [button setTitle:@"确认修改" forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    });

}
#pragma mark 代理
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return [self limiTtextFled:textField shouldChangeCharactersInRange:range replacementString:string];
}
#pragma mark 懒加载
-(UITextField *)amountTextField{
    if (!_amountTextField) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入金额";
        [tf setValue:HEX_COLOR(0x666666) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x333333);
        tf.font = [UIFont systemFontOfSize:HeightRatio(25)];
        tf.backgroundColor = [UIColor whiteColor];
        tf.keyboardType = UIKeyboardTypeDecimalPad;
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(90), HeightRatio(90))];
        lv.backgroundColor = [UIColor clearColor];
        
        UILabel *titleLabel  = [UILabel new];
        titleLabel.text = @"金额";
        titleLabel.textColor = HEX_COLOR(0x333333);
        titleLabel.font = [UIFont systemFontOfSize:WidthRatio(27)];
        [lv addSubview:titleLabel];
        [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lv.mas_left).offset(WidthRatio(10));
            make.centerY.mas_equalTo(lv.mas_centerY);
            make.height.mas_equalTo(HeightRatio(27));
            make.width.mas_greaterThanOrEqualTo(1);
        }];
        
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = lv;
        [tf sizeToFit];
        _amountTextField = tf;
    }
    return _amountTextField;
}
-(void)buttonClick{
    [self.view endEditing:NO];
    if ([NSString isNOTNull:self.amountTextField.text]) {
        [WXZTipView showCenterWithText:@"请输入金额"];
        return;
    }
    NSLog(@"数字 = %@",[self balanceFormatFromStr:self.amountTextField.text]);
    if ([self.amountDelegate respondsToSelector:@selector(SetAmountNumber:)]) {
        [self.amountDelegate SetAmountNumber:[self balanceFormatFromStr:self.amountTextField.text]];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (NSString *)balanceFormatFromStr:(NSString*)string
{
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumberFormatter *numFormatter2 = [[NSNumberFormatter alloc] init];
    [numFormatter2 setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber *num = [numFormatter2 numberFromString:string];
    NSString *tempStr = [numFormatter stringFromNumber:num];
    NSString *balanceStr = [tempStr substringFromIndex:1];
    if ([tempStr hasPrefix:@"-"]) {
        balanceStr = [NSString stringWithFormat:@"-%@",[tempStr substringFromIndex:2]];
    }
    return balanceStr;
    
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
