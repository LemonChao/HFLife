//
//  ReviewResultsVC.m
//  HanPay
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ReviewResultsVC.h"
#import "PersonalDataVC.h"
#import "SecurityCenterVC.h"
@interface ReviewResultsVC ()
{
    UIImageView *headImageView;
    UILabel *nameLabel;
    UILabel *phoneLabel;
    
    UILabel *idLabel;
}
@end

@implementation ReviewResultsVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
//    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"fanhuianniu"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{ 
//        [weakSelf.navigationController popViewControllerAnimated:YES];
        BOOL isJustBack = YES;
        for (UIViewController *vc in weakSelf.navigationController.viewControllers) {
            if ([vc isKindOfClass:[PersonalDataVC class]]) {
                isJustBack = NO;
                [weakSelf.navigationController popToViewController:vc animated:YES];
            }else if ([vc isKindOfClass:[SecurityCenterVC class]]){
                isJustBack = NO;
                [weakSelf.navigationController popToViewController:vc animated:YES];
            }
        }
        if (isJustBack) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
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
    bgImageView.image = MMGetImage_x(@"audit_three");
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
    
    UIImageView *reviewResultsBgImageView  = [UIImageView new];
    reviewResultsBgImageView.image = MMGetImage(@"ReviewResultsbeijing");
    reviewResultsBgImageView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:reviewResultsBgImageView];
    [reviewResultsBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(487));
        make.top.mas_equalTo(bgImageView.mas_bottom).offset(-HeightRatio(43));
    }];
    
    headImageView = [UIImageView new];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:[userInfoModel sharedUser].member_avatar] placeholderImage:MMGetImage(@"logo")];
    [self.view addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(reviewResultsBgImageView.mas_top).offset(HeightRatio(68));
        make.width.height.mas_equalTo(WidthRatio(142));
    }];
    MMViewBorderRadius(headImageView, WidthRatio(142)/2, WidthRatio(7), [UIColor whiteColor]);
    
    nameLabel = [UILabel new];
//    nameLabel.text = [UserCache getUserRealName] ? [UserCache getUserRealName] : [UserCache getSaveRealNameWriteName];//@"***";
    nameLabel.text = [userInfoModel sharedUser].realname;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:WidthRatio(32)];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.top.mas_equalTo(self->headImageView.mas_bottom).offset(HeightRatio(43));
        make.height.mas_equalTo(HeightRatio(32));
    }];
    
    phoneLabel = [UILabel new];
//    phoneLabel.text = [NSString mobileNumberEncryption:[UserCache getUserPhone]];
    phoneLabel.text = [userInfoModel sharedUser].member_mobile;
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.textColor = HEX_COLOR(0x9a9a9a);
    phoneLabel.font = [UIFont systemFontOfSize:WidthRatio(27)];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.top.mas_equalTo(self->nameLabel.mas_bottom).offset(HeightRatio(43));
        make.height.mas_equalTo(HeightRatio(27));
    }];
    
    
    idLabel = [UILabel new];
//    idLabel.text = [NSString EncodeidCard:[UserCache getSaveRealNameWriteIDCare]];
    idLabel.textAlignment = NSTextAlignmentCenter;
    idLabel.textColor = HEX_COLOR(0x9a9a9a);
    idLabel.font = [UIFont systemFontOfSize:WidthRatio(27)];
    [self.view addSubview:idLabel];
    [idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.top.mas_equalTo(self->phoneLabel.mas_bottom).offset(HeightRatio(43));
        make.height.mas_equalTo(HeightRatio(27));
    }];
//     if ([UserCache getUserXinXi]) {
    if (YES) {
        UILabel *promptingLabel = [UILabel new];
        promptingLabel.text = @"审核成功";
        promptingLabel.textColor = HEX_COLOR(0xA221FF);
        CGAffineTransform matrix =CGAffineTransformRotate(promptingLabel.transform,-M_PI/6); // CGAffineTransformMake(1, 0, tanf(5 * (CGFloat)M_PI / 320), 1, 0, 0);//设置反射。倾斜角度。
        promptingLabel.font = [ UIFont systemFontOfSize:WidthRatio(25)];
        promptingLabel.textAlignment = NSTextAlignmentCenter;
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowBlurRadius = 5.0;
        shadow.shadowColor = [UIColor blackColor];
        [reviewResultsBgImageView addSubview:promptingLabel];
        [promptingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(reviewResultsBgImageView.mas_right).offset(-WidthRatio(15));
            make.bottom.mas_equalTo(reviewResultsBgImageView.mas_bottom).offset(-HeightRatio(30));
            make.width.mas_equalTo(WidthRatio(120));
            make.height.mas_equalTo(20);
        }];
        promptingLabel.transform = matrix;
        MMViewBorderRadius(promptingLabel, 1, 1, HEX_COLOR(0xA221FF));
    }
   
    
    UIButton *button = [UIButton new];
    button.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(30)];
    [button setTitle:@"提交成功，请等待管理员审核" forState:(UIControlStateNormal)];
    [button setTitleColor:HEX_COLOR(0x353535) forState:(UIControlStateNormal)];
    [button setImage:MMGetImage(@"zhuyi") forState:(UIControlStateNormal)];
    [button setImagePosition:ImagePositionTypeLeft spacing:ScreenScale(20)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(HeightRatio(42));
        make.width.mas_equalTo(WidthRatio(480));
        make.top.mas_equalTo(reviewResultsBgImageView.mas_bottom).offset(HeightRatio(138));
    }];
    
    UILabel *label = [UILabel new];
    label.numberOfLines = 2;
    label.textColor = HEX_COLOR(0x949494);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:WidthRatio(22)];
    label.text = @"预计在三个工作日内审核完毕，请\n随时关注审核结果";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(button.mas_bottom).offset(HeightRatio(42));
        make.height.mas_greaterThanOrEqualTo(1);
        make.width.mas_greaterThanOrEqualTo(1);
    }];
//     if ([UserCache getUserXinXi]) {
    if (YES) {// !!!: 审核成功隐藏提交提示
        [button setHidden:YES];
        [label setHidden:YES];
    }
    
    UIButton *btn = [UIButton new];
    btn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
    [btn setTitle:@"汉富金融保障您的账户安全" forState:(UIControlStateNormal)];
    [btn setTitleColor:HEX_COLOR(0x969696) forState:(UIControlStateNormal)];
    [btn setImage:MMGetImage(@"anquan") forState:(UIControlStateNormal)];
    [btn setImagePosition:ImagePositionTypeLeft spacing:ScreenScale(20)];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-HeightRatio(72));
        make.height.mas_equalTo(HeightRatio(22));
    }];
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
