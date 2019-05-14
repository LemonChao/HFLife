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
    dataArray = @[@[@"头像",@"昵称",@"用户名",@"实名认证",@"手机号码"],@[@"退出登录"]];
    valueArray = @[@[[UserCache getUserPic],[UserCache getUserNickName],[UserCache getUserName],[UserCache getUserXinXiTitle],[NSString isNOTNull:[UserCache getUserPhone]] ? @"" : [[UserCache getUserPhone] EncodeTel]],@[@""]];
    [self initWithUI];
    [self setupNavBar];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.permanage getPersonalData:^(id request) {
        if ([request boolValue]) {
            self->valueArray = @[@[[UserCache getUserPic],[UserCache getUserNickName],[UserCache getUserName],[UserCache getUserXinXiTitle],[NSString isNOTNull:[UserCache getUserPhone]] ? @"" : [[UserCache getUserPhone] EncodeTel]],@[@""]];
            [self.contentTableView reloadData];
        }
    }];
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
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    self.customNavBar.backgroundColor = RGBA(136, 53, 230, 1);
}
-(void)initWithUI{
    [self.view addSubview:self.contentTableView];
    [self.contentTableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight);
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
            cell.imageName = value;
        }else if (indexPath.row == 2) {
            cell.isArrowHiden = YES;
            cell.subtitleString = value;
        }else{
            cell.subtitleString = value;
            cell.isArrowHiden = NO;
        }
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
        }];
        [self.navigationController pushViewController:modify animated:YES];
    }else if ([title_value isEqualToString:@"头像"]){
        self.manager.configuration.saveSystemAblum = YES;
        [self hx_presentAlbumListViewControllerWithManager:self.manager delegate:self];
    }else if ([title_value isEqualToString:@"实名认证"]){
//        IdentityInformationVC *ident = [[IdentityInformationVC alloc]init];
//        [self.navigationController pushViewController:ident animated:YES];
        if ([[UserCache getUserXinXiCode]  isEqualToString:@"0"] || [[UserCache getUserXinXiCode] isEqualToString:@"3"] ) {
            IdentityInformationVC *ident = [[IdentityInformationVC alloc]init];
            [self.navigationController pushViewController:ident animated:YES];
        }else{
            ReviewResultsVC *re = [[ReviewResultsVC alloc]init];
            [self.navigationController pushViewController:re animated:YES];
        }
       
    }else if ([title_value isEqualToString:@"退出登录"]){
        LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"温馨提示" message:@"您确定要退出登录吗？" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
            if(clickIndex == 1){
                [[NSNotificationCenter defaultCenter] postNotificationName:EXIT_LOGIN object:nil userInfo:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
                [ShareSDK cancelAuthorize:(SSDKPlatformTypeQQ) result:^(NSError *error) {
                    
                }];
                [ShareSDK cancelAuthorize:(SSDKPlatformTypeWechat) result:^(NSError *error) {
                    
                }];
            }
        }];
        alert.animationStyle=LXASAnimationTopShake;
        [alert showLXAlertView];
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
