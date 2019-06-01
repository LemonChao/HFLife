//
//  PersonalDataVC.m
//  HanPay
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "PersonalDataVC.h"
#import "PersonalDataCell.h"
#import "ModifyNicknameVC.h"
#import "HXPhotoPicker.h"
#import "IdentityInformationVC.h"
#import "ReviewResultsVC.h"
#import "Per_MethodsToDealWithManage.h"
#import <ShareSDK/ShareSDK.h>
#import "YYB_HF_ModifyHeadIconVC.h"
#import "YYB_HF_SexChoiceView.h"
@interface PersonalDataVC ()<UITableViewDelegate,UITableViewDataSource,HXAlbumListViewControllerDelegate>
{
    NSArray *dataArray;
    NSArray *valueArray;
}
@property (nonatomic,strong)Per_MethodsToDealWithManage *permanage;
@property (nonatomic,strong)UITableView *contentTableView;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;
@end

@implementation PersonalDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  = [UIColor whiteColor];
    self.view.backgroundColor = HEX_COLOR(0xf4f7f7);
//    valueArray = @[@[[UserCache getUserPic],[UserCache getUserNickName],[UserCache getUserName],[UserCache getUserXinXiTitle],[NSString isNOTNull:[UserCache getUserPhone]] ? @"" : [[UserCache getUserPhone] EncodeTel]],@[@""]];
    
    if (([userInfoModel sharedUser].ID && [userInfoModel sharedUser].ID > 0)) {
        dataArray = @[@[@"头像",@"用户名称",@"昵称",@"性别",@"年龄"],@[@"实名认证"],@[@"退出登录"]];
    }else {
        dataArray = @[@[],@[],@[@"退出登录"]];
    }
    [self initWithUI];
    [self setupNavBar];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    userInfoModel *user = [userInfoModel sharedUser];
    self->valueArray = @[@[[NSString judgeNullReturnString:user.member_avatar],[NSString judgeNullReturnString:user.member_mobile],[NSString judgeNullReturnString:user.nickname],[NSString judgeNullReturnString:user.member_sexName],user.member_age ? user.member_age.stringValue : @""],@[[NSString judgeNullReturnString:user.rz_statusName]],@[@""]];
    [self.contentTableView reloadData];
    
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
//    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar setOnClickRightButton:^{
        NSLog(@"搜索");
    }];
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"个人资料";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
//    self.customNavBar.backgroundColor = RGBA(136, 53, 230, 1);
}
-(void)initWithUI{
    
    [self.view addSubview:self.contentTableView];
    [self.contentTableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight + 8);
    }];
}
#pragma mark 列表代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = dataArray[section];
    return array.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonalDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalDataCell"];
    if (!cell) {
        cell = [[PersonalDataCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"PersonalDataCell"];
       
    }
    NSArray *array = dataArray[indexPath.section];
    NSString *title_value = array[indexPath.row];
    cell.titleString = title_value;
    
    NSArray *val = valueArray[indexPath.section];
    NSString *value = val[indexPath.row];
    if (indexPath.section==0) {
        if (indexPath.row == 0) {
            cell.isArrowHiden = NO;
            cell.imageName = value;
        }else if (indexPath.row == 1) {
            cell.isArrowHiden = YES;
            cell.subtitleString = value;
        }else{
            cell.subtitleString = value;
            cell.isArrowHiden = NO;
        }
    }else if (indexPath.section == 1) {
        cell.subtitleString = value;
        cell.isArrowHiden = NO;
    }else{
        cell.subtitleString = @"";
        cell.isArrowHiden = YES;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row == 0) {
        return HeightRatio(124);
    }
    return HeightRatio(90);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeightRatio(20))];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return HeightRatio(20);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array = dataArray[indexPath.section];
    NSString *title_value = array[indexPath.row];
    if ([title_value isEqualToString:@"昵称"]) {
        ModifyNicknameVC *modify  = [[ModifyNicknameVC alloc]init];
        [modify setModifiedSuccessfulBlock:^(NSString * _Nonnull value) {
            PersonalDataCell *cell =(PersonalDataCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.subtitleString = value;
            [userInfoModel sharedUser].nickname = value;
        }];
        modify.type = @"昵称";
        [self.navigationController pushViewController:modify animated:YES];
    }else if ([title_value isEqualToString:@"年龄"]) {
        ModifyNicknameVC *modify  = [[ModifyNicknameVC alloc]init];
        [modify setModifiedSuccessfulBlock:^(NSString * _Nonnull value) {
            PersonalDataCell *cell =(PersonalDataCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.subtitleString = value;
            [userInfoModel sharedUser].member_age = value;
        }];
        modify.type = @"年龄";
        [self.navigationController pushViewController:modify animated:YES];
    }else if ([title_value isEqualToString:@"性别"]) {
        YYB_HF_SexChoiceView *view = [[YYB_HF_SexChoiceView alloc]initWithFrame:self.view.frame];
        view.sex = [userInfoModel sharedUser].member_sexName;
        view.selectSexBlock = ^(NSString * _Nonnull gender) {
            PersonalDataCell *cell =(PersonalDataCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.subtitleString = gender;
        };
        [view show];
    }else if ([title_value isEqualToString:@"头像"]){
        // !!!:头像设置
        YYB_HF_ModifyHeadIconVC *vc = [[YYB_HF_ModifyHeadIconVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
//        self.manager.configuration.saveSystemAblum = YES;
//        [self hx_presentAlbumListViewControllerWithManager:self.manager delegate:self];
    }else if ([title_value isEqualToString:@"实名认证"]){
        if ([userInfoModel sharedUser].rz_status.intValue == 0 || [userInfoModel sharedUser].rz_status.intValue == 3) {
            YYB_HF_WKWebVC *vc = [[YYB_HF_WKWebVC alloc]init];
            vc.urlString = SXF_WEB_URLl_Str(certification);
            vc.isTop = YES;
            vc.isNavigationHidden = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            [WXZTipView showCenterWithText:[userInfoModel sharedUser].rz_statusName];
            return;
            ReviewResultsVC *resul = [[ReviewResultsVC alloc]init];
            [self.navigationController pushViewController:resul animated:YES];
        }
        

//        IdentityInformationVC *ident = [[IdentityInformationVC alloc]init];
//        [self.navigationController pushViewController:ident animated:YES];
//        if ([[UserCache getUserXinXiCode]  isEqualToString:@"0"] || [[UserCache getUserXinXiCode] isEqualToString:@"3"] ) {
//            IdentityInformationVC *ident = [[IdentityInformationVC alloc]init];
//            [self.navigationController pushViewController:ident animated:YES];
//        }else{
//            ReviewResultsVC *re = [[ReviewResultsVC alloc]init];
//            [self.navigationController pushViewController:re animated:YES];
//        }
       
    }else if ([title_value isEqualToString:@"退出登录"]){
        
        
        [SXF_HF_AlertView showAlertType:AlertType_logout Complete:^(BOOL btnBype) {
            if (btnBype) {
                [[NSUserDefaults standardUserDefaults] setValue:nil forKey:USER_TOKEN];
                [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:LOGIN_STATES];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERINFO_DATA];
                [userInfoModel attempDealloc];
                [LoginVC login];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                [ShareSDK cancelAuthorize:(SSDKPlatformTypeQQ) result:^(NSError *error) {
                    
                }];
                [ShareSDK cancelAuthorize:(SSDKPlatformTypeWechat) result:^(NSError *error) {
                    
                }];
                [networkingManagerTool requestToServerWithType:POST withSubUrl:kLogout withParameters:nil withResultBlock:^(BOOL result, id value) {
                    [[WBPCreate sharedInstance]hideAnimated];
                    if (result) {
                        
                    }else {
                        if (value && [value isKindOfClass:[NSDictionary class]]) {
                        }else {
                        }
                    }
                }];
            }
        }];
        
        
        /*
        
        LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"温馨提示" message:@"您确定要退出登录吗？" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
            if(clickIndex == 1){
//                [[NSNotificationCenter defaultCenter] postNotificationName:EXIT_LOGIN object:nil userInfo:nil];
                [[NSUserDefaults standardUserDefaults] setValue:nil forKey:USER_TOKEN];
                [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:LOGIN_STATES];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERINFO_DATA];
                [userInfoModel attempDealloc];
                [LoginVC login];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                [ShareSDK cancelAuthorize:(SSDKPlatformTypeQQ) result:^(NSError *error) {
                    
                }];
                [ShareSDK cancelAuthorize:(SSDKPlatformTypeWechat) result:^(NSError *error) {
                    
                }];
                [networkingManagerTool requestToServerWithType:POST withSubUrl:kLogout withParameters:nil withResultBlock:^(BOOL result, id value) {
                    [[WBPCreate sharedInstance]hideAnimated];
                    if (result) {
                        
                    }else {
                        if (value && [value isKindOfClass:[NSDictionary class]]) {
                        }else {
                        }
                    }
                }];
               
            }
        }];
        alert.animationStyle=LXASAnimationTopShake;
        [alert showLXAlertView];
         
         */
    }
}
- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original {
    if (photoList.count > 0) {
        HXPhotoModel *model = photoList.firstObject;
        [self.permanage updateHeadImageView:model.previewPhoto];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        PersonalDataCell *cell =(PersonalDataCell *)[self.contentTableView cellForRowAtIndexPath:indexPath];
        cell.image = model.previewPhoto;
            //        signatureImage = model.previewPhoto;
        NSSLog(@"%lu张图片",(unsigned long)photoList.count);
    }else if (videoList.count > 0) {
        [self.toolManager getSelectedImageList:allList success:^(NSArray<UIImage *> *imageList) {
            [self.permanage updateHeadImageView:imageList.firstObject];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            PersonalDataCell *cell =(PersonalDataCell *)[self.contentTableView cellForRowAtIndexPath:indexPath];
            cell.image = imageList.firstObject;
        } failed:^{
            
        }];
        
    }
}

#pragma mark 懒加载
-(Per_MethodsToDealWithManage *)permanage{
    if (!_permanage) {
        _permanage = [Per_MethodsToDealWithManage sharedInstance];
        _permanage.superVC = self;
    }
    return _permanage;
}
-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                         style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
//        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = HEX_COLOR(0xf4f7f7);
        _contentTableView.bounces = NO;
//        _contentTableView.tableFooterView = [UIView new];
        _contentTableView.tableHeaderView = [UIView new];
    }
    return _contentTableView;
}
- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.configuration.singleSelected = YES;
        _manager.configuration.albumListTableView = ^(UITableView *tableView) {
            
        };
    }
    return _manager;
}

- (HXDatePhotoToolManager *)toolManager {
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
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
