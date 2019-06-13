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
        NSString *msg = @"1.您将不再享有汉富新生活的专属会员权益（包括但不限于付费会员权益、生态会员权益等）；\n2.您将再也无法对此账号进行登录、忘记密码操作；\n3.您账户的个人资料及历史信息将无法找回；\n4.您账户中如果存在与会员相关的其他权益未使用，注销后将不能再使用；\n5.您的汉富智新生活能终端产品在使用时，需重新注册汉富账号并重新设置，原账号内的数据信息不会进行移转或继承；\n6.除法律法规要求必须保存的信息以外，您的用户信息我们将予以删除。您账户下所有行为信息记录，您将无法找回；\n7.注销本账户并不代表本账户注销前的账户行为和相关责任得到豁免或减轻。";
        
        msg = @"您在申请注销流程中点击同意前，应当认真阅读《帐号注销协议》（以下简称“本协议”）。特别提醒您，当您成功提交注销申请后，即表示您已充分阅读、理解并接受本协议的全部内容。阅读本协议的过程中，如果您不同意相关任何条款，请您立即停止帐号注销程序。如您对本协议有任何疑问，可通过客服专区联系我们的客服。\n1. 如果您仍欲继续注销帐号，您的帐号需同时满足以下条件：\n（1）帐号不在处罚状态中，且能正常登录；\n（2）帐号最近一个月内并无修改密码、修改关联手机、绑定手机记录。\n2.您应确保您有权决定该帐号的注销事宜，不侵犯任何第三方的合法权益，如因此引发任何争议，由您自行承担。\n3.您理解并同意，账号注销后我们无法协助您重新恢复前述服务。请您在申请注销前自行备份您欲保留的本帐号信息和数据。\n4.帐号注销后，已绑定的手机号、邮箱将会被解除绑定。\n5.注销帐号后，您将无法再使用本帐号，也将无法找回您帐号中及与帐号相关的任何内容或信息，包括但不限于：\n（1）您将无法继续使用该帐号进行登录；\n（2）您帐号的个人资料和历史信息（包含昵称、头像、消息记录等）都将无法找回；\n（3）您理解并同意，注销帐号后，您曾获得的充值余额、游戏道具、礼品券及其他虚拟财产等将视为您自愿、主动放弃，无法继续使用，由此引起一切纠纷由您自行处理，我们不承担任何责任。\n6.在帐号注销期间，如果您的帐号被他人投诉、被国家机关调查或者正处于诉讼、仲裁程序中，我们有权自行终止您的帐号注销程序，而无需另行得到您的同意。\n7.请注意，注销您的帐号并不代表本帐号注销前的帐号行为和相关责任得到豁免或减轻。";
        
        SXF_HF_AlertView *alert = [SXF_HF_AlertView showAlertType:AlertType_cancellation Complete:^(BOOL btnBype) {
            if (btnBype) {
                if ([userInfoModel sharedUser].ID && [userInfoModel sharedUser].ID > 0) {
                    YYB_HF_destroyAccountVC *vc = [[YYB_HF_destroyAccountVC alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                }else {
                    [WXZTipView showCenterWithText:@"用户信息未获取成功"];
                }
            }
        }];
        alert.msg = msg;
        
    }else if ([value isEqualToString:@"关联账号"]){
        if ([userInfoModel sharedUser].ID && [userInfoModel sharedUser].ID > 0) {
            [self.navigationController pushViewController:[NSClassFromString(@"SXF_HF_bindingAccount") new] animated:YES];
        }else {
            [WXZTipView showCenterWithText:@"用户信息未获取成功"];
        }
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
