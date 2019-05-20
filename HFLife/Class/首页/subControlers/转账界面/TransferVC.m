//
//  TransferVC.m
//  HFLife
//
//  Created by sxf on 2019/3/22.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "TransferVC.h"
#import "RYNumberKeyboard.h"
#import "UITextField+RYNumberKeyboard.h"
#import "HHPayPasswordView.h"
#import "IQKeyboardManager.h"
//#import "HP_TransferNetApi.h"
#import "RSAEncryptor.h"
//#import "HP_PaymentGenerateOrdersNetApi.h"
//#import "HP_ScanQRCodePaymentNetApi.h"
@interface TransferVC ()<HHPayPasswordViewDelegate>
{
    UITextField *textField;
}
@property (nonatomic,strong)NSString *order_id;
@end

@implementation TransferVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithUI];
    [self setupNavBar];
	 [textField becomeFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
        //TODO: 页面appear 禁用
    [[IQKeyboardManager sharedManager] setEnable:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
        //TODO: 页面Disappear 启用
    [[IQKeyboardManager sharedManager] setEnable:YES];
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
    self.customNavBar.title = self.ispayment?@"付款":@"转账";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}
-(void)initWithUI{
    UIImageView *headImageView =[UIImageView new];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString judgeNullReturnString:self.uesrImage]] placeholderImage:MMGetImage(@"logo")];
//    [headImageView sd_setImageWithURL:[NSURL URLWithString:[UserCache getUserPic]] placeholderImage:MMGetImage(@"")];
    [self.view addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight+HeightRatio(30));
        make.width.height.mas_equalTo(WidthRatio(130));
    }];
    MMViewBorderRadius(headImageView, WidthRatio(10), 0, [UIColor clearColor]);
    
    UILabel *nicekName = [UILabel new];
    nicekName.text = self.userName;
    nicekName.font = [UIFont systemFontOfSize:WidthRatio(31)];
    nicekName.textColor = [UIColor blackColor];
    [self.view addSubview:nicekName];
    [nicekName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
        make.top.mas_equalTo(headImageView.mas_bottom).offset(HeightRatio(17));
    }];
    
    UILabel *phoneLabel = [UILabel new];
//    phoneLabel.text = [NSString isNOTNull:[UserCache getUserPhone]] ?@"" : [[UserCache getUserPhone] EncodeTel];
    phoneLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
    phoneLabel.textColor = HEX_COLOR(0x999999);
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
        make.top.mas_equalTo(nicekName.mas_bottom).offset(HeightRatio(18));
    }];
    
