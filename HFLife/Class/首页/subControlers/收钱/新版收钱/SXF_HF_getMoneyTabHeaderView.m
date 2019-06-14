
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
@end

@implementation SXF_HF_getMoneyTabHeaderView
{
    UIImage *logoImage;
}
- (void)awakeFromNib {
    [super awakeFromNib];

    self.userNameLb.text = [NSString stringWithFormat:@"%@(LV:%@)", [userInfoModel sharedUser].nickname , [userInfoModel sharedUser].level_name];
    self.meddileTitleLb.text = [userInfoModel sharedUser].nickname;
    

    
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
