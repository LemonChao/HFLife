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
#import "LoginVC.h"




//test
#import "ReviseMobilePhone.h"



#import "JMTabBarController.h"
#import "JMConfig.h"

@interface HomePageVC ()
@property (nonatomic, strong)SXF_HF_HomePageView *collectionView;
@property (nonatomic, strong)SXF_HF_CustomSearchBar *searchBar;
@property (nonatomic, strong)SXF_HF_HomePageVM *homePageVM;
@property (nonatomic, strong)NSArray *bannerModelArr;
@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
     //是否是第一次
    [HRFirstEnter isFirst:^{
       //弹出登录
        [LoginVC login];
        return ;
    }];
    
    //引导页
    [self addGuideView];
    [self setUpUI];
    [self setUpActions];
    
    //接收推送通知
    [NOTIFICATION addObserver:self selector:@selector(getFQValue:) name:JPUSH_FQ object:nil];
    
    
    [userInfoModel sharedUser].set_pass = @(0);
    
    
}

//有网 刷新数据(重回写父类)
- (void)haveNetRefreshData{
    [self loadServerData];
}




- (void)getFQValue:(NSNotification *)notifi{
    NSLog(@"%@", notifi.userInfo);
    self.homePageVM.fqValue = notifi.object[@"content"];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.homePageVM fireTimer];
    //加载数据
    [self loadServerData];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.homePageVM cancleTimer];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}



//网络数据
- (void)loadServerData{
    [self.homePageVM  getBannerData];
    [self.homePageVM getNewsListData:1];
    //用户信息
    [userInfoModel getUserInfo];
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
    //活动按钮点击事件
    self.collectionView.activityBtnCallback = ^(NSString * _Nonnull urlStr) {
        [weakSelf.homePageVM clickActivityBtn:urlStr];
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
    
//    [self.view addSubview:testBtn];
    [testBtn wh_addActionHandler:^{

        [touchID_helper showTouchIDshowType:@"" complate:^(BOOL success, NSError * _Nullable error) {
        }];
//        return ;
    }];
    WEAK(weakSelf);
    self.collectionView.clickSectionHeaderBtn = ^(NSInteger section) {
        if (section == 2) {
            //更过新闻
            SXF_HF_WKWebViewVC *webVC = [SXF_HF_WKWebViewVC new];
            webVC.urlString = SXF_WEB_URLl_Str(headlinesList);
            [weakSelf.navigationController pushViewController:webVC animated:YES];
        }
    };
    
    
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
        
#warning 新需求
        //视频引导页
        [self videoGuideView];
    }else{
        //视频引导页
//        [self videoGuideView];
        
        [self versionUpdateRequest];
    }
}
- (void)setStaticGuidePage {
    NSArray *imageNameArray = @[@"intro1.gif",@"intro2.gif",@"intro3.gif"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:NO];
    guidePage.slideInto = YES;
    guidePage.cancleGuildView = ^{
        //释放之后 调用 更新
        [self.homePageVM upDataLocation];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:guidePage];
}






- (SXF_HF_HomePageVM *)homePageVM{
    if (!_homePageVM) {
        _homePageVM = [[SXF_HF_HomePageVM alloc] init];
        _homePageVM.vc = self;
        _homePageVM.collectionView = self.collectionView;
    }
    return _homePageVM;
}



//视频引导页
- (void)videoGuideView{
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"final render_1" ofType:@"mp4"];
    DHGuidePageHUD *videoView = [[DHGuidePageHUD alloc] dh_initWithFrame:[UIScreen mainScreen].bounds videoURL:[NSURL fileURLWithPath:videoPath]];
    //设置销毁时间
    videoView.videoDuration = 5.5;
    [[UIApplication sharedApplication].keyWindow addSubview:videoView];
    videoView.cancleGuildView = ^{
        //释放之后 调用 更新
        [self.homePageVM upDataLocation];
        [self versionUpdateRequest];
    };

}



@end
