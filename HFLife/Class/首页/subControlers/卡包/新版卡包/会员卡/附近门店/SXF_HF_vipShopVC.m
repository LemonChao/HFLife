
//
//  SXF_HF_vipShopVC.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_vipShopVC.h"
#import "SXF_HF_vipShopView.h"
#import "SXF_HF_nearMapShopVC.h"
@interface SXF_HF_vipShopVC ()
@property (nonatomic, strong)SXF_HF_vipShopView *tableV;
@end

@implementation SXF_HF_vipShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"附近门店";
    [self setUpUI];
}

- (void)setUpUI{
    WEAK(weakSelf);
    
    [self.customNavBar wr_setBottomLineHidden:NO];
    self.tableV = [[SXF_HF_vipShopView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];
    [self.view addSubview:self.tableV];
    
    self.tableV.selectRow = ^(NSIndexPath * _Nonnull indexP) {
        SXF_HF_nearMapShopVC *vc = [SXF_HF_nearMapShopVC new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
}

@end