#warning 隐藏电话
    phoneLabel.hidden = YES;
    
    
    
    
    UILabel *title_label = [UILabel new];
    title_label.text = self.ispayment?@"付款金额":@"转账金额";
    title_label.font = [UIFont systemFontOfSize:WidthRatio(27)];
    title_label.textColor = HEX_COLOR(0x3e3e3e);
    [self.view addSubview:title_label];
    [title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(31));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
        make.top.mas_equalTo(phoneLabel.mas_bottom).offset(HeightRatio(62));
    }];
    
    UILabel *icon_label = [UILabel new];
    icon_label.text = @"¥";
    icon_label.font = [UIFont systemFontOfSize:WidthRatio(46)];
    icon_label.textColor = [UIColor blackColor];
    [self.view addSubview:icon_label];
    [icon_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(31));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
        make.top.mas_equalTo(title_label.mas_bottom).offset(HeightRatio(67));
    }];
    
    textField = [UITextField new];
    textField.ry_inputType = RYFloatInputType;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:WidthRatio(83)];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.ry_interval = 6;
    if (![NSString isNOTNull:self.amount]) {
        if ([self.amount floatValue]>0) {
            textField.text = self.amount;
        }
        
    }
   
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(76));
        make.centerY.mas_equalTo(icon_label.mas_centerY);
        make.height.mas_equalTo(HeightRatio(126));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(31));
    }];
    
    UILabel *lin = [UILabel new];
    lin.backgroundColor = HEX_COLOR(0xcccccc);
    [self.view addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->textField.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(30));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(30));
        make.height.mas_equalTo(HeightRatio(1));
    }];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(WidthRatio(30), HeightRatio(585)+self.navBarHeight, SCREEN_WIDTH-WidthRatio(30)-WidthRatio(30), HeightRatio(96))];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0,  SCREEN_WIDTH-WidthRatio(20)-WidthRatio(20), HeightRatio(88));
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.38),@(0.6),@(0.8),@(1.0)];//渐变点
    
    [gradientLayer setColors:@[(id)[HEX_COLOR(0x9f22ff) CGColor],(id)[HEX_COLOR(0x9323ff) CGColor],(id)HEX_COLOR(0x7f23ff).CGColor]];//渐变数组
    [button.layer addSublayer:gradientLayer];
    [button setTitle:@"确认支付" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    MMViewBorderRadius(button, WidthRatio(10), 0, [UIColor clearColor]);
}
-(void)buttonClick{
    if (textField.text.length == 0) {
        [WXZTipView showCenterWithText:@"请输入金额"];
        return;
    }
    WS(weakSelf);
    
    /*
    
    HP_PaymentGenerateOrdersNetApi *orderNetApi = [[HP_PaymentGenerateOrdersNetApi alloc]initWithParameter:@{@"app_type":@"1",@"bn_num":textField.text,@"code_str":self.code_str}];
    [orderNetApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        HP_PaymentGenerateOrdersNetApi *orderRequest = (HP_PaymentGenerateOrdersNetApi *)request;
        if ([orderRequest getCodeStatus]==1) {
            NSDictionary *dict = [orderNetApi getContent];
            if ([dict isKindOfClass:[NSDictionary class]]) {
                weakSelf.order_id = dict[@"order_id"];
                HHPayPasswordView *payPasswordView = [[HHPayPasswordView alloc] init];
                payPasswordView.delegate = self;
                [payPasswordView showInView:self.view];
            }else{
                [WXZTipView showCenterWithText:@"数据出错"];
            }
        }else{
            [WXZTipView showCenterWithText:[orderRequest getMsg]];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [WXZTipView showCenterWithText:@"网络数据出错"];
    }];
     
     */
   
}
#pragma mark - HHPayPasswordViewDelegate
- (void)passwordView:(HHPayPasswordView *)passwordView didFinishInputPayPassword:(NSString *)password{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        if ([password isEqualToString:@"000000"]) {
//            [passwordView paySuccess];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [passwordView hide];
//
//            });
//        }else{
//            [passwordView payFailureWithPasswordError:YES withErrorLimit:3];
//        }
//    });
//    NSString *encryptStr = [RSAEncryptor encryptString:password publicKey:ENCRYPTIONPUBLICKEY];
    if (self.ispayment) {
        
        /*
        
        HP_ScanQRCodePaymentNetApi *pay = [[HP_ScanQRCodePaymentNetApi alloc]initWithParameter:@{@"order_id":[NSString judgeNullReturnString:[NSString judgeNullReturnString:self.order_id]],@"paypassword":password}];
        [pay startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [passwordView hide];
            HP_ScanQRCodePaymentNetApi *payRequest = (HP_ScanQRCodePaymentNetApi *)request;
            if ([payRequest getCodeStatus]==1) {
                [self.navigationController popToRootViewControllerAnimated:YES];
                [WXZTipView showCenterWithText:[payRequest getMsg]];
            }else{
                [WXZTipView showCenterWithText:[payRequest getMsg]];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [passwordView hide];
            [WXZTipView showCenterWithText:@"网络数据出错"];
        }];
        
    }else{
        HP_TransferNetApi *trans = [[HP_TransferNetApi alloc]initWithParameter:@{@"code_str":self.code_str,@"bn_num":textField.text,@"paypassword":password}];
        [trans startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [passwordView hide];
            HP_TransferNetApi *transRequest = (HP_TransferNetApi *)request;
            if ([transRequest getCodeStatus]==1) {
                [WXZTipView showCenterWithText:@"支付成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [WXZTipView showCenterWithText:[transRequest getMsg]];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [passwordView hide];
        }];
         
         */
    }
    
}
- (void)forgetPayPassword{
   
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
