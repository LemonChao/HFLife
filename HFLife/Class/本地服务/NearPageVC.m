//
//  NearPageVC.m
//  HFLife
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "NearPageVC.h"
#import "YYB_HF_LocalHeadView.h"
#import "YYB_HF_LifeLocaView.h"
#import "YBPopupMenu.h"
@interface NearPageVC (){
    int arc;
}
/** 容器TableView*/
@property(nonatomic, strong) UIView *headView;
@property(nonatomic, strong) NSMutableDictionary *cellHeightDic;
@property(nonatomic, strong) YYB_HF_LifeLocaView *myLocaVeiw;
@end

@implementation NearPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellHeightDic = [NSMutableDictionary dictionary];
    
    YYB_HF_LocalHeadView *headView = [[YYB_HF_LocalHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NavBarHeight)];
    [self.view addSubview:headView];
    self.headView = headView;
    
    self.myLocaVeiw = [[YYB_HF_LifeLocaView alloc]initWithFrame:CGRectZero];
    
    [self.view addSubview:self.myLocaVeiw];
//    [self.myLocaVeiw setFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight)];
    [self.myLocaVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headView.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(self.view).mas_offset(0);
        make.right.mas_equalTo(self.view).mas_offset(-0);
        
        make.height.mas_equalTo(SCREEN_HEIGHT - NavBarHeight - TabBarHeight);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.customNavBar setHidden:YES];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
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
