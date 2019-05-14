
//
//  MainPageVC.m
//  HFLife
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "MainPageVC.h"
#import "SXF_HF_MainPageView.h"


#import "ShippingAddressVC.h"
#import "BindingPayWayVC.h"


@interface MainPageVC ()
@property (nonatomic, strong)SXF_HF_MainPageView *mainPageView;
@end

@implementation MainPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"";
    [self setUpUI];
    
    
    [networkingManagerTool requestToServerWithType:POST withSubUrl:shopUrl withParameters:@{@"key1" : @"value1"} withResultBlock:^(BOOL result, id value) {
        
    }];
    
}
- (void)setUpUI{
    self.mainPageView = [[SXF_HF_MainPageView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight - self.tabBarHeight)];
    [self.view addSubview:self.mainPageView];
    
    WEAK(weakSelf);
    self.mainPageView.selectedItemCallback = ^(NSIndexPath * _Nonnull indexPath) {
        NSLog(@"分区 %ld   行%ld", (long)indexPath.section, (long)indexPath.row);
        BaseViewController *vc = [BaseViewController new];
        
        //token不存在 跳转 登录
#warning 需要取反
        if (![NSString isNOTNull:[HeaderToken getAccessToken]]) {
            [SXF_HF_AlertView showAlertType:AlertType_login Complete:^(BOOL btnBype) {
                if (btnBype) {
                    //登录页
                    [WXZTipView showCenterWithText:@"去登陆"];
                    return ;
                }
            }];
        }else {
            if (indexPath.section == 1) {
                switch (indexPath.row) {
                    case 0:
                        vc = [ShippingAddressVC new];
                        break;
                    case 1:
                    {
                        BindingPayWayVC *bindingVC = [BindingPayWayVC new];
                        bindingVC.isAlipay = NO;
                        vc = bindingVC;
                    }
                        break;
                    default:
                        break;
                }
            }
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        
        
    };
    
    
    [self.customNavBar wr_setLeftButtonWithTitle:@"我的" titleColor:HEX_COLOR(0x000000)];
    
    
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
