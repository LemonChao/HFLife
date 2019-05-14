//
//  InviteVC.m
//  HanPay
//
//  Created by mac on 2019/2/11.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "InviteVC.h"
#import "HXEasyCustomShareView.h"
#import "ShareProductInfoView.h"
//#import "HP_GetShareNetApi.h"
@interface InviteVC ()
@property (nonatomic , strong) NSDictionary *shardResult;
@end

@implementation InviteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    [self setupNavBar];
    
//    self.shardResult = [NSDictionary dictionary];
    
    /*
    
    
    HP_GetShareNetApi * request = [[HP_GetShareNetApi alloc] init];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_GetShareNetApi *requst = (HP_GetShareNetApi *)request;
        
        if ([requst getCodeStatus] == 1) {
            NSDictionary *resut = [requst getContent];
            if ([resut isKindOfClass:[NSDictionary class]]){
                
                self.shardResult = resut;
            }
            
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
     
     */
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"fanhuianniu"]];
    [self.customNavBar wr_setRightButtonWithTitle:@"" titleColor:[UIColor whiteColor]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"myOrderBG"];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"";
//    self.customNavBar.titleLabelColor = [UIColor whiteColor];
}
-(void)initWithUI{
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.image = MMGetImage(@"zhuyemian");
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    UIButton *button = [UIButton new];
    [button setImage:MMGetImage(@"anniu") forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-HeightRatio(49));
        make.width.mas_equalTo(WidthRatio(401));
        make.height.mas_equalTo(HeightRatio(108));
    }];
}
-(void)buttonClick{
    [self addGuanjiaShareView];
}
- (void)addGuanjiaShareView {
    NSArray *shareAry = @[@{@"image":@"shareView_wx",
                            @"title":@"微信"},
                          @{@"image":@"shareView_friend",
                            @"title":@"朋友圈"},
                          @{@"image":@"shareView_qq",
                            @"title":@"QQ"},
                          @{@"image":@"shareView_qzone",
                            @"title":@"QQ空间"}];
    
        //    @{@"image":@"share_copyLink",
        //      @"title":@"复制链接"}
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, 54)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, headerView.frame.size.width, 15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"分享到";
    [headerView addSubview:label];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height-0.5, headerView.frame.size.width, 0.5)];
    lineLabel.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0];
    [headerView addSubview:lineLabel];
    
    UILabel *lineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 0.5)];
    lineLabel1.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0];
    
    HXEasyCustomShareView *shareView = [[HXEasyCustomShareView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, CGMMainScreenHeight)];
    shareView.backView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    shareView.headerView = headerView;
    float height = [shareView getBoderViewHeight:shareAry firstCount:7];
    shareView.boderView.frame = CGRectMake(0, 0, shareView.frame.size.width, height);
    shareView.middleLineLabel.hidden = YES;
    [shareView.cancleButton addSubview:lineLabel1];
    shareView.cancleButton.frame = CGRectMake(shareView.cancleButton.frame.origin.x, shareView.cancleButton.frame.origin.y, shareView.cancleButton.frame.size.width, 54);
    shareView.cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [shareView.cancleButton setTitleColor:[UIColor colorWithRed:184/255.0 green:184/255.0 blue:184/255.0 alpha:1.0] forState:UIControlStateNormal];
    [shareView setShareAry:shareAry delegate:self];
    [self.navigationController.view addSubview:shareView];
}

