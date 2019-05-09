//
//  errorAlertViewViewController.m
//  DoLifeApp
//
//  Created by sxf_pro on 2018/7/13.
//  Copyright © 2018年 张志超. All rights reserved.
//

#import "errorAlertViewViewController.h"

@interface errorAlertViewViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *alertImageView;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@end

@implementation errorAlertViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.alertImageView.userInteractionEnabled = YES;
}


- (instancetype)init{
    if (self = [super init]) {
        
    }
    
    return self;
}



- (void)setMsg:(NSString *)msg{
    _msg = msg;
    self.msgLabel.text = msg;
}


- (void)setImageType:(alert_type)imageType{
    _imageType = imageType;
    switch (imageType) {
        case TYPE_EMPTY:
            self.alertImageView.image = [UIImage imageNamed:@"sxf_空"];
            break;
        case TYPE_ADRESS:
            self.alertImageView.image = [UIImage imageNamed:@"sxf_地址"];
            break;
        case TYPE_NONETWORK:
            self.alertImageView.image = [UIImage imageNamed:@"sxf_无网络"];
            break;
        case TYPE_NOLIST:
            self.alertImageView.image = [UIImage imageNamed:@"sxf_无列表"];
            break;
        case TYPE_NOSEARCH:
            self.alertImageView.image = [UIImage imageNamed:@"sxf_无网络"];
            break;
        case TYPE_NOCOMMENT:
            self.alertImageView.image = [UIImage imageNamed:@"sxf_暂无评论"];
            break;
        default:
            break;
    }
}





- (IBAction)tapAlertImage:(UITapGestureRecognizer *)sender {
    !self.callBack ? : self.callBack();
}




@end
