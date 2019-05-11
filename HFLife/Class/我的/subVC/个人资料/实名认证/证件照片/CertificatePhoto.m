//
//  CertificatePhoto.m
//  HFLife
//
//  Created by sxf on 2019/1/18.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "CertificatePhoto.h"
//#import "AVCaptureViewController.h"
//#import "JQAVCaptureViewController.h"

//#import "JYBDBankCardVC.h"
//#import "JYBDIDCardVC.h"

#import "Per_MethodsToDealWithManage.h"

#import "LYBmOcrManager.h"
@interface CertificatePhoto ()
{
    //身份证正面
    UIImageView *idCardPositiveImageView;
    UIImage *idCardPositiveImage;
    UIButton *idCardPositiveButton;
    
    //身份证反面
    UIImageView *idCardBackImageView;
    UIImage *idCardBackImage;
    UIButton *idCardBackButton;
    
    //签名照
    UIImageView *signatureImageView;
    UIImage *signatureImage;
    UIButton *signatureButton;
    
    UIButton *agreeBtn;
}
@property (nonatomic,strong)Per_MethodsToDealWithManage *manage;
@end

@implementation CertificatePhoto

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
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.customNavBar setHidden:NO];
    }];
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
    bgImageView.image = MMGetImage_x(@"audit_two");
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
    
    UIImageView *scanningBgImageView  = [UIImageView new];
    scanningBgImageView.image = MMGetImage(@"CertificatePhoto_beijing");
    [self.view addSubview:scanningBgImageView];
    [scanningBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(544));
        make.top.mas_equalTo(bgImageView.mas_bottom).offset(-HeightRatio(43));
    }];
    
    UIImageView *idCardPositivedemo = [UIImageView new];
    idCardPositivedemo.image = MMGetImage(@"zhengmian");
    [self.view addSubview:idCardPositivedemo];
    [idCardPositivedemo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scanningBgImageView.mas_top).offset(HeightRatio(50));
        make.left.mas_equalTo(scanningBgImageView.mas_left).offset(WidthRatio(20));
        make.width.mas_equalTo(WidthRatio(324));
        make.height.mas_equalTo(HeightRatio(202));
    }];
    
    idCardPositiveImageView =  [UIImageView new];
    idCardPositiveImageView.image = MMGetImage(@"renwu");
    if ([UserCache getSaveRealNamePositiveImage] != nil) {
        idCardPositiveImageView.image = [UserCache getSaveRealNamePositiveImage];
    }
    [self.view addSubview:idCardPositiveImageView];
    [idCardPositiveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scanningBgImageView.mas_top).offset(HeightRatio(50));
        make.left.mas_equalTo(idCardPositivedemo.mas_right).offset(WidthRatio(32));
        make.right.mas_equalTo(scanningBgImageView.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(202));
    }];
    MMViewBorderRadius(idCardBackImageView, WidthRatio(10), 1, HEX_COLOR(0xebebeb));
    
    idCardPositiveButton = [UIButton new];
    idCardPositiveButton.backgroundColor = [UIColor clearColor];
    [idCardPositiveButton addTarget:self action:@selector(idCardPositiveButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:idCardPositiveButton];
    [idCardPositiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scanningBgImageView.mas_top).offset(HeightRatio(50));
        make.left.mas_equalTo(idCardPositivedemo.mas_right).offset(WidthRatio(32));
        make.right.mas_equalTo(scanningBgImageView.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(202));
    }];
    
    
    UIImageView *idCardBackdemo = [UIImageView new];
    idCardBackdemo.image = MMGetImage(@"fanmian");
    [self.view addSubview:idCardBackdemo];
    [idCardBackdemo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(idCardPositivedemo.mas_bottom).offset(HeightRatio(26));
        make.left.mas_equalTo(scanningBgImageView.mas_left).offset(WidthRatio(20));
        make.width.mas_equalTo(WidthRatio(324));
        make.height.mas_equalTo(HeightRatio(202));
    }];
    
    idCardBackImageView =  [UIImageView new];
    idCardBackImageView.image = MMGetImage(@"guohui");
    if ([UserCache getSaveRealNameNegativeImage] != nil) {
       idCardBackImageView.image = [UserCache getSaveRealNameNegativeImage];
    }
    [self.view addSubview:idCardBackImageView];
    [idCardBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(idCardBackdemo.mas_top);
        make.left.mas_equalTo(idCardBackdemo.mas_right).offset(WidthRatio(32));
        make.right.mas_equalTo(scanningBgImageView.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(202));
    }];
    MMViewBorderRadius(idCardBackImageView, WidthRatio(10), 1, HEX_COLOR(0xebebeb));
    
    idCardBackButton = [UIButton new];
    idCardBackButton.backgroundColor = [UIColor clearColor];
    [idCardBackButton addTarget:self action:@selector(idCardBackButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:idCardBackButton];
    [idCardBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(idCardBackdemo.mas_top);
        make.left.mas_equalTo(idCardBackdemo.mas_right).offset(WidthRatio(32));
        make.right.mas_equalTo(scanningBgImageView.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(202));
    }];
    
    
    UILabel *label = [UILabel new];
    label.text = @"1、请按照示例上传证件照片";
    label.font = [UIFont systemFontOfSize:WidthRatio(26)];
    label.textColor = HEX_COLOR(0x969696);
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scanningBgImageView.mas_left);
        make.top.mas_equalTo(scanningBgImageView.mas_bottom).offset(HeightRatio(50));
        make.height.mas_equalTo(HeightRatio(26));
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    
    
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(WidthRatio(22), SCREEN_HEIGHT - HeightRatio(130), SCREEN_WIDTH-WidthRatio(22)-WidthRatio(22), HeightRatio(88))];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0,  SCREEN_WIDTH-WidthRatio(22)-WidthRatio(22), HeightRatio(88));
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.38),@(0.6),@(0.8),@(1.0)];//渐变点
    
    [gradientLayer setColors:@[(id)[HEX_COLOR(0x9f22ff) CGColor],(id)[HEX_COLOR(0x9323ff) CGColor],(id)HEX_COLOR(0x7f23ff).CGColor]];//渐变数组
    [button.layer addSublayer:gradientLayer];
    [button setTitle:@"确认上传" forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(31)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    MMViewBorderRadius(button, WidthRatio(10), 0, [UIColor clearColor]);
    
    
   	agreeBtn = [UIButton new];
    agreeBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
    [agreeBtn setTitleColor:HEX_COLOR(0xAAAAAA) forState:(UIControlStateNormal)];
    [agreeBtn setImagePosition:ImagePositionTypeLeft spacing:WidthRatio(22)];
    [agreeBtn addTarget:self action:@selector(agreeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [agreeBtn setTitle:@"我已阅读并接受" forState:(UIControlStateNormal)];
    [agreeBtn setImage:MMGetImage(@"gouxuan") forState:(UIControlStateNormal)];
    [agreeBtn setImage:MMGetImage(@"gouxuan1") forState:(UIControlStateSelected)];
    [self.view addSubview:agreeBtn];
    agreeBtn.sd_layout
    .leftEqualToView(button)
    .bottomSpaceToView(self.view, HeightRatio(182))
    .heightIs(HeightRatio(22)+5)
    .widthIs(WidthRatio(220));
    
        //
    UIButton *agreementBtn =  [UIButton new];
    agreementBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
    [agreementBtn addTarget:self action:@selector(agreementBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [agreementBtn setTitleColor:HEX_COLOR(0x9019ff) forState:(UIControlStateNormal)];
    [agreementBtn setTitle:@"《实名认证授权服务协议》" forState:(UIControlStateNormal)];
    [self.view addSubview:agreementBtn];
    agreementBtn.sd_layout
    .leftSpaceToView(agreeBtn,-WidthRatio(16))
    .bottomSpaceToView(self.view, HeightRatio(182))
    .heightIs(HeightRatio(22)+5)
    .widthIs(WidthRatio(270));
}
-(void)buttonClick:(UIButton *)sender{
    if (sender.selected) {
        return;
    }
   
    if (!idCardBackImage) {
        [WXZTipView showCenterWithText:@"请上传身份证国徽面" duration:3];
        return;
    }
    if (!idCardPositiveImage) {
        [WXZTipView showCenterWithText:@"请上传身份证人物面" duration:3];
        return;
    }
    if (!agreeBtn.selected) {
        [WXZTipView showCenterWithText:@"您的未同意《实名认证授权服务协议》暂不可上传" duration:3];
        return;
    }
    sender.selected = YES;
    [UserCache setSaveRealNameNegativeImage:idCardBackImage];
    [UserCache setSaveRealNamePositiveImage:idCardPositiveImage];
    [[WBPCreate sharedInstance] showWBProgress];
    [self.manage idCardPhotographVerify:@{@"img0":idCardBackImage,@"img1":idCardPositiveImage} requestEnd:^{
        [[WBPCreate sharedInstance] hideAnimated];
        sender.selected = NO;
    }];
}
#pragma mark ===身份证人物面
-(void)idCardPositiveButtonClick{
    NSLog(@"idCardPositiveButtonClick");
//    AVCaptureViewController *AVCaptureVC = [[AVCaptureViewController alloc] init];
//    [AVCaptureVC setPhotographCompleteCallBack:^(IDInfo *info) {
//        if (![NSString isNOTNull:info.name]&&![NSString isNOTNull:info.num]) {
//            self->idCardPositiveImageView.image = info.IDImage;
//            //身份证图片
//            self->idCardPositiveImage = info.IDImage;
//        }else{
//
//        }
//
//    }];
//
//    [self.navigationController pushViewController:AVCaptureVC animated:YES];
    
    
    [[LYBmOcrManager ocrShareManaer] presentAcrVCWithType:CardTypeIdCardFont complete:^(id result, UIImage *image) {
        
        
        if (![NSString isNOTNull:result[@"words_result"][@"公民身份号码"][@"words"]]) {
           
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *writeIDCard = [UserCache getSaveRealNameWriteIDCare];
                NSString *writeRealName = [UserCache getSaveRealNameWriteName];
                // !!!: 保存身份证信息验证第一步的输入信息
                if (![writeIDCard isEqualToString:result[@"words_result"][@"公民身份号码"][@"words"]]) {
                    return [WXZTipView showCenterWithText:@"身份证号码和输入号码不一致!" duration:1.5];
                }
                if (![writeRealName isEqualToString:result[@"words_result"][@"姓名"][@"words"]]) {
                    return [WXZTipView showCenterWithText:@"身份证姓名和输入姓名不一致!" duration:1.5];
                }
                
                self->idCardPositiveImageView.image = image;
                [WXZTipView showCenterWithText:@"识别成功"];

            });
            //身份证图片
            self->idCardPositiveImage = image;
        }else{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [WXZTipView showCenterWithText:@"请拍摄正确照片"];
            }];
            return ;
        }
        
    }];
    
//    JYBDIDCardVC *AVCaptureVC = [[JYBDIDCardVC alloc] init];
//
//    AVCaptureVC.finish = ^(JYBDCardIDInfo *info, UIImage *image)
//    {
//
//
//        if (![NSString isNOTNull:info.num]) {
//            NSString *writeIDCard = [UserCache getSaveRealNameWriteIDCare];
//            NSString *writeRealName = [UserCache getSaveRealNameWriteName];
//            // !!!: 保存身份证信息验证第一步的输入信息
//            if (![writeIDCard isEqualToString:info.num]) {
//                return [WXZTipView showCenterWithText:@"身份证号码和输入号码不一致!" duration:1.5];
//            }
//            if (![writeRealName isEqualToString:info.name]) {
//                return [WXZTipView showCenterWithText:@"身份证姓名和输入姓名不一致!" duration:1.5];
//            }
//
//            self->idCardPositiveImageView.image = image;
//                //身份证图片
//            self->idCardPositiveImage = image;
//        }else{
//            [WXZTipView showCenterWithText:@"请拍摄正确照片"];
//            return ;
//        }
//
//
//    };
//
//
//    [self.navigationController pushViewController:AVCaptureVC animated:YES];
}
#pragma mark ===身份证国徽面
-(void)idCardBackButtonClick{
    NSLog(@"idCardBackButtonClick");
    
    
    
    
    [[LYBmOcrManager ocrShareManaer] presentAcrVCWithType:CardTypeIdCardBack complete:^(id result, UIImage *image) {
        
        
            if (![NSString isNOTNull:result[@"words_result"][@"签发机关"][@"words"]]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self->idCardBackImageView.image = image;
                    [WXZTipView showCenterWithText:@"识别成功"];

                });
                self->idCardBackImage = image;
            }else{
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [WXZTipView showCenterWithText:@"请拍摄正确照片"];
                }];
                return ;
            }
       
    }];
    
