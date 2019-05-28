//
//  SubscribeSubmitVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/3/18.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "SubscribeSubmitVC.h"
//#import "HP_ReserveSubmitNetApi.h"
#import "PreorderTableVC.h"
@interface SubscribeSubmitVC ()
{
//    信息
    UILabel *messageLabel;
//    输入框
    UITextField *userNameText;
    
    UITextField *phoneText;
    
    UIButton *selectBtn;
}
@end

@implementation SubscribeSubmitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithUI];
    [self setupNavBar];
}
-(void)initWithUI{
    UIView *one_view = [self vesselViewImageName:@"editor"];
    [self.view addSubview:one_view];
    [one_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(HeightRatio(82));
    }];
    messageLabel = [UILabel new];
    messageLabel.textColor = HEX_COLOR(0xf88e2b);
    messageLabel.font = [UIFont systemFontOfSize:WidthRatio(27)];
//    messageLabel.text = @"2人，3月18日 18:30，大厅聚餐";
    NSString *site = [self.dataDict[@"appoint_site"] isEqualToString:@"1"]?@"大厅":@"包间";
    NSString *str = MMNSStringFormat(@"%@人 %@ %@ %@聚餐",self.dataDict[@"appoint_num"],self.dataDict[@"appoint_date"],self.dataDict[@"appoint_time"],site);
    messageLabel.text = str;
    [one_view addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(one_view.mas_left).offset(WidthRatio(128));
        make.top.right.bottom.mas_equalTo(one_view);
    }];
    
    
    UIView *two_view = [self vesselViewImageName:@"linkman"];
    [self.view addSubview:two_view];
    [two_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(one_view.mas_bottom);
        make.height.mas_equalTo(HeightRatio(82));
    }];
    
    userNameText = [UITextField new];
    userNameText.placeholder = @"请填写用餐人姓名";
    userNameText.font = [UIFont systemFontOfSize:WidthRatio(28)];
    [two_view addSubview:userNameText];
    
    UIButton *manBtn = [UIButton new];
    manBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(27)];
    [manBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [manBtn setTitle:@"先生" forState:(UIControlStateNormal)];
    [manBtn setImage:MMGetImage(@"choose_NO") forState:(UIControlStateNormal)];
    [manBtn setImage:MMGetImage(@"choose_YES") forState:(UIControlStateSelected)];
    [manBtn addTarget:self action:@selector(selectBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    // !!!: [manBtn setImagePositionWithType:(SSImagePositionTypeLeft) spacing:WidthRatio(14)]
//    [manBtn setImagePositionWithType:(SSImagePositionTypeLeft) spacing:WidthRatio(14)];
    [two_view addSubview:manBtn];
    [manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(two_view.mas_right).offset(-WidthRatio(47));
        make.centerY.mas_equalTo(two_view.mas_centerY);
        make.height.mas_equalTo(HeightRatio(32));
        make.width.mas_equalTo(WidthRatio(100));
    }];
    
    UIButton *ladyBtn = [UIButton new];
    ladyBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(27)];
    [ladyBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [ladyBtn setTitle:@"女士" forState:(UIControlStateNormal)];
    [ladyBtn setImage:MMGetImage(@"choose_NO") forState:(UIControlStateNormal)];
    [ladyBtn setImage:MMGetImage(@"choose_YES") forState:(UIControlStateSelected)];
    [ladyBtn addTarget:self action:@selector(selectBtn:) forControlEvents:(UIControlEventTouchUpInside)];
//    [ladyBtn setImagePositionWithType:(SSImagePositionTypeLeft) spacing:WidthRatio(14)];
    [two_view addSubview:ladyBtn];
    ladyBtn.selected = YES;
    selectBtn = ladyBtn;
    [ladyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(manBtn.mas_left).offset(-WidthRatio(57));
        make.centerY.mas_equalTo(two_view.mas_centerY);
        make.height.mas_equalTo(HeightRatio(32));
        make.width.mas_equalTo(WidthRatio(100));
    }];
    [userNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(one_view.mas_left).offset(WidthRatio(128));
        make.right.mas_equalTo(ladyBtn.mas_left).offset(WidthRatio(0));
        make.top.bottom.mas_equalTo(two_view);
    }];
    
    
    UIView *three_view = [self vesselViewImageName:@"telephone"];
    [self.view addSubview:three_view];
    [three_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(two_view.mas_bottom);
        make.height.mas_equalTo(HeightRatio(82));
    }];
    
    UIButton *numberBtn = [UIButton new];
    numberBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
    [numberBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [numberBtn setTitle:@"+86" forState:(UIControlStateNormal)];
    [numberBtn setImage:MMGetImage(@"numberSegment") forState:(UIControlStateNormal)];
//    [numberBtn setImagePositionWithType:(SSImagePositionTypeRight) spacing:WidthRatio(17)];
//    numberBtn.backgroundColor = [UIColor redColor];
    [three_view addSubview:numberBtn];
    [numberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(one_view.mas_left).offset(WidthRatio(128));
        make.centerY.mas_equalTo(three_view.mas_centerY);
        make.height.mas_equalTo(HeightRatio(22));
        make.width.mas_equalTo(WidthRatio(100));
    }];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(numberBtn.frame.size.width - WidthRatio(1), 0, WidthRatio(1), numberBtn.frame.size.height);
    layer.backgroundColor = HEX_COLOR(0xeaeaea).CGColor;
    [numberBtn.layer addSublayer:layer];
   
    phoneText = [UITextField new];
    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    phoneText.placeholder = @"请填写手机号";
    phoneText.font = [UIFont systemFontOfSize:WidthRatio(28)];
    [three_view addSubview:phoneText];
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(numberBtn.mas_right);
        make.top.bottom.right.mas_equalTo(three_view);
    }];
    
    UIButton *button = [UIButton new];
    [button setTitle:@"立即订座" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(30)];
    button.backgroundColor =HEX_COLOR(0xf88404);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    MMViewBorderRadius(button, WidthRatio(15), 0, [UIColor clearColor]);
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(21));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(21));
        make.height.mas_equalTo(HeightRatio(80));
        make.bottom.mas_equalTo(-(HomeIndicatorHeight+HeightRatio(44)));
    }];
    
}
-(UIView *)vesselViewImageName:(NSString *)imageName{
    UIView *vesselV = [UIView new];
    vesselV.backgroundColor = [UIColor whiteColor];
    UIImageView *iconImageView = [UIImageView new];
    iconImageView.image = MMGetImage(imageName);
    [vesselV addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(vesselV.mas_centerY);
        make.left.mas_equalTo(vesselV.mas_left).offset(WidthRatio(31));
        make.width.height.mas_equalTo(WidthRatio(40));
    }];
    UILabel *lin = [UILabel new];
    lin.backgroundColor = HEX_COLOR(0xeaeaea);
    [vesselV addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
       	make.left.mas_equalTo(vesselV.mas_left).offset(WidthRatio(87));
    	make.bottom.mas_equalTo(vesselV.mas_bottom);
        make.right.mas_equalTo(vesselV.mas_right).offset(-WidthRatio(18));
        make.height.mas_equalTo(HeightRatio(1));
    }];
    return vesselV;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
