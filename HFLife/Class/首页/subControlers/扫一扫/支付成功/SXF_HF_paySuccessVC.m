
//
//  SXF_HF_paySuccessVC.m
//  HFLife
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_paySuccessVC.h"

@interface SXF_HF_paySuccessVC ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageV;
@property (weak, nonatomic) IBOutlet UILabel *payTypeLb;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLb;
@property (weak, nonatomic) IBOutlet UILabel *payNameLb;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLb2;
@property (weak, nonatomic) IBOutlet UILabel *payStatusLb;

@end

@implementation SXF_HF_paySuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    
    
    self.payNameLb.text = self.payName;
    self.payMoneyLb.text = self.payMoney;
    self.payMoneyLb2.text = [NSString stringWithFormat:@"￥%@", self.payMoney];
    self.headerImageV.image = self.payImage;
    self.payStatusLb.text = self.payStatus ? @"支付成功" : @"支付失败";
    self.payTypeLb.text = self.payType;
    
    
}










- (void)setupNavBar{
    [super setupNavBar];
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar wr_setRightButtonWithTitle:@"完成" titleColor:colorCA1400];
    WEAK(weakSelf);
    [self.customNavBar setOnClickRightButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar wr_setLeftButtonWithNormal:image(@"") highlighted:image(@"")];
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
