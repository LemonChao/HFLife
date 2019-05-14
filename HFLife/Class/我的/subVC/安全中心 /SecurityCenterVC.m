//
//  SecurityCenterVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/21.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "SecurityCenterVC.h"
#import "PersonalDataCell.h"
#import "SetLoginPassword.h"
#import "ReviseMobilePhone.h"
#import "ConfirmInformationVC.h"
#import "IdentityInformationVC.h"
#import "ReviewResultsVC.h"
//#import "ForgotPasswordVC.h"
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
    titleArray = @[@"设置登录密码",@"设置交易密码",@"修改手机号"];
    valueArray = @[[UserCache getUserPasswordStatus] ? @"去修改" : @"去设置",[UserCache getUserTradePassword]?@"去修改":@"待设置",[NSString isNOTNull:[UserCache getUserPhone]] ?@"待设置":@"去修改" ];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithUI];
    [self setupNavBar];
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
//    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"安全中心";
    self.customNavBar.backgroundColor = RGBA(136, 53, 230, 1);//[UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    
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
    return titleArray.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalDataCell"];
    if (!cell) {
        cell = [[PersonalDataCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"PersonalDataCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleString = titleArray[indexPath.row];
    cell.subtitleString = valueArray[indexPath.row];
    cell.isArrowHiden = NO;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRatio(96);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *value = titleArray[indexPath.row];
    if ([value isEqualToString:@"设置登录密码"]) {
        if (![UserCache getUserPasswordStatus]) {
            //            LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"温馨提示" message:@"您还没有设置登录密码，暂无法进行入驻，是否进行密码设置？" cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
            //                if(clickIndex == 1){
            
            
            
            
            
            /*
            ForgotPasswordVC *rev = [[ForgotPasswordVC alloc]init];
            rev.isSetPas = YES;
            [self.navigationController pushViewController:rev animated:YES];
            
            */
            
            
            
            
            
            //                }
            //            }];
            //            alert.animationStyle=LXASAnimationTopShake;
            //            [alert showLXAlertView];
            return;
        }
        [self.navigationController pushViewController:[[SetLoginPassword alloc]init] animated:YES];
    }else if ([value isEqualToString:@"修改手机号"]){
        [self.navigationController pushViewController:[[ReviseMobilePhone alloc]init] animated:YES];
    }else if ([value isEqualToString:@"设置交易密码"]){
        if ([[UserCache getUserXinXiTitle] isEqualToString:@"已认证"]) {
            [self.navigationController pushViewController:[[ConfirmInformationVC alloc]init] animated:YES];
        }else{
            LXAlertView *alert=[[LXAlertView alloc] initWithTitle:@"温馨提示" message:MMNSStringFormat(@"您的身份信息%@,暂时无法进行交易密码的修改",[UserCache getUserXinXiTitle]) cancelBtnTitle:@"取消" otherBtnTitle:@"确定" clickIndexBlock:^(NSInteger clickIndex) {
                if(clickIndex == 1){
                    if ([[UserCache getUserXinXiCode]  isEqualToString:@"0"] || [[UserCache getUserXinXiCode] isEqualToString:@"3"] ) {
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
