//
//  YYB_HF_LocalHeadView.m
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "YYB_HF_LocalHeadView.h"
#import "CityChooseVC.h"
@interface YYB_HF_LocalHeadView()<CityChooseVCDelegate>
/** 头像 */
@property(nonatomic, strong) UIImageView *headImageV;
/** 位置 */
@property(nonatomic, strong) UILabel *localLabel;
/** 选择icon */
@property(nonatomic, strong) UIButton *selectBtn;
/** 搜索内容 */
@property(nonatomic, strong) UILabel *searchlabel;
/** 订单列表icon */
@property(nonatomic, strong) UIImageView *orderAlertImageView;
@property(nonatomic, strong) UIView *orderAlertImageViewBgview;//订单背景

@property(nonatomic, strong) UIView *searchBgView;
@property(nonatomic, strong) UIImageView *searchIcon;

@end
@implementation YYB_HF_LocalHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    self.headImageV = [UIImageView new];
    self.localLabel = [UILabel new];
    self.selectBtn = [UIButton new];
    self.searchlabel = [UILabel new];
    self.orderAlertImageView = [UIImageView new];
    self.orderAlertImageViewBgview = [UIView new];
    
    
    [self addSubview:self.headImageV];
    [self addSubview:self.localLabel];
    [self addSubview:self.selectBtn];
    [self addSubview:self.orderAlertImageView];
    [self addSubview:self.orderAlertImageViewBgview];
    
//    self.headImageV.backgroundColor = [UIColor redColor];
    self.headImageV.image = MMGetImage(@"icon_touxiang");
    self.headImageV.clipsToBounds = YES;
    self.headImageV.layer.cornerRadius = ScreenScale(16);
    
    self.headImageV.userInteractionEnabled = YES;
    [self.headImageV wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        if (self.userHeadClick) {
            self.userHeadClick();
        }
    }];
    
    [self.selectBtn setImage:MMGetImage(@"icon_jiantou") forState:UIControlStateNormal];
    
    self.localLabel.text = @"定位中";
    self.localLabel.font = FONT(14);
    
//    self.selectBtn.backgroundColor = [UIColor redColor];
    
    UIView *searchBgView = [UIView new];
    searchBgView.backgroundColor = HEX_COLOR(0xF5F5F5);
    searchBgView.clipsToBounds = YES;
    searchBgView.layer.cornerRadius = ScreenScale(4);
    self.searchBgView = searchBgView;
    [self addSubview:searchBgView];
    
    UIImageView *searchIcon = [UIImageView new];
//    searchIcon.backgroundColor = [UIColor redColor];
    searchIcon.image = MMGetImage(@"搜索");
    [searchBgView addSubview:searchIcon];
    self.searchIcon = searchIcon;
    
    [searchBgView addSubview:self.searchlabel];
    self.searchlabel.text = @"海底捞";
    self.searchlabel.textColor = HEX_COLOR(0xAAAAAA);
    self.searchlabel.font = FONT(13);
    
    [self.orderAlertImageView setImage:image(@"icon_order")];
    
    self.orderAlertImageViewBgview.userInteractionEnabled = YES;
    self.orderAlertImageViewBgview.backgroundColor = [UIColor clearColor];
    
    [self.orderAlertImageViewBgview wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        //订单列表
        NSLog(@"orderAlertImageView");
        if (self.orderIconClick) {
            self.orderIconClick();
        }else {
            [WXZTipView showCenterWithText:@"click -line orderAlert"];
        }
    }];
    
    self.localLabel.userInteractionEnabled = YES;
    //城市列表
    [self.localLabel wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self gotoCityVC];
    }];
    
    [self.selectBtn wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self gotoCityVC];
    }];
    
    searchBgView.userInteractionEnabled = YES;
    [searchBgView wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
       
        if (self.searchIconClick) {
            self.searchIconClick();
        }else{ [WXZTipView showCenterWithText:@"click -line 搜索"]; }
//        [self.viewController.navigationController pushViewController:[NSClassFromString(@"YYB_HF_NearSearchVC") new] animated:YES];
//        [self shareInfo];
    }];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(HeightStatus + ScreenScale(7));
        make.left.mas_equalTo(self).mas_offset(ScreenScale(20));
        make.width.height.mas_equalTo(ScreenScale(32));
    }];
    
    [self.localLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(self.headImageV.mas_right).mas_offset(ScreenScale(10));
        make.height.mas_equalTo(ScreenScale(33));
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(self.localLabel.mas_right).mas_offset(3);
        make.height.mas_equalTo(ScreenScale(14));
        make.width.mas_equalTo(ScreenScale(10));
    }];
    
    [self.searchBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(self.selectBtn.mas_right).mas_offset(ScreenScale(20));
        make.right.mas_equalTo(self).mas_offset(-ScreenScale(67));
        make.height.mas_equalTo(ScreenScale(33));
    }];
    
    [self.searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(self.searchBgView).mas_offset(ScreenScale(22));
        make.width.height.mas_equalTo(ScreenScale(14));
    }];
    [self.searchlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(self.searchIcon.mas_right).mas_offset(ScreenScale(10));
        make.height.mas_equalTo(ScreenScale(13));
        make.right.mas_equalTo(self.searchBgView);
    }];
    
    [self.orderAlertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(ScreenScale(-25));
        make.centerY.mas_equalTo(self.searchBgView);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(21);
    }];
    
    [self.orderAlertImageViewBgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(ScreenScale(-5));
        make.centerY.mas_equalTo(self.searchBgView);
        make.height.mas_equalTo(25+5);
        make.width.mas_equalTo(21 + 30);
    }];
}

