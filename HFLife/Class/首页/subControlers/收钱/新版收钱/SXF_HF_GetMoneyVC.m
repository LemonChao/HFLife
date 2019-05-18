
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
        
    }];
}




@end
