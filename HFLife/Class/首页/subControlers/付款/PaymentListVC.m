//
//  PaymentListVC.m
//  HFLife
//
//  Created by sxf on 2019/4/12.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "PaymentListVC.h"

@interface PaymentListVC ()

@end

@implementation PaymentListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
//    [self initEmptyDataViewbelowSubview:self.customNavBar touchBlock:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar setOnClickRightButton:^{
        NSLog(@"搜索");
    }];
    [self.customNavBar wr_setBackgroundAlpha:1];
    [self.customNavBar wr_setBottomLineHidden:YES];
        // 设置导航栏显示图片
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"topFoodImage"];
    self.customNavBar.title = @"付款记录";
        //    [self.customNavBar wr_setRightButtonWithImage:MMGetImage(@"NearFoodSousuo")];
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
