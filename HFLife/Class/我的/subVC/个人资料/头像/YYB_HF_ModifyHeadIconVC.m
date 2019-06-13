//
//  YYB_HF_ModifyHeadIconVC.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_ModifyHeadIconVC.h"
#import "HXPhotoPicker.h"
@interface YYB_HF_ModifyHeadIconVC ()<HXAlbumListViewControllerDelegate>
@property(nonatomic, strong) UIButton *imageBtn;
@property(nonatomic, strong) HXPhotoManager *photo_manager;
@end

@implementation YYB_HF_ModifyHeadIconVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBar];
    
    [self initView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.customNavBar.hidden  = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.customNavBar.hidden = YES;
}

-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"icon_more"]];
//    [self.customNavBar wr_setRightButtonWithTitle:@"发布" titleColor:HEX_COLOR(0xC04CEB)];
    //    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"yynavi_bg"];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    //修改头像
    [self.customNavBar setOnClickRightButton:^{
        
        NSLog(@"改头像");
        ZHB_HP_PreventWeChatPopout *preView = [[ZHB_HP_PreventWeChatPopout alloc]initWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"从相册上传",@"拍照上传"] actionSheetBlock:^(NSInteger index) {
            //相册
            if (index == 0) {
                HXAlbumListViewController *vc = [[HXAlbumListViewController alloc] init];
                vc.doneBlock = ^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photoList, NSArray<HXPhotoModel *> *videoList, BOOL original, HXAlbumListViewController *viewController) {
                    if (photoList && photoList.count > 0) {
                        UIImage *image = photoList.lastObject.previewPhoto;
                        [weakSelf setHeadIcon:image];
                    }
                };
                vc.manager = weakSelf.photo_manager;
               
                HXCustomNavigationController *nav = [[HXCustomNavigationController alloc] initWithRootViewController:vc];
                nav.supportRotation = YES;
                [weakSelf presentViewController:nav animated:YES completion:nil];
                
            }else if(index == 1) {//相机
                HXCustomCameraViewController *vc = [[HXCustomCameraViewController alloc] init];
                vc.doneBlock = ^(HXPhotoModel *model, HXCustomCameraViewController *viewController) {
                    if (model) {
                        [weakSelf setHeadIcon:model.previewPhoto];
                    }
                };
                HXCustomNavigationController *nav = [[HXCustomNavigationController alloc] initWithRootViewController:vc];
                [weakSelf presentViewController:nav animated:YES completion:nil];
            }
            
        }];
        [preView show];
    }];
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"头像";
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}

- (void)initView {
    UIButton *imageV = [[UIButton alloc]init];
    imageV.userInteractionEnabled = NO;
    [self.view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.height.mas_equalTo(SCREEN_WIDTH);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    self.imageBtn = imageV;
    [self.imageBtn sd_setImageWithURL:[NSURL URLWithString:[userInfoModel sharedUser].member_avatar] forState:UIControlStateNormal placeholderImage:image(@"user__easyico")];

}

- (HXPhotoManager *)photo_manager {
    if (!_photo_manager) {
        _photo_manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _photo_manager.configuration.singleSelected = YES;
        _photo_manager.configuration.albumListTableView = ^(UITableView *tableView) {

        };
    }
    return _photo_manager;
}

- (void) setHeadIcon:(UIImage *)image {
    [[WBPCreate sharedInstance]showWBProgress];
    [networkingManagerTool requestToServerWithType:UPDATE withSubUrl:kCenterAdress(kUploadFiles) withParameters:@{@"image" : image} withResultBlock:^(BOOL result, id value) {
        [[WBPCreate sharedInstance] hideAnimated];
        if (result) {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *data = value[@"data"];
                NSString *urlStr = [data safeObjectForKey:@"url"];
                [userInfoModel sharedUser].member_avatar = urlStr;
                
                if (urlStr && [urlStr isKindOfClass:[NSString class]] && urlStr.length > 0) {
                    [[WBPCreate sharedInstance] showWBProgress];
                    
                    [networkingManagerTool requestToServerWithType:POST withSubUrl:kCenterAdress(kSaveMemberBase) withParameters:@{@"field":@"member_avatar",@"value":urlStr} withResultBlock:^(BOOL result, id value) {
                        [[WBPCreate sharedInstance] hideAnimated];
                        if (result) {
                            if (value && [value isKindOfClass:[NSDictionary class]]) {
                                NSDictionary *dataDic = value[@"data"];
                                NSString *token = [dataDic safeObjectForKey:@"ucenter_token"];
                                if (token && token.length > 0) {
                                    [[NSUserDefaults standardUserDefaults] setValue:token forKey:USER_TOKEN];
                                }else {
                                    [WXZTipView showCenterWithText:@"资料修改成功,token获取失败"];
                                }
                            }
                            [userInfoModel sharedUser].userHeaderImage = image;
                            [userInfoModel getUserInfo];
                            [self.navigationController popViewControllerAnimated:YES];
                            
                        }else {
                            if (value && [value isKindOfClass:[NSDictionary class]]) {
                                [WXZTipView showCenterWithText:value[@"msg"]];
                            }else {
                                [WXZTipView showCenterWithText:@"网络错误"];
                            }
                        }
                    }];
                    [userInfoModel sharedUser].member_avatar = urlStr;
                    [self.imageBtn sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal placeholderImage:self.imageBtn.imageView.image];
                }
            }else {
                [WXZTipView showCenterWithText:@"返回上传地址错误"];
            }
            
        }else {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络错误"];
            }
        }
    }];

}
@end
