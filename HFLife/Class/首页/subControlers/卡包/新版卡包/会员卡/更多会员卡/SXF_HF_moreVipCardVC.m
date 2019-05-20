
//
//  SXF_HF_moreVipCardVC.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_moreVipCardVC.h"
#import "SXF_HF_moreVipCardView.h"
#import "SXF_HF_cardDetaileVC.h"
@interface SXF_HF_moreVipCardVC ()
@property (nonatomic, strong)SXF_HF_moreVipCardView *tableV;
@end

@implementation SXF_HF_moreVipCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"购物";
    [self setUpUI];
}

- (void)setUpUI{
    WEAK(weakSelf);
    
    [self.customNavBar wr_setBottomLineHidden:NO];
    self.tableV = [[SXF_HF_moreVipCardView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];

    [self.view addSubview:self.tableV];

    self.tableV.selectRow = ^(NSIndexPath * _Nonnull indexP) {
        BaseViewController *vc;
        vc = [SXF_HF_cardDetaileVC new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
}

@end
