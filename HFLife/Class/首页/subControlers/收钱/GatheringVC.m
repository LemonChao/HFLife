//
//  GatheringVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/22.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "GatheringVC.h"
#import <SGQRCode/SGQRCode.h>
#import "BaseNavigationController.h"
#import "SetAmountVC.h"
#import "RSAEncryptor.h"
//#import "HP_ClosedPaySlowNetApi.h"
@interface GatheringVC ()<SetAmountDelegate>
{
    /** 二维码*/
    UIImageView *qrCodeImageView;
    
    UIImageView *maskImageView;
    
    UILabel *amountLabel;
    
    UIButton *setAmountBtn;
}
@end

@implementation GatheringVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"收款码";
    [self axcBaseRequestData];
    [self initWithUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)initWithUI{
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.image = MMGetImage(@"paymentBG");
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    maskImageView = [UIImageView new];
    maskImageView.image = MMGetImage(@"gatheringBG");
    [self.view addSubview:maskImageView];
    [maskImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(21));
//        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(21));
        make.top.mas_equalTo(self.view.mas_top).offset(HeightRatio(50)+self.navBarHeight);
//        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-HeightRatio(184));
        make.width.mas_equalTo(WidthRatio(709));
        make.height.mas_equalTo(HeightRatio(979));
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *explainLabel = [UILabel new];
    explainLabel.text = @"扫一扫 向我付款";
    explainLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    explainLabel.textColor = HEX_COLOR(0x000000);
    [self.view addSubview:explainLabel];
    [explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_greaterThanOrEqualTo(1);
        make.top.mas_equalTo(self->maskImageView.mas_top).offset(HeightRatio(182));
    }];
    
    qrCodeImageView = [UIImageView new];
    
//    qrCodeImageView.image = [SGQRCodeObtain generateQRCodeWithData:[RSAEncryptor encryptString:MMNSStringFormat(@"HanPay:0,UserID:%@",[UserCache getUserId]) publicKey:AMOUNTRSAPRIVATEKEY] size:WidthRatio(387) color:[UIColor blackColor] backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:qrCodeImageView];
    [qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(explainLabel.mas_bottom).offset(HeightRatio(55));
        make.width.height.mas_equalTo(WidthRatio(387));
    }];
    
    amountLabel = [UILabel new];
//    amountLabel.text = MMNSStringFormat(@"¥%@",amount);
    amountLabel.textAlignment = NSTextAlignmentCenter;
    amountLabel.font = [UIFont systemFontOfSize:WidthRatio(40)];
    [self.view addSubview:amountLabel];
    [amountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self->qrCodeImageView.mas_bottom);
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_equalTo(HeightRatio(90));
    }];
    amountLabel.hidden = YES;
    
    setAmountBtn = [UIButton new];
    setAmountBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [setAmountBtn setTitle:@"设置金额" forState:(UIControlStateNormal)];
    [setAmountBtn setTitle:@"清除金额" forState:(UIControlStateSelected)];
    [setAmountBtn setTitleColor:HEX_COLOR(0x7B44F8) forState:(UIControlStateNormal)];
    [setAmountBtn addTarget:self action:@selector(setAmountBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:setAmountBtn];
    [setAmountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->qrCodeImageView.mas_left);
        make.top.mas_equalTo(self->qrCodeImageView.mas_bottom).offset(HeightRatio(90));
        make.width.mas_equalTo(WidthRatio(387)/2);
        make.height.mas_equalTo(HeightRatio(25));
    }];
    
    
