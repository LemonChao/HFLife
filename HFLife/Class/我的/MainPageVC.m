
//
//  MainPageVC.m
//  HFLife
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "MainPageVC.h"

@interface MainPageVC ()

@end

@implementation MainPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"我的";
    self.navigationController.navigationBarHidden = YES;
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [SXF_HF_LoginAlertView showLoginAlertComplete:nil];
    
    
}
@end
