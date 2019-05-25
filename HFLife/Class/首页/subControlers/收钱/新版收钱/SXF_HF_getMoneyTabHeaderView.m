
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

@end

@implementation SXF_HF_getMoneyTabHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];

    
    
    

    
}

- (IBAction)clickBtn:(UIButton *)sender {
//    if (sender.tag == 1) {
//        //保存图片
//        [self loadImageFinished:self.qCodeImageV.image];
//        
//        return;
//    }
    
    !self.clickHeaderBtn ? :  self.clickHeaderBtn(sender.tag);
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
    self.qCodeImageV.image = [SGQRCodeObtain generateQRCodeWithData:[NSString stringWithFormat:@"%@",data] size:self.qCodeImageV.bounds.size.width logoImage:[UIImage imageNamed:@"logo"] ratio:0.3];
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
