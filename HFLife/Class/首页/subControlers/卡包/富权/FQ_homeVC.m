
//
//  FQ_homeVC.m
//  HFLife
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "FQ_homeVC.h"
#import "FQ_homeTableV.h"
#import "exchangeFQ_VC.h"
#import "RichRightListVC.h"
#import "getOutFQ_VC.h"
//#import "FQ_homePageNetApi.h"
@interface FQ_homeVC ()
@property (nonatomic, strong)FQ_homeTableV *tableV;
@end

@implementation FQ_homeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    
    [self setUpUI];
    
    
    
}
- (void) getData{
    
    /*
    
    FQ_homePageNetApi *homePageNetApi = [[FQ_homePageNetApi alloc] init];
    WS(weakSelf);
    [homePageNetApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        FQ_homePageNetApi *homePageApi = (FQ_homePageNetApi *)request;
        NSDictionary *valueDic = [homePageApi responseJSONObject];
        if ([valueDic isKindOfClass:[NSDictionary class]]) {
            
            if ([homePageApi getCodeStatus] == 1) {
                //更新数据
                [weakSelf reloadDataForView];
                [weakSelf.tableV setDataForView:valueDic];
            }else{
                [WXZTipView showTopWithText:valueDic[@"msg"]];
            }
        }else{
            [WXZTipView showCenterWithText:@"数据加载失败"];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [WXZTipView showTopWithText:@"数据加载失败"];
    }];
     
     */
}

- (void) reloadDataForView{
    
}






-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    //加载数据
    [self getData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}


- (void) setUpUI{
    self.tableV = [[FQ_homeTableV alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];
    [self.view addSubview:self.tableV];
    WS(weakSelf);
    self.tableV.selectedBtn = ^(NSInteger index) {
        NSLog(@"%ld", (long)index);
        UIViewController *vc;
        if (index == 0) {
            //兑换富权
            vc = [exchangeFQ_VC new];
        }else if (index == 1){
            //收益记录
            RichRightListVC *listVc = [RichRightListVC new];
            listVc.cellTitleArray = @[@"可兑换奖励", @"分享奖励（间）"];
//            listVc.cellValueArray = @[@"-1453.2546251487", @"1.0546287593份",@"2019-04-20"];
            listVc.recordType = 0;
            listVc.vcTitle = @"收益记录";
            vc = listVc;
        }else if(index == 2){
            //取出
            vc = [getOutFQ_VC new];
        }
        
        if (vc) {
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
}


-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:NO];
    self.customNavBar.title = @"我的富权";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    
    //    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"组余额记录"]];
    //    [self.customNavBar setOnClickRightButton:^{
    ////        Class vcclass = NSClassFromString(@"BalanceListVC");
    ////        BalanceListVC *vc=  [[vcclass alloc] init];
    ////        vc.titleStr = @"余额记录";
    //
    //        //测试详情
    //        BillDetailsVC *vc = [BillDetailsVC new];
    //        [weakSelf.navigationController pushViewController:vc animated:YES];
    //    }];
    
    
}
@end
