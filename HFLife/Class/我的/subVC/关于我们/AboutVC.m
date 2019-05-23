//
//  AboutVC.m
//  HanPay
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "AboutVC.h"
#import "PersonalDataCell.h"
#import "ServiceAgreementVC.h"
@interface AboutVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *titleArray;
}
@property (nonatomic,strong)UITableView *contentTableView;
@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEX_COLOR(0xf4f7f7);
    titleArray = @[@"版本说明",@"服务协议"];
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
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"关于汉富";
}
-(void)initWithUI{
    UIImageView *imageView = [UIImageView new];
    imageView.image = MMGetImage(@"logo");
    imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imageView];
    MMViewBorderRadius(imageView, WidthRatio(10), 0, [UIColor clearColor]);
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight+HeightRatio(90));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(WidthRatio(150));
    }];
    UILabel *appLabel = [UILabel new];
    appLabel.numberOfLines = 0;
        // app版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    CFShow((__bridge CFTypeRef)(infoDictionary));
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    appLabel.text = MMNSStringFormat(@"汉富V%@",app_Version);
    appLabel.textAlignment =  NSTextAlignmentCenter;
    appLabel.font = [UIFont systemFontOfSize:WidthRatio(25)];
    appLabel.textColor = HEX_COLOR(0xBCBCBC);
    [self.view addSubview:appLabel];
    [appLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
        make.top.mas_equalTo(imageView.mas_bottom).offset(HeightRatio(42));
    }];
    [self.view addSubview:self.contentTableView];
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(appLabel.mas_bottom).offset(HeightRatio(78));
    }];
    
    
    UILabel *titleLabel =[UILabel new];
    titleLabel.text = @"汉富商业发展有限公司";
    titleLabel.textColor = HEX_COLOR(0x999999);
    titleLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-HeightRatio(126));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel *titleLabel1 =[UILabel new];
    titleLabel1.text = @"Hanfu Business Development Co., Ltd";
    titleLabel1.textColor = HEX_COLOR(0xa6a6a6);
    titleLabel1.font = [UIFont systemFontOfSize:WidthRatio(24)];
    [self.view addSubview:titleLabel1];
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(HeightRatio(27));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
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
    cell.isArrowHiden = NO;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRatio(96);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *htmlPath;
    NSString *title = @"";
    if (indexPath.row ==1) {
        htmlPath = [[NSBundle mainBundle] pathForResource:@"service" ofType:@"html" inDirectory:@"服务协议html"];
        title = @"服务协议";
    }else{
        htmlPath = [[NSBundle mainBundle] pathForResource:@"version" ofType:@"html" inDirectory:@"version"];
        title = @"版本说明";
    }
    ServiceAgreementVC *serv = [[ServiceAgreementVC alloc]init];
    serv.htmlPath = htmlPath;
    serv.title = title;
    serv.row = indexPath.row;
    [self.navigationController pushViewController:serv animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
