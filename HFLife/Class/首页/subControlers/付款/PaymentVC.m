//
//  PaymentVC.m
//  HFLife
//
//  Created by sxf on 2019/1/21.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "PaymentVC.h"
#import "SGQRCode/SGQRCode.h"
#import "RSAEncryptor.h"
#import "PaymentListVC.h"
#import "BarCodeView.h"
//#import "HP_ClosedPaySlowNetApi.h"
@interface PaymentVC (){
    /** 条形码*/
    UIImageView *barCodeImageView;
    /** 二维码*/
    UIImageView *qrCodeImageView;
    
    UIImage *barCodeImage;
}
@property (nonatomic, strong)NSTimer *circleTimer;
@end

@implementation PaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"付款码";
    [self initWithUI];
//    [self axcBaseRequestData];
    [self.circleTimer fire];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.circleTimer invalidate];
    self.circleTimer = nil;
}

-(void)axcBaseRequestData{
    /*
    HP_ClosedPaySlowNetApi *closed = [[HP_ClosedPaySlowNetApi alloc]initWithParameter:@{@"type":@"2"}];
    [closed startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_ClosedPaySlowNetApi *closedRequest = (HP_ClosedPaySlowNetApi *)request;
        if ([closedRequest getCodeStatus] == 1) {
            NSDictionary *data = [closedRequest getContent];
            if ([data isKindOfClass:[NSDictionary class]]) {
                NSString *code = data[@"show_code"];
                self->barCodeImage = [UIImage barcodeImageWithContent:[NSString judgeNullReturnString:code] codeImageSize:CGSizeMake(WidthRatio(492), HeightRatio(177)) red:0 green:0 blue:0];
                self->barCodeImageView.image = self->barCodeImage;
                self->qrCodeImageView.image = [SGQRCodeObtain generateQRCodeWithData:[NSString judgeNullReturnString:code] size:WidthRatio(322) color:[UIColor blackColor] backgroundColor:[UIColor whiteColor]];
            }else{
                [WXZTipView showCenterWithText:@"数据错误"];
            }
        }else{
            [WXZTipView showCenterWithText:[closedRequest getMsg]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [WXZTipView showCenterWithText:@"网络错误"];
    }];
     
     */
}
-(void)initWithUI{
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.image = MMGetImage(@"paymentBG");
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

    UIImageView *maskImageView = [UIImageView new];
    maskImageView.image = MMGetImage(@"maskBG");
//    maskImageView.backgroundColor = [UIColor yellowColor];
    maskImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:maskImageView];
    [maskImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(21));
//        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(21));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(HeightRatio(33)+self.navBarHeight);
//        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-HeightRatio(48));
        make.height.mas_equalTo(HeightRatio(1130));
        make.width.mas_equalTo(WidthRatio(709));
    }];
//    NSString * randomString = [NSString getRandomString];
//    NSString * encryption_randomString =  [RSAEncryptor encryptString:MMNSStringFormat(@"HanPay_Merchants:%@,UserID:%@",randomString,[UserCache getUserId]) publicKey:AMOUNTRSAPRIVATEKEY];
    barCodeImageView = [UIImageView new];
//    barCodeImageView.image = [UIImage barcodeImageWithContent:encryption_randomString codeImageSize:CGSizeMake(WidthRatio(492), HeightRatio(177)) red:0 green:0 blue:0];
//    barCodeImageView.image = [UIImage barcodeImageWithContent:@"http://www.hfgld.net" codeImageSize:CGSizeMake(WidthRatio(492), HeightRatio(177))];
    
    [self.view addSubview:barCodeImageView];
    [barCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(maskImageView.mas_top).offset(HeightRatio(142));
        make.width.mas_equalTo(WidthRatio(492));
        make.height.mas_equalTo(HeightRatio(177));
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
    // 允许用户交互
    barCodeImageView.userInteractionEnabled = YES	;
    [barCodeImageView addGestureRecognizer:tap];
    
    
    UILabel *barCodeLabel = [UILabel new];
    barCodeLabel.text = @"点击可查看付款码数字";
    barCodeLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    barCodeLabel.textColor = HEX_COLOR(0x999999);
    [self.view addSubview:barCodeLabel];
    barCodeLabel.hidden = YES;
    [barCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_greaterThanOrEqualTo(1);
        make.top.mas_equalTo(self->barCodeImageView.mas_bottom).offset(HeightRatio(33));
    }];
    
    qrCodeImageView = [UIImageView new];
