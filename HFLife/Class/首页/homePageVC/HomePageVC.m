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


//test
#import "ReviseMobilePhone.h"
@interface HomePageVC ()
@property (nonatomic, strong)SXF_HF_HomePageView *collectionView;
@property (nonatomic, strong)SXF_HF_CustomSearchBar *searchBar;
@property (nonatomic, strong)SXF_HF_HomePageVM *homePageVM;
@property (nonatomic, strong)NSArray *bannerModelArr;
@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //引导页
    [self addGuideView];
    [self setUpUI];
    [self setUpActions];
    
    
    //加载数据
    [self loadServerData];
    
//    [self VersionBounced];
    
    [self versionUpdateRequest];
    
}
//网络数据
- (void)loadServerData{
    [self.homePageVM  getBannerData];
    [self.homePageVM getNewsListData:1];
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
    self.collectionView.selectedItem = ^(NSIndexPath * _Nonnull indexPath, id value) {
        [weakSelf.homePageVM clickCellItem:indexPath value:value];
    };
    self.collectionView.refreshDataCallBack = ^(NSInteger page) {
        [weakSelf.homePageVM getNewsListData:page];
        if (page == 1) {
            //刷新 header 数据  banner数据
            [weakSelf.homePageVM getBannerData];
        }
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
//        [SXF_HF_payStepAleryView showAlertComplete:^(BOOL btnBype) {
//
//        }];
        
//        [self loadServerData:1];
        
        
        //语音朗读
//        [voiceHeaper say:@"我靠!下班吃饭了!"];
//        [touchID_helper showTouchIDshowType:@"" complate:^(BOOL success, NSError * _Nullable error) {
//
//        }];
//        return ;
        
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
           SXF_HF_AlertView *alertVC = [SXF_HF_AlertView showAlertType:AlertType_cancellation Complete:^(BOOL btnBype) {
                if (btnBype) {
                    //收款码介绍
                    BaseViewController *vc = [ReviseMobilePhone new];
                    vc.customNavBar.title = @"更换手机号";
                    [self.navigationController pushViewController:vc animated:YES];
                }

            }];
            alertVC.title = @"hahah";
            
            
//            [SXF_HF_AlertView showTimeSlecterAlertComplete:^(NSString * _Nonnull year, NSString * _Nonnull month) {
//
//            }];
        });
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
        _homePageVM.collectionView = self.collectionView;
    }
    return _homePageVM;
}







@end
