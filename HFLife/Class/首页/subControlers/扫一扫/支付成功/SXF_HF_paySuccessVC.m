
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
@property (weak, nonatomic) IBOutlet UIView *payFailerView;
@property (weak, nonatomic) IBOutlet UIImageView *tuiImageV;

@end

@implementation SXF_HF_paySuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    
//    self.payStatus = NO;
    self.payNameLb.text = self.payName;
    self.payMoneyLb.text = self.payMoney;
    self.payMoneyLb2.text = [NSString stringWithFormat:@"￥%@", self.payMoney];
    self.headerImageV.image = self.payStatus ? self.payImage : MY_IMAHE(@"失败");
    self.payStatusLb.text = self.payStatus ? @"支付成功" : @"支付失败";
    self.payFailerView.hidden = self.payStatus ? YES : NO;
    self.payTypeLb.text = self.payType;
    
    [self.tuiImageV sd_setImageWithURL:MY_URL_IMG(self.imageUrlStr)];
    
}

- (IBAction)tapTuiImageView:(UITapGestureRecognizer *)sender {
    if (self.webUrlStr) {
        SXF_HF_WKWebViewVC *webVC = [SXF_HF_WKWebViewVC new];
        webVC.urlString = self.webUrlStr;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}









- (void)setupNavBar{
    [super setupNavBar];
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self.customNavBar wr_setRightButtonWithTitle:@"完成" titleColor:colorCA1400];
    WEAK(weakSelf);
    [self.customNavBar setOnClickRightButton:^{
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
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
