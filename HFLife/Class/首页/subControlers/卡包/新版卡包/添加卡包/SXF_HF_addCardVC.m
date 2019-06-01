
//
//  SXF_HF_addCardVC.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_addCardVC.h"
#import "SXF_HF_addCardView.h"
#import "SXF_HF_moreVipCardVC.h"
#import "SXF_HF_cardDetaileVC.h"
@interface SXF_HF_addCardVC ()
@property (nonatomic, strong)SXF_HF_addCardView *tableV;
@end

@implementation SXF_HF_addCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"添加会员卡";
    
    
    [self setUpUI];
}


- (void)setUpUI{
    [self.customNavBar wr_setBottomLineHidden:NO];
    NSString *city = [MMNSUserDefaults objectForKey:SelectedCity];
    if (!city) {
        city = @"郑州市";
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self.customNavBar wr_setRightButtonWithTitle:city titleColor:HEX_COLOR(0xCA1400)];
    self.customNavBar.rightButton.setTitleFontSize(14);
    [self.customNavBar setOnClickRightButton:^{
        //添加
        
    }];
    WEAK(weakSelf);
    self.tableV = [[SXF_HF_addCardView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];
    
    [self.view addSubview:self.tableV];
    self.tableV.moreCardCallback = ^(NSInteger section) {
        //更多card
        SXF_HF_moreVipCardVC *vc = [SXF_HF_moreVipCardVC new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    //cellAction
    self.tableV.selectRow = ^(NSIndexPath * _Nonnull indexP) {
        NSLog(@"分区%ld---行%ld", indexP.section, indexP.row);
        SXF_HF_WKWebViewVC *webVC = [SXF_HF_WKWebViewVC new];
#warning 需要穿第参数
        webVC.urlString = SXF_WEB_URLl_Str(membershipInformation);
        [weakSelf.navigationController pushViewController:webVC animated:YES];
    };
}
@end
