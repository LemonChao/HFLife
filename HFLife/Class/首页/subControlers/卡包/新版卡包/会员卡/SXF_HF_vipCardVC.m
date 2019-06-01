
//
//  SXF_HF_vipCardVC.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_vipCardVC.h"
#import "SXF_HF_vipCardView.h"
#import "SXF_HF_vipShopVC.h"
#import "SXF_HF_ServiceAuthorizationVC.h"
@interface SXF_HF_vipCardVC ()
@property (nonatomic, strong)SXF_HF_vipCardView *tableV;
@end

@implementation SXF_HF_vipCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"会员卡";
    [self setUpUI];
}

- (void)setUpUI{
    WEAK(weakSelf);
    
    [self.customNavBar wr_setBottomLineHidden:NO];
    self.tableV = [[SXF_HF_vipCardView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];
    
    [self.view addSubview:self.tableV];
    
    self.tableV.selectRow = ^(NSIndexPath * _Nonnull indexP) {
        BaseViewController *vc;
        if (indexP.row == 0) {
            //附近门店
            vc = [SXF_HF_vipShopVC new];
        }else if (indexP.row == 1){
            //会员卡详情
            SXF_HF_WKWebViewVC *webVC = [SXF_HF_WKWebViewVC new];
            webVC.urlString = SXF_WEB_URLl_Str(membershipInformation);
            vc = webVC;
        }else{
            //公众号
            vc = [SXF_HF_ServiceAuthorizationVC new];
        }
        
        
        if ([vc isKindOfClass:[UIViewController class]]) {
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    
}

@end
