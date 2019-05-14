//
//  ModifyNicknameVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/18.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "ModifyNicknameVC.h"
//#import "HP_ChangeNicknameNetApi.h"
@interface ModifyNicknameVC ()
{
    UITextField *userNameTextField;
}

@end

@implementation ModifyNicknameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEX_COLOR(0xf4f7f7);
    // Do any additional setup after loading the view.
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
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar setOnClickRightButton:^{
        NSLog(@"搜索");
    }];
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"个人资料";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    self.customNavBar.backgroundColor = [UIColor whiteColor];
}
-(void)initWithUI{
    userNameTextField = [UITextField new];
    userNameTextField.backgroundColor = [UIColor whiteColor];
    userNameTextField.textColor = [UIColor blackColor];
    userNameTextField.font = [UIFont systemFontOfSize:WidthRatio(30)];
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView.backgroundColor = [UIColor clearColor];
    userNameTextField.leftView = leftView;
    userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    userNameTextField.placeholder = @"请输入昵称";
    userNameTextField.text = [UserCache getUserNickName];
    
    [self.view addSubview:userNameTextField];
    [userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(HeightRatio(20)+self.navBarHeight);
        make.right.mas_equalTo(self.view).mas_offset(-0);
        make.left.mas_equalTo(self.view).mas_offset(0);
        make.height.mas_equalTo(HeightRatio(90));
    }];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(WidthRatio(20), HeightRatio(264)+self.navBarHeight, SCREEN_WIDTH-WidthRatio(20)-WidthRatio(20), HeightRatio(88))];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0,  SCREEN_WIDTH-WidthRatio(20)-WidthRatio(20), HeightRatio(88));
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.38),@(0.6),@(0.8),@(1.0)];//渐变点
    
    [gradientLayer setColors:@[(id)[HEX_COLOR(0x9f22ff) CGColor],(id)[HEX_COLOR(0x9323ff) CGColor],(id)HEX_COLOR(0x7f23ff).CGColor]];//渐变数组
    [button.layer addSublayer:gradientLayer];
    [button setTitle:@"保存" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    MMViewBorderRadius(button, WidthRatio(10), 0, [UIColor clearColor]);
}
-(void)buttonClick{
    if ([NSString isNOTNull:userNameTextField.text]) {
        [WXZTipView showCenterWithText:@"请输入昵称"];
        return;
    }
    
    /*
    
    HP_ChangeNicknameNetApi *change = [[HP_ChangeNicknameNetApi alloc]initWithParameter:@{@"nickname":userNameTextField.text}];
    [change startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_ChangeNicknameNetApi *changeApi = (HP_ChangeNicknameNetApi *)request;
       	[WXZTipView showCenterWithText:[changeApi getMsg]];
        if ([changeApi getCodeStatus]==1) {
            if (self.modifiedSuccessfulBlock) {
                self.modifiedSuccessfulBlock(self->userNameTextField.text);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_ChangeNicknameNetApi *changeApi = (HP_ChangeNicknameNetApi *)request;
        [WXZTipView showCenterWithText:[changeApi getMsg]];
    }];
     
     */
    
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
