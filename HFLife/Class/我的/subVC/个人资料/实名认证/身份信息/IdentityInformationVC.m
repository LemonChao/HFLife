//
//  IdentityInformationVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/18.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "IdentityInformationVC.h"
#import "Per_MethodsToDealWithManage.h"
#import "ZHB_HP_PreventWeChatPopout.h"
@interface IdentityInformationVC ()
{
    NSString *certificateTypeString;
    NSArray *titleArray ;
}
@property (nonatomic,strong)Per_MethodsToDealWithManage *manage;
@property (nonatomic,strong)UITextField *userName;
@property (nonatomic,strong)UITextField *certificateType;
@property (nonatomic,strong)UITextField *idNumberTextField;
@end

@implementation IdentityInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArray = @[@"居民身份证(大陆)", @"军官证",@"护照", @"港澳台居民身份证"];
    if ([UserCache getSaveCertificateType].length > 0) {
        certificateTypeString = MMNSStringFormat(@"%ld",[titleArray indexOfObject:[UserCache getSaveCertificateType]]);
    }else{
        certificateTypeString = @"";
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"fanhuianniu"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar setOnClickRightButton:^{
        
    }];
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"实名认证";

  
}
-(void)initWithUI{
    WS(weakSelf);
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.image = MMGetImage_x(@"audit_one");
    bgImageView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        if (weakSelf.heightStatus == 44.0) {
			 make.height.mas_equalTo(HeightRatio(349)+22);
        }else{
             make.height.mas_equalTo(HeightRatio(349));
        }
    }];
    
    UIImageView *textBgImageView  = [UIImageView new];
    textBgImageView.image = MMGetImage(@"personal_beijing");
    [self.view addSubview:textBgImageView];
    [textBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(313));
        make.top.mas_equalTo(bgImageView.mas_bottom).offset(-HeightRatio(43));
    }];
    
    self.userName = [self getTextFieldPlaceholder:@"请输入您的姓名" title:@"您的姓名"];
    self.userName.text =  [UserCache getSaveRealNameWriteName];
    [self.view addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textBgImageView.mas_top);
        make.left.mas_equalTo(textBgImageView.mas_left).offset(WidthRatio(25));
        make.right.mas_equalTo(textBgImageView.mas_right).offset(-WidthRatio(25));
        make.height.mas_equalTo(HeightRatio(100));
    }];
    
    UILabel *lin = [UILabel new];
    lin.backgroundColor = HEX_COLOR(0xebebeb);
    [self.view addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.userName);
        make.top.mas_equalTo(self.userName.mas_bottom);
        make.height.mas_equalTo(HeightRatio(3));
    }];
    
    self.certificateType = [self getTextFieldPlaceholder:@"请选择证件类型" title:@"证件类型"];
    self.certificateType.text =  [UserCache getSaveCertificateType];
    [self.view addSubview:self.certificateType];
    [self.certificateType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lin.mas_bottom);
        make.left.mas_equalTo(textBgImageView.mas_left).offset(WidthRatio(25));
        make.right.mas_equalTo(textBgImageView.mas_right).offset(-WidthRatio(25));
        make.height.mas_equalTo(HeightRatio(100));
    }];
    UIImageView *certificateImageView = [UIImageView new];
    certificateImageView.image = MMGetImage(@"icon_kuozhan");
    [self.certificateType addSubview:certificateImageView];
    [certificateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.certificateType.mas_right).offset(-WidthRatio(53));
        make.centerY.mas_equalTo(self.certificateType.mas_centerY);
        make.width.mas_equalTo(WidthRatio(12));
        make.height.mas_equalTo(HeightRatio(22));
    }];
    UIButton *certificateBtn = [UIButton new];
    certificateBtn.backgroundColor = [UIColor clearColor];
    [certificateBtn addTarget:self action:@selector(certificateBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:certificateBtn];
    [certificateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lin.mas_bottom);
        make.left.mas_equalTo(textBgImageView.mas_left).offset(WidthRatio(25));
        make.right.mas_equalTo(textBgImageView.mas_right).offset(-WidthRatio(25));
        make.height.mas_equalTo(HeightRatio(100));
    }];
    
    
    UILabel *lin_2 = [UILabel new];
    lin_2.backgroundColor = HEX_COLOR(0xebebeb);
    [self.view addSubview:lin_2];
    [lin_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.userName);
        make.top.mas_equalTo(self.certificateType.mas_bottom);
        make.height.mas_equalTo(HeightRatio(3));
    }];
    
    self.idNumberTextField = [self getTextFieldPlaceholder:@"请输入证件号码" title:@"证件号码"];
    self.idNumberTextField.text = [UserCache getSaveRealNameWriteIDCare];
    [self.view addSubview:self.idNumberTextField];
    [self.idNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lin_2.mas_bottom);
        make.left.mas_equalTo(textBgImageView.mas_left).offset(WidthRatio(25));
        make.right.mas_equalTo(textBgImageView.mas_right).offset(-WidthRatio(25));
        make.height.mas_equalTo(HeightRatio(100));
    }];
  
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(WidthRatio(22), HeightRatio(135)+textBgImageView.ly_y+textBgImageView.height, SCREEN_WIDTH-WidthRatio(22)-WidthRatio(22), HeightRatio(88))];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0,  SCREEN_WIDTH-WidthRatio(22)-WidthRatio(22), HeightRatio(88));
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.38),@(0.6),@(0.8),@(1.0)];//渐变点
    
    [gradientLayer setColors:@[(id)[HEX_COLOR(0x9f22ff) CGColor],(id)[HEX_COLOR(0x9323ff) CGColor],(id)HEX_COLOR(0x7f23ff).CGColor]];//渐变数组
    [button.layer addSublayer:gradientLayer];
    [button setTitle:@"下一步" forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(31)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        button.frame = CGRectMake(WidthRatio(22), HeightRatio(135)+textBgImageView.ly_y+textBgImageView.height, SCREEN_WIDTH-WidthRatio(22)-WidthRatio(22), HeightRatio(88));
    });
    MMViewBorderRadius(button, WidthRatio(10), 0, [UIColor clearColor]);
    
    
    UIButton *btn = [UIButton new];
    btn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
    [btn setTitle:@"汉富金融保障您的账户安全" forState:(UIControlStateNormal)];
    [btn setTitleColor:HEX_COLOR(0x969696) forState:(UIControlStateNormal)];
    [btn setImage:MMGetImage(@"anquan") forState:(UIControlStateNormal)];
    [btn setImagePosition:ImagePositionTypeLeft spacing:ScreenScale(15)];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-HeightRatio(72));
        make.height.mas_equalTo(HeightRatio(22));
    }];
}
-(UITextField *)getTextFieldPlaceholder:(NSString *)placeholder title:(NSString *)title{
    UITextField *tf = [[UITextField alloc] init];
    tf.keyboardType = UIKeyboardTypeTwitter;
    tf.placeholder = placeholder;
    [tf setValue:HEX_COLOR(0x9b9b9b) forKeyPath:@"_placeholderLabel.textColor"];
    tf.textColor = HEX_COLOR(0x5b5b5b);
    tf.font = [UIFont systemFontOfSize:HeightRatio(26)];
    tf.backgroundColor = [UIColor clearColor];
    
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(179), HeightRatio(90))];
    lv.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [lv addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lv.mas_left).offset(WidthRatio(8));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_equalTo(HeightRatio(26));
        make.centerY.mas_equalTo(lv.mas_centerY);
    }];
    
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.leftView = lv;
    [tf sizeToFit];

    return tf;
}
-(void)buttonClick{
    if (self.userName.text.length == 0) {
        [WXZTipView showCenterWithText:@"请填写您的姓名"];
        return;
    }
    if (self.idNumberTextField.text.length == 0) {
        [WXZTipView showCenterWithText:@"请填写您的姓名"];
        return;
    }
    if (self.certificateType.text.length == 0) {
        [WXZTipView showCenterWithText:@"请选择证件类型"];
        return;
    }
    
    if (![self.idNumberTextField.text isValidateIdentityCard]&&[certificateTypeString isEqualToString:@"0"]) {
        [WXZTipView showCenterWithText:@"请填写正确的身份证号码"];
        return;
    }
    
    if (![self.idNumberTextField.text isHKTCard]&&[certificateTypeString isEqualToString:@"3"]) {
        [WXZTipView showCenterWithText:@"请填写正确的港澳台居民身份证号"];
        return;
    }
    if (![self.idNumberTextField.text isPassport]&&[certificateTypeString isEqualToString:@"2"]) {
        [WXZTipView showCenterWithText:@"请填写正确的护照号码"];
        return;
    }
//    
    if (![self.idNumberTextField.text isOfficer]&&[certificateTypeString isEqualToString:@"1"]) {
        [WXZTipView showCenterWithText:@"请填写正确的军官证"];
        return;
    }
    
    [UserCache setSaveRealNameWriteName:self.userName.text];
    [UserCache setSaveRealNameWriteIDCare:self.idNumberTextField.text];
    [UserCache setSaveCertificateType:self.certificateType.text];
    NSDictionary *dic = @{@"true_name":self.userName.text,
                          @"idcard":self.idNumberTextField.text,
                          @"certificateType":certificateTypeString
                          };
    [self.manage identityInformationCompletiondict:dic];
}
-(void)certificateBtnClick{

    ZHB_HP_PreventWeChatPopout *alertSheetView = [[ZHB_HP_PreventWeChatPopout alloc] initWithTitle:@"" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:titleArray actionSheetBlock:^(NSInteger index) {
        NSLog(@"block点击的是:%zd", index);
        self->certificateTypeString = MMNSStringFormat(@"%ld",index);
        self.certificateType.text = self->titleArray[index];
        if (index == 1) {
            self.idNumberTextField.keyboardType = UIKeyboardTypeDefault;
        }else{
            self.idNumberTextField.keyboardType = UIKeyboardTypeTwitter;
        }
    }];
    [alertSheetView show];
}
#pragma mark 懒加载
-(Per_MethodsToDealWithManage *)manage{
    if (!_manage) {
        _manage = [Per_MethodsToDealWithManage sharedInstance];
    }
    _manage.superVC = self;
    return _manage;
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
