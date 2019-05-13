
//
//  MainPageVC.m
//  HFLife
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "MainPageVC.h"
#import "SXF_HF_MainPageView.h"
@interface MainPageVC ()
@property (nonatomic, strong)SXF_HF_MainPageView *mainPageView;
@end

@implementation MainPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"我的";
    self.navigationController.navigationBarHidden = YES;
//    [self setUpUI];
    
    
    [networkingManagerTool requestToServerWithType:POST withSubUrl:shopUrl withParameters:@{@"key1" : @"value1"} withResultBlock:^(BOOL result, id value) {
        
    }];
    
}
- (void)setUpUI{
    self.mainPageView = [[SXF_HF_MainPageView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight - self.tabBarHeight)];
    [self.view addSubview:self.mainPageView];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [SXF_HF_AlertView showAlertType:AlertType_save Complete:^(BOOL btnBype) {
        if (btnBype) {
            NSLog(@"right");
        }else{
            NSLog(@"left");
        }
    }];
    
    
}
@end
