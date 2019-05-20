
//
//  SXF_HF_addCardVC.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_addCardVC.h"

@interface SXF_HF_addCardVC ()

@end

@implementation SXF_HF_addCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"卡包";
    
    
    [self setUpUI];
}


- (void)setUpUI{
    
    NSString *city = [MMNSUserDefaults objectForKey:selectedCity];
    
    [self.customNavBar wr_setRightButtonWithTitle:city titleColor:HEX_COLOR(0xCA1400)];
    self.customNavBar.rightButton.setTitleFontSize(14);
    [self.customNavBar setOnClickRightButton:^{
        //添加
        
    }];
    
}
@end
