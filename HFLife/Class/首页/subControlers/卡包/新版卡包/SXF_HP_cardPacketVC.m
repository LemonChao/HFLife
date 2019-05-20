
//
//  SXF_HP_cardPacketVC.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HP_cardPacketVC.h"
#import "SXF_HF_addCardVC.h"
@interface SXF_HP_cardPacketVC ()

@end

@implementation SXF_HP_cardPacketVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBar.title = @"卡包";
    
    
    [self setUpUI];
    
    
    
}
- (void)setUpUI{
    [self.customNavBar wr_setRightButtonWithTitle:@"添加" titleColor:HEX_COLOR(0xCA1400)];
    self.customNavBar.rightButton.setTitleFontSize(14);
    [self.customNavBar setOnClickRightButton:^{
       //添加
    }];
    
    
    
    
    
    
    
}
@end
