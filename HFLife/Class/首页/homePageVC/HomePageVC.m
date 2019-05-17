//
//  HomePageVC.m
//  HFLife
//
//  Created by mac on 2018/12/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HomePageVC.h"

//#import "JPUSHService.h"



#import "DHGuidePageHUD.h"
#import "SXF_HF_CustomSearchBar.h"
#import "SXF_HF_HomePageView.h"
#import "SXF_HF_HomePageVM.h"

#import "SXF_HF_payStepAleryView.h"
@interface HomePageVC ()
@property (nonatomic, strong)SXF_HF_HomePageView *collectionView;
@property (nonatomic, strong)SXF_HF_CustomSearchBar *searchBar;
@property (nonatomic, strong)SXF_HF_HomePageVM *homePageVM;
@end

@implementation HomePageVC



- (void)loadServerData:(NSInteger)page{
    WEAK(weakSelf);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.collectionView endRefreshData];
    });
    //刷新数据
    NSDictionary *param = @{
                            @"page":@(page),
                            };
    [networkingManagerTool requestToServerWithType:POST withSubUrl:HomeNavBanner withParameters:@{} withResultBlock:^(BOOL result, id value) {
        if (result){
            if (value) {
                NSLog(@"%@", value[@"msg"]);
            }
        }
    } witnVC:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //引导页
    [self addGuideView];
    [self setUpUI];
    [self setUpActions];
    
    [self VersionBounced];
    //加载数据
    [self loadServerData:1];
}

- (void)setUpActions{
    WEAK(weakSelf);
    //headerAction
    self.collectionView.selectedHeaderBtnBlock = ^(NSInteger index) {
        NSLog(@"点击区头 ： %ld", index);
        [weakSelf.homePageVM clickHeaderBtn:index];
    };
    
    self.searchBar.topBarBtnClick = ^(NSInteger tag) {
        NSLog(@"tag = %ld", tag);
        [weakSelf.homePageVM clickHeaderBtn:tag];
    };
    self.collectionView.selectedItem = ^(NSIndexPath * _Nonnull indexPath) {
        [weakSelf.homePageVM clickCellItem:indexPath];
    };
    self.collectionView.refreshDataCallBack = ^(NSInteger page) {
        [weakSelf loadServerData:page];
    };
}

- (void)setUpUI{
    SXF_HF_CustomSearchBar *searchBar = [[SXF_HF_CustomSearchBar alloc] initWithFrame:CGRectMake(0, statusBarHeight, SCREEN_WIDTH, 44)];
    [self.customNavBar addSubview:searchBar];
    self.searchBar = searchBar;


    SXF_HF_HomePageView *collectionView = [[SXF_HF_HomePageView alloc] initWithFrame:CGRectMake(0, NaviBarHeight + statusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBarHeight - TableBarHeight - statusBarHeight)];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    
    UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    testBtn.backgroundColor = [UIColor orangeColor];
    testBtn.center = self.view.center;
    
    [self.view addSubview:testBtn];
    [testBtn wh_addActionHandler:^{
        [SXF_HF_payStepAleryView showAlertComplete:^(BOOL btnBype) {

        }];
//        [self loadServerData:1];
    }];
    
    
}
- (void) click{
    BaseViewController *vc = [BaseViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)addGuideView{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
        // 静态引导页
        [self setStaticGuidePage];
    }
}
- (void)setStaticGuidePage {
    NSArray *imageNameArray = @[@"guide_1",@"guide_2",@"guide_3"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:NO];
    guidePage.slideInto = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:guidePage];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.homePageVM fireTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.homePageVM cancleTimer];
}



- (SXF_HF_HomePageVM *)homePageVM{
    if (!_homePageVM) {
        _homePageVM = [[SXF_HF_HomePageVM alloc] init];
        _homePageVM.vc = self;
    }
    return _homePageVM;
}







@end