//    JQAVCaptureViewController *AVCaptureVC = [[JQAVCaptureViewController alloc] init];
//    [AVCaptureVC setPhotographCompleteCallBack:^(IDInfo *info) {
//        NSLog(@"签发机关 = %@  有效期 = %@",info.issue,info.valid);
//        if (![NSString isNOTNull:info.issue]&&![NSString isNOTNull:info.valid]) {
//            self->idCardBackImageView.image = info.IDImage;
//            self->idCardBackImage = info.IDImage;
//        }else{
//
//        }
//    }];
//    [self.navigationController pushViewController:AVCaptureVC animated:YES];
//    JYBDIDCardVC *AVCaptureVC = [[JYBDIDCardVC alloc] init];
//    AVCaptureVC.finish = ^(JYBDCardIDInfo *info, UIImage *image)
//    {
//        if (![NSString isNOTNull:info.issue]) {
//            self->idCardBackImageView.image = image;
//            self->idCardBackImage = image;
//        }else{
//            [WXZTipView showCenterWithText:@"请拍摄正确照片"];
//            return ;
//        }
//
//    };
//    [self.navigationController pushViewController:AVCaptureVC animated:YES];
}


-(void)agreeBtnClick{
    agreeBtn.selected = !agreeBtn.selected;
}
-(void)agreementBtnClick{
    NSLog(@"协议");
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