#pragma mark - method

- (void)shareInfo {
// w=user&t=get_invite_info
//    [networkingManagerTool requestToServerWithType:POST withSubUrl:@"" withParameters:nil withResultBlock:^(BOOL result, id value) {
//        if (value) {
//
//        }
//    }];
    
//    [self addShareViewForH5:nil];
    [self.viewController.navigationController pushViewController:[NSClassFromString(@"InviteVC") new] animated:YES];
    
}

- (void)addShareViewForH5:(NSDictionary *)shardResult{
    
    if (shardResult == nil) {
        shardResult = @{
                        @"image":image(@"head_icon"),
                        @"title":@"分享",
                        @"url":@"http://www.baidu.com",
                        @"text":@"分享内容"
                        };
    }
    
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
        
        [ShareProductInfoView shareBtnClick:type ShareImage:shardResult[@"image"] title:shardResult[@"title"] url:shardResult[@"url"] context:shardResult[@"text"] shareBtnClickBlock:^(BOOL isSucceed, NSString *msg) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [WXZTipView showCenterWithText:msg];
            });
            
        }];
        
        
        //        NSLog(@"%@", self->_shardResult);
        //        if (self->_shardResult) {
        //            //        NSArray *imagesArr = ;
        //
        //            [ShareProductInfoView shareBtnClick:type ShareImage:self.shardResult[@"image"] title:self.shardResult[@"title"] url:self.shardResult[@"url"] context:self.shardResult[@"text"] shareBtnClickBlock:^(BOOL isSucceed, NSString *msg) {
        //                dispatch_async(dispatch_get_main_queue(), ^{
        //                    [WXZTipView showCenterWithText:msg];
        //                });
        //
        //            }];
        //        }else {
        //
        //            HP_GetShareNetApi * request = [[HP_GetShareNetApi alloc] init];
        //            [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        //                HP_GetShareNetApi *requst = (HP_GetShareNetApi *)request;
        //
        //                if ([requst getCodeStatus] == 1) {
        //                    NSDictionary *resut = [requst getContent];
        //                    if ([resut isKindOfClass:[NSDictionary class]]){
        //
        //                        self.shardResult = resut;
        //                        [ShareProductInfoView shareBtnClick:type ShareImage:self.shardResult[@"image"] title:self.shardResult[@"title"] url:self.shardResult[@"url"] context:self.shardResult[@"text"] shareBtnClickBlock:^(BOOL isSucceed, NSString *msg) {
        //                            dispatch_async(dispatch_get_main_queue(), ^{
        //                                [WXZTipView showCenterWithText:msg];
        //                            });
        //
        //                        }];
        //                    }
        //
        //                }
        //            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //
        //            }];
        //        }
        
        [shareView tappedCancel];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
}

- (void)gotoCityVC {
    NSLog(@"choseCity");
    
    if (self.addressSelect) {
        self.addressSelect();
    }
    
//    CityChooseVC *cityChoose = [[CityChooseVC alloc]init];
//    cityChoose.delegate = self;
//    BaseNavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:cityChoose];
//    [self.viewController presentViewController:navigationController animated:YES completion:nil];
//    [self.viewController.navigationController pushViewController:[NSClassFromString(@"PYSearchViewController") new] animated:YES];
    
}

#pragma mark - setValue
- (void)setSetLocalStr:(NSString *)setLocalStr {
    self.localLabel.text = setLocalStr;
    [self.localLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(self.headImageV.mas_right).mas_offset(ScreenScale(10));
        make.height.mas_equalTo(ScreenScale(33));
        make.width.mas_equalTo(ScreenScale(16) * (self.localLabel.text.length > 6 ? 6 : self.localLabel.text.length));
    }];
}

- (void)setSetSearchStr:(NSString *)setSearchStr {
    self.searchlabel.text = setSearchStr;
}

- (void)setSetHeadImageStr:(NSString *)setHeadImageStr {
    [self.headImageV sd_setImageWithURL:[NSURL URLWithString:setHeadImageStr] placeholderImage:image(@"icon_touxiang")];
}

- (void)setSetHeadImage:(UIImage *)setHeadImage {
    if (setHeadImage && [setHeadImage isKindOfClass:[UIImage class]]) {
        [self.headImageV setImage:setHeadImage];
    }else {
        [self.headImageV sd_setImageWithURL:[NSURL URLWithString:[userInfoModel sharedUser].member_avatar] placeholderImage:image(@"icon_touxiang")];
    }
}



#pragma mark - cityDeleage
- (void)cityChooseName:(NSString *)name {
   
}
@end
