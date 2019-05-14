//
//  ZHB_HP_PassportVC.m
//  HanPay
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "ZHB_HP_PassportVC.h"
#import "Per_MethodsToDealWithManage.h"
#import "HXPhotoPicker.h"
@interface ZHB_HP_PassportVC ()<HXAlbumListViewControllerDelegate>
{
        //身份证正面
    UIImageView *idCardPositiveImageView;
    UIImage *idCardPositiveImage;
    UIButton *idCardPositiveButton;
    
        //签名照
    UIImageView *signatureImageView;
    UIImage *signatureImage;
    UIButton *signatureButton;
    
    UIButton *agreeBtn;
}
@property (strong, nonatomic) HXPhotoManager *photo_manager;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;
@property (nonatomic,strong)Per_MethodsToDealWithManage *manage;
@end

@implementation ZHB_HP_PassportVC

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
        make.height.mas_equalTo(HeightRatio(701));
        make.top.mas_equalTo(bgImageView.mas_bottom).offset(-HeightRatio(43));
    }];
    
    UIImageView *idCardPositivedemo = [UIImageView new];
    
    idCardPositivedemo.image = MMGetImage([self.type isEqualToString:@"1"]?@"icon_book_officer":@"icon_book");
    [self.view addSubview:idCardPositivedemo];
    [idCardPositivedemo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scanningBgImageView.mas_top).offset(HeightRatio(33));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(WidthRatio(468));
        make.height.mas_equalTo(HeightRatio(320));
    }];
    
    idCardPositiveImageView =  [UIImageView new];
//    idCardPositiveImageView.image = MMGetImage(@"renwu");
    if ([UserCache getSaveRealNamePositiveImage] != nil) {
//        idCardPositiveImageView.image = [UserCache getSaveRealNamePositiveImage];
    }
//    idCardPositiveImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:idCardPositiveImageView];
    [idCardPositiveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(idCardPositivedemo.mas_bottom).offset(HeightRatio(29));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(WidthRatio(468));
        make.height.mas_equalTo(HeightRatio(289));
    }];
    MMViewBorderRadius(idCardPositiveImageView, WidthRatio(10), 1, HEX_COLOR(0xebebeb));
//
    idCardPositiveButton = [UIButton new];
    idCardPositiveButton.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    idCardPositiveButton.backgroundColor = [UIColor clearColor];
    [idCardPositiveButton setImage:MMGetImage(@"icon_xiangji") forState:(UIControlStateNormal)];
    [idCardPositiveButton setTitle:[self.type isEqualToString:@"1"]?@"军官证内容":@"护照内容页" forState:(UIControlStateNormal)];
    [idCardPositiveButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [idCardPositiveButton addTarget:self action:@selector(idCardPositiveButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [idCardPositiveButton setImagePosition:ImagePositionTypeTop spacing:ScreenScale(23)];
    [self.view addSubview:idCardPositiveButton];
    [idCardPositiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self->idCardPositiveImageView);
        make.top.mas_equalTo(idCardPositivedemo.mas_bottom).offset(HeightRatio(29));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(WidthRatio(440));
        make.height.mas_equalTo(HeightRatio(240));
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
//    [agreeBtn setImagePositionWithType:ImagePositionTypeLeft spacing:WidthRatio(22) leftSpacing:0];
    [agreeBtn setImagePosition:ImagePositionTypeLeft spacing:ScreenScale(22)];
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
    
    if (!idCardPositiveImage) {
        [WXZTipView showCenterWithText:[self.type isEqualToString:@"1"]?@"请上传军官证内容":@"请上传护照内容页" duration:3];
        return;
    }
    if (!agreeBtn.selected) {
        [WXZTipView showCenterWithText:@"您未同意《实名认证授权服务协议》暂不可上传" duration:3];
        return;
    }
    sender.selected = YES;

    [[WBPCreate sharedInstance] showWBProgress];
    [self.manage idCardPhotographVerify:@{@"img0":idCardPositiveImage} requestEnd:^{
        [[WBPCreate sharedInstance] hideAnimated];
        sender.selected = NO;
    }];
}
#pragma mark ===身份证人物面
-(void)idCardPositiveButtonClick{
    NSLog(@"idCardPositiveButtonClick");
    
    [self hx_presentAlbumListViewControllerWithManager:self.photo_manager delegate:self];
}
#pragma mark ===身份证国徽面
-(void)idCardBackButtonClick{
    NSLog(@"idCardBackButtonClick");
    
    
}


-(void)agreeBtnClick{
    agreeBtn.selected = !agreeBtn.selected;
}
-(void)agreementBtnClick{
    NSLog(@"协议");
}
#pragma mark HXPhotoManager代理
- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original {
    if (photoList.count > 0) {
        HXPhotoModel *model = photoList.firstObject;
        [idCardPositiveButton setImage:MMGetImage(@"") forState:(UIControlStateNormal)];
        [idCardPositiveButton setTitle:@"" forState:(UIControlStateNormal)];
        idCardPositiveImageView.image = model.previewPhoto;
        idCardPositiveImage = model.previewPhoto;
        NSSLog(@"%lu张图片",(unsigned long)photoList.count);
    }else if (videoList.count > 0) {
        
        [self.toolManager getSelectedImageList:allList success:^(NSArray<UIImage *> *imageList) {
            [self->idCardPositiveButton setImage:MMGetImage(@"") forState:(UIControlStateNormal)];
            [self->idCardPositiveButton setTitle:@"" forState:(UIControlStateNormal)];
            self->idCardPositiveImageView.image = imageList.firstObject;
            self->idCardPositiveImage = imageList.firstObject;
        } failed:^{
            
        }];
        
    }
}
#pragma mark 懒加载
-(Per_MethodsToDealWithManage *)manage{
    if (!_manage) {
        _manage = [Per_MethodsToDealWithManage sharedInstance];
    }
    _manage.superVC = self;
    return _manage;
}
- (HXPhotoManager *)photo_manager {
    if (!_photo_manager) {
        _photo_manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _photo_manager.configuration.singleSelected = YES;
        _photo_manager.configuration.saveSystemAblum = YES;
        _photo_manager.configuration.albumListTableView = ^(UITableView *tableView) {
            
        };
    }
    return _photo_manager;
}

- (HXDatePhotoToolManager *)toolManager {
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}

@end