- (void)addShareViewForH5{
    
    NSArray *shareAry = @[@{@"image":@"shareView_wx",
                            @"title":@"微信"},
                          @{@"image":@"shareView_friend",
                            @"title":@"朋友圈"},
                          @{@"image":@"shareView_qq",
                            @"title":@"QQ"},
                          @{@"image":@"shareView_qzone",
                            @"title":@"QQ空间"}];
    
    //    @{@"image":@"share_copyLink",
    //      @"title":@"复制链接"}
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, 54)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, headerView.frame.size.width, 15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"分享到";
    [headerView addSubview:label];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height-0.5, headerView.frame.size.width, 0.5)];
    lineLabel.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0];
    [headerView addSubview:lineLabel];
    
    UILabel *lineLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 0.5)];
    lineLabel1.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0];
    
    HXEasyCustomShareView *shareView = [[HXEasyCustomShareView alloc] initWithFrame:CGRectMake(0, 0, CGMMainScreenWidth, CGMMainScreenHeight)];
    shareView.backView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    shareView.headerView = headerView;
    float height = [shareView getBoderViewHeight:shareAry firstCount:7];
    shareView.boderView.frame = CGRectMake(0, 0, shareView.frame.size.width, height);
    shareView.middleLineLabel.hidden = YES;
    [shareView.cancleButton addSubview:lineLabel1];
    shareView.cancleButton.frame = CGRectMake(shareView.cancleButton.frame.origin.x, shareView.cancleButton.frame.origin.y, shareView.cancleButton.frame.size.width, 54);
    shareView.cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [shareView.cancleButton setTitleColor:[UIColor colorWithRed:184/255.0 green:184/255.0 blue:184/255.0 alpha:1.0] forState:UIControlStateNormal];
    [shareView setShareAry:shareAry delegate:nil];
    shareView.shareViewButtonAction = ^(HXEasyCustomShareView *shareView, NSString *title) {
        NSLog(@"当前点击:%@",title);
        
        SSDKPlatformType type;
        if ([title isEqualToString:@"微信"]) {
            type = SSDKPlatformSubTypeWechatSession;
        }else if ([title isEqualToString:@"朋友圈"]){
            type = SSDKPlatformSubTypeWechatTimeline;
        }else if ([title isEqualToString:@"QQ"]){
            type = SSDKPlatformSubTypeQQFriend;
        }else if ([title isEqualToString:@"QQ空间"]){
            type = SSDKPlatformSubTypeQZone;
        }else{
            return;
        }
        
        
        NSLog(@"%@", self->_shardResult);
        if (self->_shardResult) {
            //        NSArray *imagesArr = ;
            
            [ShareProductInfoView shareBtnClick:type ShareImage:self.shardResult[@"image"] title:self.shardResult[@"title"] url:self.shardResult[@"url"] context:self.shardResult[@"text"] shareBtnClickBlock:^(BOOL isSucceed, NSString *msg) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [WXZTipView showCenterWithText:msg];
                });
                
            }];
        }else {
            
            
            /*
            
            
            HP_GetShareNetApi * request = [[HP_GetShareNetApi alloc] init];
            [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                HP_GetShareNetApi *requst = (HP_GetShareNetApi *)request;
                
                if ([requst getCodeStatus] == 1) {
                    NSDictionary *resut = [requst getContent];
                    if ([resut isKindOfClass:[NSDictionary class]]){
                        
                        self.shardResult = resut;
                        [ShareProductInfoView shareBtnClick:type ShareImage:self.shardResult[@"image"] title:self.shardResult[@"title"] url:self.shardResult[@"url"] context:self.shardResult[@"text"] shareBtnClickBlock:^(BOOL isSucceed, NSString *msg) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [WXZTipView showCenterWithText:msg];
                            });
                            
                        }];
                    }
                    
                }
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                
            }];
             
             
             */
             
        }
        
        [shareView tappedCancel];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
}



#pragma mark HXEasyCustomShareViewDelegate
- (void)easyCustomShareViewButtonAction:(HXEasyCustomShareView *)shareView title:(NSString *)title {
    NSLog(@"当前点击:%@",title);
    SSDKPlatformType type;
    if ([title isEqualToString:@"微信"]) {
        type = SSDKPlatformSubTypeWechatSession;
    }else if ([title isEqualToString:@"朋友圈"]){
        type = SSDKPlatformSubTypeWechatTimeline;
    }else if ([title isEqualToString:@"QQ"]){
        type = SSDKPlatformSubTypeQQFriend;
    }else if ([title isEqualToString:@"QQ空间"]){
        type = SSDKPlatformSubTypeQZone;
    }else{
        return;
    }
    
    
    NSLog(@"%@", _shardResult);
    if (_shardResult) {
//        NSArray *imagesArr = ;

        [ShareProductInfoView shareBtnClick:type ShareImage:self.shardResult[@"image"] title:self.shardResult[@"title"] url:self.shardResult[@"url"] context:self.shardResult[@"text"] shareBtnClickBlock:^(BOOL isSucceed, NSString *msg) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [WXZTipView showCenterWithText:msg];
            });
            
        }];
    }
    
    [shareView tappedCancel];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
