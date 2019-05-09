//
//  alertView.m
//  缺省页test
//
//  Created by sxf_pro on 2018/7/13.
//  Copyright © 2018年 sxf_pro. All rights reserved.
//

#import "alertView.h"

@interface alertView()
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property (weak, nonatomic) IBOutlet UIImageView *alertImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageVcCenterYConstrans;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *refreshBgView;

@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;


@end



@implementation alertView


- (void)awakeFromNib{
    [super awakeFromNib];
    self.msgLabel.textColor = HEX_COLOR(0x666666);
    self.subTitleLabel.hidden = YES;
    self.subTitleLabel.textColor = [UIColor blackColor];
    self.msgLabel.font = FONT(11);
    self.subTitleLabel.font = FONT(17);
    
    
    //设置渐变色
    [self.refreshBgView changeBgViewWith:@[[UIColor colorWithHexString:@"#17CC85"], [UIColor colorWithHexString:@"#1ABC9C"]]];
    self.refreshBgView.layer.cornerRadius = self.refreshBgView.frame.size.height * 0.5;
    self.refreshBgView.clipsToBounds = YES;
    
    self.refreshBgView.hidden = YES;
    self.refreshBtn.hidden = YES;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([alertView class]) owner:self options:nil].firstObject;
        self.frame = frame;
        self.alertImageView.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setMsg:(NSString *)msg{
    _msg = msg;
    self.msgLabel.text = msg;
}

- (void)setImageCenterY:(CGFloat)imageCenterY{
    _imageCenterY = imageCenterY;
    //设置中心点 Y
    self.imageVcCenterYConstrans.constant = imageCenterY - 50;
}


- (void)setViewImageType:(alertView_type)viewImageType{
    _viewImageType = viewImageType;
    switch (viewImageType) {
        case IMAGETYPE_EMPTY:
            self.alertImageView.image = [UIImage imageNamed:@"sxf_空"];
            break;
        case IMAGETYPE_ADRESS:
            self.alertImageView.image = [UIImage imageNamed:@"sxf_地址"];
            break;
        case IMAGETYPE_NONETWORK:
            self.alertImageView.image = [UIImage imageNamed:@"sxf_无网络"];
            
            self.subTitleLabel.hidden = NO;
            
            self.msgLabel.text = @"您的网络开小差啦";
            self.msgLabel.font = FONT(17);
            
            self.subTitleLabel.textColor = HEX_COLOR(0x666666);
            self.subTitleLabel.font = FONT(11);
            self.subTitleLabel.text = @"检查您的网络设置，再刷新试试看吧~";
            
            self.refreshBgView.hidden = NO;
            self.refreshBtn.hidden = NO;
            
            
            
            break;
        case IMAGETYPE_NOLIST:
            self.alertImageView.image = [UIImage imageNamed:@"sxf_无列表"];
            break;
        case IMAGETYPE_NOSEARCH:
            self.alertImageView.image = [UIImage imageNamed:@"zixuanwu"];
            break;
        case IMAGETYPE_NOCOMMENT:
            self.alertImageView.image = [UIImage imageNamed:@"sxf_暂无收藏"];
            break;
        case IMAGETYPE_NOCOLLECTION:
            self.alertImageView.image = [UIImage imageNamed:@"sxf_暂无收藏"];
            break;
        case IMAGETYPE_HOMEPAGELIST:
            self.alertImageView.image = [UIImage imageNamed:@"个人主页-视频为空"];
            break;
            case IMAGETYPE_NOIMAGE:
            self.alertImageView.image = [UIImage imageNamed:@""];
            break;
        default:
            break;
    }

}

- (IBAction)refreshBtn:(UIButton *)sender {
    !self.callBack ? : self.callBack();
}

- (IBAction)tabImage:(UITapGestureRecognizer *)sender {
    !self.callBack ? : self.callBack();
}



@end
