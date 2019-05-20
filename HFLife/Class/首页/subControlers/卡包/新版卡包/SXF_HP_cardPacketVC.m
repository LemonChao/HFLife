
//
//  SXF_HP_cardPacketVC.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HP_cardPacketVC.h"
#import "SXF_HF_addCardVC.h"
#import "SXF_HP_cardPacketView.h"
@interface SXF_HP_cardPacketVC ()
@property (nonatomic, strong)SXF_HP_cardPacketView *tableV;
@end

@implementation SXF_HP_cardPacketVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"卡包";
    
    
    [self setUpUI];
    
    
    
}
- (void)setUpUI{
    WEAK(weakSelf);
    [self.customNavBar wr_setRightButtonWithTitle:@"添加" titleColor:HEX_COLOR(0xCA1400)];
    self.customNavBar.rightButton.setTitleFontSize(14);
    [self.customNavBar setOnClickRightButton:^{
       //添加
        SXF_HF_addCardVC *addVC = [SXF_HF_addCardVC new];
        [weakSelf.navigationController pushViewController:addVC animated:YES];
    }];
    
    
    self.tableV = [[SXF_HP_cardPacketView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];
    
    [self.view addSubview:self.tableV];
    
    
}
@end
