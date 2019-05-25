
//
//  SXF_HF_GetMoneyVC.m
//  HFLife
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_GetMoneyVC.h"
#import "SXF_HF_GetMoneyView.h"
#import "receiptRecordListVC.h"
#import "SetAmountVC.h"
@interface SXF_HF_GetMoneyVC ()
@property (nonatomic, strong)SXF_HF_GetMoneyView *getMoneyView;
@end

@implementation SXF_HF_GetMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"收钱";
    [self setUpUI];
    
    [self loadServerData];
    
}
- (void)loadServerData{
    NSDictionary *param = @{
                            @"type":@"1",
                            };
//    [networkingManagerTool requestToServerWithType:POST withSubUrl:@"" withParameters:param withResultBlock:^(BOOL result, id value) {
//        if (result){
//            
//        }
//    } witnVC:self];
    
    
    //模拟网络请求 获取收款码
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //临时数据
        [self.getMoneyView setDataForView:@"https://www.hfgld.net/app_html/qrcode_pay/show_pay.html?show_code=5A005141F931A300"];
    });
    
    
    
}


- (void)setUpUI{
    self.getMoneyView  = [[SXF_HF_GetMoneyView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];
    [self.view addSubview:self.getMoneyView];
    WEAK(weakSelf);
    self.getMoneyView.tabBtnCallback = ^(NSInteger index) {
        NSLog(@"%ld", index);
        
        BaseViewController *vc = [BaseViewController new];
        if (index == 0) {
            //设置金额
            vc = [SetAmountVC new];
        }else if (index == 2){
            //收款记录
            vc = [[receiptRecordListVC alloc] init];
        }else if (index == 3){
            //正在付款z。。。。
        }else if (index == 4){
            //商家入驻
        }
        
        [weakSelf.navigationController pushViewController:vc animated:YES];

    };
    
    
    
    [self.customNavBar wr_setRightButtonWithImage:MY_IMAHE(@"更多")];
    [self.customNavBar setOnClickRightButton:^{
        [SXF_HF_AlertView showAlertType:AlertType_topRight Complete:^(BOOL btnBype) {
            if (btnBype) {
                //收款码介绍
                BaseViewController *vc = [BaseViewController new];
                vc.customNavBar.title = @"收款码介绍";
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            
        }];
    }];
}




@end