//    [self axcBaseRequestData];
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
    self.customNavBar.title = @"预定";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}
-(void)selectBtn:(UIButton *)send{
    if (selectBtn != send) {
        selectBtn.selected = NO;
        send.selected = YES;
        selectBtn = send;
    }
}
-(void)buttonClick{
    if ([NSString isNOTNull:userNameText.text]) {
        [WXZTipView showCenterWithText:@"请填写预约人的姓名"];
        return;
    }
    if (![phoneText.text isValidateMobile]) {
        [WXZTipView showCenterWithText:@"请填写正确的手机号"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setDictionary:self.dataDict];
    [dic setObject:userNameText.text forKey:@"appoint_name"];
    [dic setObject:phoneText.text forKey:@"appoint_tel"];
    // !!!: [[HP_ReserveSubmitNetApi alloc]initWithParameter:dic]
//    HP_ReserveSubmitNetApi *reserv = [[HP_ReserveSubmitNetApi alloc]initWithParameter:dic];
//    [reserv startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        HP_ReserveSubmitNetApi *reservRequest = (HP_ReserveSubmitNetApi *)request;
//        if ([reservRequest getContent]) {
//            [WXZTipView showCenterWithText:@"预约成功"];
//            for (UIViewController *vc in self.navigationController.viewControllers) {
//                if ([vc isKindOfClass:[PreorderTableVC class]]) {
//                    [self.navigationController popToViewController:vc animated:YES];
//                }
//            }
//        }else{
//            [WXZTipView showCenterWithText:@"预约失败"];
//        }
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [WXZTipView showCenterWithText:@"预约失败"];
//    }];
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
