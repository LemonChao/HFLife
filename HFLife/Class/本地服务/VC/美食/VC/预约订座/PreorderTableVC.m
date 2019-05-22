//
//  PreorderTableVC.m
//  HanPay
//
//  Created by zchao on 2019/2/22.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "PreorderTableVC.h"
#import "PreorderTableCell.h"
#import "ConfigOrderInfoVC.h"
//#import "NearNetRequest.h"
//#import "HP_PreordeSreatNetApi.h"
#import "SubscribeSubmitVC.h"
#import "WKWebViewController.h"
@interface PreorderTableVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *infoButton;
//    HP_PreordeSreatNetApi *preorde;
    NSMutableArray *dataArray;
//    ListRequestDataType type;
    NSDictionary *reservationDict;
    
}
@property(nonatomic, strong) UITableView *tableview;

@end

static NSString *cellid = @"PreorderTableCell_id";

@implementation PreorderTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    type = ListDropdownRefreshType;
    dataArray = [NSMutableArray array];
    [self configViews];
    [self axcBaseRequestData];
}

- (void)configViews {
    [self setupHeader];
}
-(void)axcBaseRequestData{
    NSString *city = [MMNSUserDefaults objectForKey:SelectedCity];
    WS(weakSelf);
//    if ([JFLocationSingleton sharedInstance].locationArray.count>0) {
//        CLLocation *newLocation = [[JFLocationSingleton sharedInstance].locationArray lastObject];
//        CLLocationCoordinate2D gaocoor;
//        gaocoor.latitude = newLocation.coordinate.latitude;
//        gaocoor.longitude = newLocation.coordinate.longitude;
//
//        CLLocationCoordinate2D coor = [JZLocationConverter gcj02ToBd09:gaocoor];
//        NSDictionary *dict = @{@"city_name":city,
//                               @"lat":MMNSStringFormat(@"%f",coor.latitude),
//                               @"lng":MMNSStringFormat(@"%f",coor.longitude),
//                               };
//        [self getHotPotDataParameter:dict ListRequestDataType:(type) successBlock:^(id  _Nonnull request) {
//            [weakSelf.tableview endLoadMore];
//            [weakSelf.tableview endRefreshing];
//            if ([request isKindOfClass:[NSArray class]]) {
//                [self->dataArray addObjectsFromArray:request];
//                [weakSelf.tableview reloadData];
//                NSArray *ara = (NSArray *)request;
//                if (ara.count < 10) {
//                    [weakSelf.tableview  setLoadMoreViewHidden:YES];
//                }
//            }else{
//                [weakSelf.tableview reloadData];
//                [weakSelf.tableview  setLoadMoreViewHidden:YES];
//            }
//
//        }];
//    }else{
//        [weakSelf.tableview endLoadMore];
//    }
}
- (void)setupHeader {
    UIImageView *headImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"preorder_headerbg"]];
    headImgView.contentMode = UIViewContentModeScaleAspectFill;
    headImgView.userInteractionEnabled = YES;
    [self.view addSubview:headImgView];
    [headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(170+statusBarHeight-20);

    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headImgView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImgView).offset(HeightStatus);
        make.left.equalTo(headImgView);
        make.size.mas_equalTo(CGSizeMake(50, 44));
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:21];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"在线订座";
    [headImgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headImgView);
        make.top.equalTo(backButton.mas_bottom).offset(10);
    }];
    
    UILabel *desLabel = [UILabel new];
    desLabel.font = [UIFont systemFontOfSize:15];
    desLabel.textColor = [UIColor whiteColor];
    desLabel.text = @"让你尊享VIP待遇";
    [headImgView addSubview:desLabel];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headImgView);
        make.top.equalTo(titleLabel.mas_bottom).offset(15);
    }];

    UIImageView *infoBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"preorder_infoBg"]];
    infoBg.userInteractionEnabled = YES;
    [headImgView addSubview:infoBg];
    [infoBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(desLabel.mas_bottom).offset(7);
        make.left.equalTo(headImgView).offset(6);
        make.right.equalTo(headImgView).offset(-6);
        make.height.mas_equalTo(HeightRatio(124));
    }];
    
    UILabel *infoLabel = [UILabel new];
    infoLabel.font = [UIFont systemFontOfSize:16];
    infoLabel.textColor = HEX_COLOR(0x666666);
    infoLabel.text = @"预定信息：";
    [infoBg addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoBg).offset(WidthRatio(38));
        NSLog(@"width:%lf", WidthRatio(20));
        make.centerY.equalTo(infoBg);
    }];
    
    infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoButton setTitle:@"" forState:UIControlStateNormal];
    [infoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [infoButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [infoButton setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
    [infoButton setContentCompressionResistancePriority:249 forAxis:UILayoutConstraintAxisHorizontal];
    [infoButton addTarget:self action:@selector(infoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    infoButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [infoBg addSubview:infoButton];
    [infoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoLabel.mas_right).offset(0);
        make.right.equalTo(infoBg).offset(-WidthRatio(20));
        make.top.equalTo(infoBg);
        make.bottom.equalTo(infoBg);
    }];

    UIView *filterView = [UIView new];
    filterView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:filterView];
    [filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoBg.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(55);
    }];
    
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(filterView);
//        make.top.equalTo(filterView.mas_bottom);
        make.top.equalTo(infoBg.mas_bottom);
        
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view.mas_bottom);
        }
    }];
    
}