//    qrCodeImageView.image = [SGQRCodeObtain generateQRCodeWithData:encryption_randomString size:WidthRatio(322) color:[UIColor blackColor] backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:qrCodeImageView];
    [qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(barCodeLabel.mas_bottom).offset(HeightRatio(92));
        make.width.height.mas_equalTo(WidthRatio(322));
    }];
    
    UITableViewCell *oneCell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"oneCell"];
    oneCell.imageView.image = MMGetImage(@"home_payment_icon");
    oneCell.textLabel.text = @"余额支付";
    oneCell.textLabel.font =[UIFont systemFontOfSize:WidthRatio(28)];
    oneCell.detailTextLabel.text = @"优先使用此付款方式";
    oneCell.detailTextLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    oneCell.detailTextLabel.textColor = HEX_COLOR(0x666666);
    oneCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.view addSubview:oneCell];
    [oneCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(50));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(50));
        make.height.mas_equalTo(HeightRatio(123));
        make.top.mas_equalTo(self->qrCodeImageView.mas_bottom).offset(HeightRatio(85));
    }];
//    oneCell.hidden = YES;
    
    UIButton *one_btn = [UIButton new];
    one_btn.backgroundColor = [UIColor clearColor];
    [one_btn addTarget:self action:@selector(one_btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:one_btn];
    [one_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(50));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(50));
        make.height.mas_equalTo(HeightRatio(123));
        make.top.mas_equalTo(self->qrCodeImageView.mas_bottom).offset(HeightRatio(85));
    }];
//    one_btn.hidden = YES;
    
    UILabel *lin = [UILabel new];
    lin.backgroundColor = HEX_COLOR(0xcccccc);
    [self.view addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(oneCell.mas_bottom);
        make.left.right.mas_equalTo(oneCell);
        make.height.mas_equalTo(HeightRatio(1));
    }];
    
    UITableViewCell *twoCell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"twoCell"];
    twoCell.imageView.image = MMGetImage(@"jilv");
    twoCell.textLabel.text = @"付款记录";
    twoCell.textLabel.font =[UIFont systemFontOfSize:WidthRatio(28)];
    twoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.view addSubview:twoCell];
    [twoCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(50));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(50));
        make.height.mas_equalTo(HeightRatio(123));
        make.top.mas_equalTo(lin.mas_bottom);
    }];
    twoCell.hidden = YES;
    UIButton *two_btn = [UIButton new];
    two_btn.backgroundColor = [UIColor clearColor];
    [two_btn addTarget:self action:@selector(two_btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:two_btn];
    [two_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(50));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(50));
        make.height.mas_equalTo(HeightRatio(123));
        make.top.mas_equalTo(lin.mas_bottom);
    }];
    
//    qrCodeImageView.hidden = YES;
    two_btn.hidden = YES;
    
}
#pragma mark 点击手势
-(void)doTap:(UITapGestureRecognizer *)sender{
    BarCodeView *codeview =[[BarCodeView alloc]initImage:barCodeImage withCodeStr:@"ceshi数据"];
    [self.view addSubview:codeview];
}
-(void)one_btnClick{
    NSLog(@"付款方式");
    
}
-(void)two_btnClick{
    NSLog(@"记录");
    PaymentListVC *list = [[PaymentListVC alloc]init];
    [self.navigationController pushViewController:list animated:YES];
}
- (NSTimer *)circleTimer{
    
    if (!_circleTimer) {
        _circleTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(circleLoadData) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_circleTimer forMode:NSRunLoopCommonModes];
    }
    return _circleTimer;
}
//循环加载接口
- (void) circleLoadData{
    [self axcBaseRequestData];
}

@end
