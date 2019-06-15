
//
//  SXF_HF_getMoneyTabHeaderView.m
//  HFLife
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_getMoneyTabHeaderView.h"

@interface SXF_HF_getMoneyTabHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLb;
@property (weak, nonatomic) IBOutlet UILabel *meddileTitleLb;

@property (weak, nonatomic) IBOutlet UIImageView *qCodeImageV;
//设置金额
@property (weak, nonatomic) IBOutlet UILabel *setMoneyLb;
@property (weak, nonatomic) IBOutlet UIButton *resetMoneyBtn;
@property (nonatomic, assign)BOOL resetBtnType;



//升级后状态
@property (weak, nonatomic) IBOutlet UIView *topHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *shopImageV;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLb;
@property (weak, nonatomic) IBOutlet UIImageView *rightIncoder;


@end

@implementation SXF_HF_getMoneyTabHeaderView
{
    UIImage *logoImage;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self changeHeaderStatus];
}


//改变头部状态
- (void) changeHeaderStatus{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTopHeader:)];
    [self.topHeaderView addGestureRecognizer:tap];
    if ([[userInfoModel sharedUser].payment_code integerValue]) {
        //已领收款码 显示店铺信息
        self.userNameLb.hidden = YES;
        self.shopImageV.hidden = NO;
        self.shopNameLb.hidden = NO;
        self.rightIncoder.hidden = NO;
        self.shopNameLb.text = [userInfoModel sharedUser].qrcode_shop_name;
        self.topHeaderView.userInteractionEnabled = YES;
    }else{
        self.userNameLb.hidden = NO;
        self.shopImageV.hidden = YES;
        self.shopNameLb.hidden = YES;
        self.rightIncoder.hidden = YES;
        self.userNameLb.text = [NSString stringWithFormat:@"%@(LV:%@)", [userInfoModel sharedUser].nickname , [userInfoModel sharedUser].level_name];
        self.topHeaderView.userInteractionEnabled = NO;
    }
    self.meddileTitleLb.text = [userInfoModel sharedUser].nickname;
}


//点击头部按钮
- (void)tapTopHeader:(UITapGestureRecognizer *)tap{
    !self.clickHeaderBtn ? :  self.clickHeaderBtn(-1, NO);
}

- (void)setMoney:(NSString *)money{
    _money = money;
    if ([_money floatValue] > 0) {
        self.setMoneyLb.text = [NSString stringWithFormat:@"￥%@", money];
        [self.resetMoneyBtn setTitle:@"清除金额" forState:UIControlStateNormal];
        self.resetBtnType = YES;
    }else{
        self.setMoneyLb.text = @"";
        [self.resetMoneyBtn setTitle:@"设置金额" forState:UIControlStateNormal];
        self.resetBtnType = NO;
    }
}
- (IBAction)clickBtn:(UIButton *)sender {
//    if (sender.tag == 1) {
//        //保存图片
//        [self loadImageFinished:self.qCodeImageV.image];
//        
//        return;
//    }
    
    !self.clickHeaderBtn ? :  self.clickHeaderBtn(sender.tag, self.resetBtnType);
}
#pragma mark 保存图片
- (void)loadImageFinished:(UIImage *)image{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SXF_HF_getMoneyTabHeaderView class]) owner:nil options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}
- (void)setDataForView:(id)data{
    self.qCodeImageV.image = [SGQRCodeObtain generateQRCodeWithData:[NSString stringWithFormat:@"%@",data] size:self.qCodeImageV.bounds.size.width logoImage:[userInfoModel sharedUser].userHeaderImage ratio:0.25];
    
    //判断是否已升级二维码 改变状态
    [self changeHeaderStatus];
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
@end