- (void)infoButtonAction:(UIButton *)button {
    ConfigOrderInfoVC *orderInfoVC = [[ConfigOrderInfoVC alloc] init];
    [orderInfoVC setSelectBlock:^(NSDictionary * _Nonnull dict) {
        NSString *site = [dict[@"appoint_site"] isEqualToString:@"1"]?@"大厅":@"包间";
        NSString *str = MMNSStringFormat(@"%@ %@ %@ %@",dict[@"appoint_num"],dict[@"appoint_date"],dict[@"appoint_time"],site);
        self->reservationDict = dict;
        [self->infoButton setTitle:str forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:orderInfoVC animated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)backButtonAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
//    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PreorderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.dataDict = dataArray[indexPath.row];
    [cell setReservationBlock:^(NSDictionary * _Nonnull dict) {
        if ([NSString isNOTNull:self->infoButton.titleLabel.text]) {
            [WXZTipView showCenterWithText:@"请选择预定信息"];
            return;
        }
        SubscribeSubmitVC *sub = [[SubscribeSubmitVC alloc]init];
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        [data setDictionary:self->reservationDict];
        [data setObject:dict[@"shop_id"] forKey:@"shop_id"];
        sub.dataDict = data;
        [self.navigationController pushViewController:sub animated:YES];
    }];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = dataArray[indexPath.row];
    WKWebViewController *wkWebView = [[WKWebViewController alloc]init];
    wkWebView.isNavigationHidden = YES;
    wkWebView.urlString = [NSString judgeNullReturnString:dict[@"url"]];
    [self.navigationController pushViewController:wkWebView animated:YES];
}







- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.tableFooterView = [UIView new];
        [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([PreorderTableCell class]) bundle:nil] forCellReuseIdentifier:cellid];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _tableview;
}
//-(void)getHotPotDataParameter:(NSDictionary *)parameter ListRequestDataType:(ListRequestDataType)type successBlock:(SuccessBlock)successBlock{
//    if (!preorde) {
//        preorde  = [[HP_PreordeSreatNetApi alloc] initWithParameter:parameter];
//    }
//    preorde.requestDataType = type;
//    [preorde startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        HP_PreordeSreatNetApi *classifyRequest = (HP_PreordeSreatNetApi *)request;
//        if ([classifyRequest getCodeStatus] == 1) {
//            NSArray *array = [classifyRequest getContent];
//            successBlock(array);
//        }else{
//            [WXZTipView showCenterWithText:@"数据获取失败"];
//            successBlock(@(NO));
//        }
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [WXZTipView showCenterWithText:@"数据获取失败"];
//        successBlock(@(NO));
//    }];
//}

@end
