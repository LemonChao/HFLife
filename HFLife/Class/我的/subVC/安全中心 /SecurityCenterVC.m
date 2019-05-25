//
//  SecurityCenterVC.m
//  HanPay
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "SecurityCenterVC.h"
#import "PersonalDataCell.h"
#import "SetLoginPassword.h"
#import "ReviseMobilePhone.h"
#import "ConfirmInformationVC.h"
#import "IdentityInformationVC.h"
#import "ReviewResultsVC.h"
#import "ForgotPasswordVC.h"
#import "YYB_HF_setDealPassWordVC.h"//交易密码
#import "YYB_HF_destroyAccountVC.h"//注销
@interface SecurityCenterVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titleArray;
    NSArray *valueArray;
}
@property (nonatomic,strong)UITableView *contentTableView;
@end

@implementation SecurityCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    titleArray = @[@[@"关联账号",@"修改交易密码"],@[@"注销账号",@"切换账号"]];
    
    self.customNavBar.title = @"安全中心";
//    valueArray = @[[UserCache getUserPasswordStatus] ? @"去修改" : @"去设置",[UserCache getUserTradePassword]?@"去修改":@"待设置",[NSString isNOTNull:[UserCache getUserPhone]] ?@"待设置":@"去修改" ];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithUI];
    [self setupNavBar];
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
    NSArray *subArr = titleArray[section];
    return subArr.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalDataCell"];
    if (!cell) {
        cell = [[PersonalDataCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"PersonalDataCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleString = titleArray[indexPath.section][indexPath.row];
    cell.subtitleString = valueArray[indexPath.section][indexPath.row];
    cell.isArrowHiden = NO;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRatio(96);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return ScreenScale(8);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8)];
    view.backgroundColor = HEX_COLOR(0xF5F5F5);
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *value = titleArray[indexPath.section][indexPath.row];
    if ([value isEqualToString:@"设置交易密码"]){
        if ([[userInfoModel sharedUser].rz_status integerValue] == 1) {
            [self.navigationController pushViewController:[[ConfirmInformationVC alloc]init] animated:YES];
        }else{
            LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"温馨提示" message:MMNSStringFormat(@"您的身份信息%@,暂时无法进行交易密码的修改",[userInfoModel sharedUser].rz_statusName) cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
                if(clickIndex == 1){
                    if ([[userInfoModel sharedUser].rz_status integerValue]  == 0 || [[userInfoModel sharedUser].rz_status integerValue]  == 3) {
                        IdentityInformationVC *ident = [[IdentityInformationVC alloc]init];
                        [self.navigationController pushViewController:ident animated:YES];
                    }else{
                        ReviewResultsVC *re = [[ReviewResultsVC alloc]init];
                        [self.navigationController pushViewController:re animated:YES];
                    }
                }
            }];
            alert.animationStyle=LXASAnimationTopShake;
            [alert showLXAlertView];
        }        
    }else if ([value isEqualToString:@"修改交易密码"]){
        YYB_HF_setDealPassWordVC *vc = [[YYB_HF_setDealPassWordVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([value isEqualToString:@"注销账号"]){
        
        [[WBPCreate sharedInstance]showWBProgress];
        [networkingManagerTool requestToServerWithType:POST withSubUrl:kGetCloseAgreement withParameters:nil withResultBlock:^(BOOL result, id value) {
            [[WBPCreate sharedInstance]hideAnimated];
            if (result) {
                
                NSString *msg = @"";
                if (value && [value isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dataDic = value[@"data"];
                    
                    NSString *app_close_agreementStr = [dataDic safeObjectForKey:@"app_close_agreement"];
                    if (app_close_agreementStr && [app_close_agreementStr isKindOfClass:[NSString class]] && app_close_agreementStr.length > 0) {
                        msg = app_close_agreementStr;
                    }
                }
                SXF_HF_AlertView *alert = [SXF_HF_AlertView showAlertType:AlertType_cancellation Complete:^(BOOL btnBype) {
                    if (btnBype) {
                        YYB_HF_destroyAccountVC *vc = [[YYB_HF_destroyAccountVC alloc]init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }];
                alert.msg = msg;
            }else {
                if (value && [value isKindOfClass:[NSDictionary class]]) {
                    [WXZTipView showCenterWithText:value[@"msg"]];
                }else {
                    [WXZTipView showCenterWithText:@"网络错误"];
                }
            }
        }];

        
    }else if ([value isEqualToString:@"关联账号"]){
        [self.navigationController pushViewController:[NSClassFromString(@"SXF_HF_bindingAccount") new] animated:YES];
    }else if ([value isEqualToString:@"切换账号"]){
        [self.navigationController pushViewController:[NSClassFromString(@"YYB_HF_changeAccountVC") new] animated:YES];
    }
}
#pragma mark 懒加载
-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                         style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        //        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.bounces = NO;
        _contentTableView.tableFooterView = [UIView new];
        _contentTableView.tableHeaderView = [UIView new];
    }
    return _contentTableView;
}
@end