#warning 隐藏设置金额
    setAmountBtn.hidden = YES;
    
    
    
    
    UILabel *lin = [UILabel new];
    lin.backgroundColor = HEX_COLOR(0xCCCCCC);
    [self.view addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self->setAmountBtn.mas_centerY);
        make.height.mas_equalTo(HeightRatio(19));
        make.width.mas_equalTo(WidthRatio(1));
    }];
    
    UIButton *savePic = [UIButton new];
    savePic.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [savePic setTitle:@"保存图片" forState:(UIControlStateNormal)];
    [savePic setTitleColor:HEX_COLOR(0x7B44F8) forState:(UIControlStateNormal)];
    [savePic addTarget:self action:@selector(savePicClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:savePic];
    [savePic mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(lin.mas_right);
        make.centerY.mas_equalTo(self->setAmountBtn.mas_centerY);
        make.width.mas_equalTo(WidthRatio(387)/2);
        make.height.mas_equalTo(HeightRatio(25));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    UILabel *horizontalLin = [UILabel new];
    horizontalLin.backgroundColor = HEX_COLOR(0xCCCCCC);
    [self.view addSubview:horizontalLin];
    [horizontalLin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(53));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(53));
        make.top.mas_equalTo(savePic.mas_bottom).offset(HeightRatio(79));
        make.height.mas_equalTo(HeightRatio(1));
    }];
    
    UITableViewCell *twoCell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"twoCell"];
    twoCell.imageView.image = MMGetImage(@"jilv");
    twoCell.textLabel.text = @"收款记录";
    twoCell.textLabel.font =[UIFont systemFontOfSize:WidthRatio(28)];
    twoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.view addSubview:twoCell];
    [twoCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(50));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(50));
        make.height.mas_equalTo(HeightRatio(123));
        make.top.mas_equalTo(horizontalLin.mas_bottom);
    }];
    twoCell.hidden = NO;
    UIButton *two_btn = [UIButton new];
    two_btn.backgroundColor = [UIColor clearColor];
    [two_btn addTarget:self action:@selector(two_btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:two_btn];
    [two_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(50));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(50));
        make.height.mas_equalTo(HeightRatio(123));
        make.top.mas_equalTo(horizontalLin.mas_bottom);
    }];
    two_btn.hidden = NO;
}
-(void)axcBaseRequestData{
    /*
    HP_ClosedPaySlowNetApi *closed = [[HP_ClosedPaySlowNetApi alloc]initWithParameter:@{@"type":@"1"}];
    [closed startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_ClosedPaySlowNetApi *closedRequest = (HP_ClosedPaySlowNetApi *)request;
        if ([closedRequest getCodeStatus] == 1) {
            NSDictionary *data = [closedRequest getContent];
            if ([data isKindOfClass:[NSDictionary class]]) {
                NSString *code = data[@"show_code"];
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
-(void)two_btnClick{
    NSLog(@"收款");
    Class vcClass = NSClassFromString(@"receiptRecordListVC");
    [self.navigationController pushViewController:[[vcClass alloc] init] animated:YES];
}
-(void)setAmountBtnClick{
    NSLog(@"设置金额");
    if (!setAmountBtn.selected) {
        SetAmountVC *amount = [[SetAmountVC alloc]init];
        amount.amountDelegate = self;
        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:amount];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        amountLabel.text = @"";
        amountLabel.hidden = YES;
        setAmountBtn.selected = NO;
    }
    
}
-(void)savePicClick{
    UIImage *im = [self addImage:[UIImage imageNamed:@"gatheringBG"] withImage:qrCodeImageView.image];
    [self loadImageFinished:[self addImage:MMGetImage(@"paymentBG") withImage:im]];
}
#pragma mark 保存图片
- (void)loadImageFinished:(UIImage *)image{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    if (error != NULL)
    {
        [WXZTipView showCenterWithText:@"图片保存失败"];
    }
    else  // No errors
    {
        [WXZTipView showCenterWithText:@"图片保存成功"];
    }
}
#pragma mark 代理
-(void)SetAmountNumber:(NSString *)amount{
    amountLabel.text = MMNSStringFormat(@"¥%@",amount);
    amountLabel.hidden = NO;
    setAmountBtn.selected = YES;
    qrCodeImageView.image =  [SGQRCodeObtain generateQRCodeWithData:[RSAEncryptor encryptString:MMNSStringFormat(@"HanPay:%@,UserID:%@",amount,[UserCache getUserId]) publicKey:AMOUNTRSAPRIVATEKEY] size:WidthRatio(387) color:[UIColor blackColor] backgroundColor:[UIColor whiteColor]];
}
- (UIImage *)addImage:(UIImage *)image1 withImage:(UIImage *)image2 {
    
    UIGraphicsBeginImageContext(image1.size);
    
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    [image2 drawInRect:CGRectMake((image1.size.width - image2.size.width)/2,(image1.size.height - image2.size.height)/2, image2.size.width, image2.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}
- (UIImage *)createShareImage:(UIImage *)img{
    
    UIImage *image = img;
    
    CGSize size=CGSizeMake(image.size.width, image.size.height);//画布大小
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    [image drawAtPoint:CGPointMake(0, 0)];
    
        //获得一个位图图形上下文
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    CGContextDrawPath(context, kCGPathStroke);
    //画 打败了多少用户
//    [str drawAtPoint:CGPointMake(30, image.size.height*0.65) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldMT" size:30],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
        //画自己想画的内容。。。。。
    
        //返回绘制的新图形
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
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
