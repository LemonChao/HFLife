//
//  BalanceTfAtHomeVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/4/16.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "BalanceTfAtHomeVC.h"
#import "BalanceTfVC.h"
//#import "GetTransferUserMessageNetApi.h"
@interface BalanceTfAtHomeVC ()
{
    UIButton *_nextButton;
}
@property (nonatomic,strong)UITextField *phoneTextField;
@end

@implementation BalanceTfAtHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEX_COLOR(0xeeeeee);
    [self setupNavBar];
    [self initWithUI];
    
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
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"转账";
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}
-(void)initWithUI{
    [self.view addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavBar.mas_bottom).offset(HeightRatio(31));
        make.height.mas_equalTo(HeightRatio(88));
    }];
    [self.phoneTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UILabel *label = [UILabel new];
    label.text = @"钱将实时转入对方账户，无法退还";
    label.font = [UIFont systemFontOfSize:WidthRatio(23)];
    label.textColor = HEX_COLOR(0x999999);
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(17));
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).offset(HeightRatio(20));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UIButton *nextButton = [UIButton new];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(36)];
    nextButton.backgroundColor = HEX_COLOR(0x91C4F8);
    [nextButton setTitleColor:HEX_COLOR(0xC8E3FE) forState:(UIControlStateNormal)];
    [nextButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [nextButton setTitle:@"下一步" forState:(UIControlStateNormal)];
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(18));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(18));
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).offset(HeightRatio(91));
        make.height.mas_equalTo(HeightRatio(84));
    }];
    _nextButton = nextButton;
}
- (void) textFieldDidChange:(id) sender {
    
    UITextField *_field = (UITextField *)sender;
    _nextButton.selected = _field.text.length>0;
    _nextButton.userInteractionEnabled = _field.text.length>0;
    _nextButton.backgroundColor = _field.text.length>0 ? HEX_COLOR(0x2285EB):HEX_COLOR(0x91C4F8);
}
-(void)nextButtonClick{
    
    if ([_phoneTextField.text isValidateMobile]) {
        
        
        
        /*
        
        GetTransferUserMessageNetApi *userMessage = [[GetTransferUserMessageNetApi alloc]initWithParameter:@{@"mobile":_phoneTextField.text}];
        [userMessage startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            GetTransferUserMessageNetApi *userMessageRequest = (GetTransferUserMessageNetApi *)request;
            if ([userMessageRequest getCodeStatus]==1) {
                NSDictionary *dict = [userMessageRequest getContent];
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    BalanceTfVC *blance =  [[BalanceTfVC alloc]init];
                    blance.userDict = dict;
                    [self.navigationController pushViewController:blance animated:YES];
                }else{
                    [WXZTipView showCenterWithText:@"暂未获取到用户信息"];
                }
            }else{
                [WXZTipView showCenterWithText:[userMessageRequest getMsg]];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [WXZTipView showCenterWithText:@"暂未获取到用户信息"];
        }];
         
         
         */
         
       
    }else{
        [WXZTipView showCenterWithText:@"请填写正确的手机号"];
    }
}
#pragma mark 懒加载
-(UITextField *)phoneTextField{
    if (!_phoneTextField) {
        UITextField *tf = [[UITextField alloc] init];
            //        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.placeholder = @"请输入手机号码";
        [tf setValue:HEX_COLOR(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x000000);
        tf.font = [UIFont systemFontOfSize:HeightRatio(28)];
        tf.backgroundColor = [UIColor whiteColor];
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(166), HeightRatio(88))];
        lv.backgroundColor = [UIColor clearColor];
        
        UILabel *segmentLabel  = [UILabel new];
        segmentLabel.text = @"对方账户";
        segmentLabel.textColor = HEX_COLOR(0x000000);
        segmentLabel.font = [UIFont systemFontOfSize:WidthRatio(28)];
        [lv addSubview:segmentLabel];
        [segmentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lv.mas_left).offset(WidthRatio(20));
            make.centerY.mas_equalTo(lv.mas_centerY);
            make.height.mas_equalTo(HeightRatio(26));
            make.width.mas_greaterThanOrEqualTo(1);
        }];
        
        UILabel *verticalLabel = [UILabel new];
        verticalLabel.backgroundColor = HEX_COLOR(0x000000);
        [lv addSubview:verticalLabel];
        [verticalLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lv.mas_left).offset(WidthRatio(65));
            make.centerY.mas_equalTo(lv.mas_centerY);
            make.height.mas_greaterThanOrEqualTo(1);
            make.width.mas_greaterThanOrEqualTo(1);
        }];
        
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = lv;
        [tf sizeToFit];
        
        UILabel *lin = [UILabel new];
        lin.backgroundColor = HEX_COLOR(0xDDDDDD);
        [tf addSubview:lin];
        [lin mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(tf);
            make.height.mas_equalTo(HeightRatio(1));
        }];
        [self.view addSubview:tf];
        _phoneTextField = tf;
    }
    return _phoneTextField;
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
