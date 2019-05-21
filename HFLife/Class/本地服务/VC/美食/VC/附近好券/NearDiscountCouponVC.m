//
//  NearDiscountCouponVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/14.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "NearDiscountCouponVC.h"
#import "JXCategoryView.h"
#import "TFDropDownMenuView.h"
#import "NearDiscountCouponCell.h"
//#import "NearNetRequest.h"
#import "WKWebViewController.h"
//#import "NearNetRequest.h"
@interface NearDiscountCouponVC ()<JXCategoryViewDelegate,TFDropDownMenuViewDelegate,UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *data1;
    NSMutableArray *data2;
    //选择的哪列菜单
    NSArray *columnArray;
    /** 数据源*/
    NSArray *dataArray;
}
@property (nonatomic, strong)JXCategoryTitleView *myCategoryView;

/**
 下拉菜单
 */
@property (nonatomic, strong)TFDropDownMenuView *menu;
/** 容器TableView*/
@property (nonatomic,strong)UITableView *containerTableView;
@end

@implementation NearDiscountCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.title = @"附近好券";
//    [self wr_setNavBarBackgroundAlpha:0];
    [self initWithUI];
    
    [self setupNavBar];
    [self axcBaseRequestData];
}
-(void)axcBaseRequestData{
    NSString *city = [MMNSUserDefaults objectForKey:SelectedCity];
    if (![NSString isNOTNull:city]) {
        WS(weakSelf);
//        [[NearNetRequest sharedInstance]getNearGoodNotesDataParameter:@{@"city_name":city} successBlock:^(id  _Nonnull request) {
//            if ([request isKindOfClass:[NSArray class]]) {
//                self->dataArray = request;
//            }else{
//
//            }
//            [weakSelf.containerTableView reloadData];
//        }];
    }
    
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
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar setOnClickRightButton:^{
        NSLog(@"搜索");
    }];
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    // 设置导航栏显示图片
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"meishi_bg"];
    self.customNavBar.title = @"附近好券";
//    [self.customNavBar wr_setRightButtonWithImage:MMGetImage(@"NearFoodSousuo")];
}
-(void)initWithUI{
    UIImageView *topImageView = [UIImageView new];
    topImageView.image = MMGetImage(@"topFoodImage");
    topImageView.userInteractionEnabled = YES;
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(HeightRatio(75)+self.navBarHeight);
    }];
    
    JXCategoryTitleView *titleCategoryView = self.myCategoryView;
    _myCategoryView.titleColor = HEX_COLOR(0xcc9af1);
    _myCategoryView.titleSelectedColor = [UIColor whiteColor];
    titleCategoryView.titleColorGradientEnabled = YES;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineWidth = 20;
    lineView.indicatorLineViewColor = [UIColor whiteColor];
    lineView.lineStyle = JXCategoryIndicatorLineStyle_JD;
    titleCategoryView.indicators = @[lineView];
    
    [topImageView addSubview:self.myCategoryView];
    [self.myCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topImageView.mas_left).offset(WidthRatio(42));
        make.bottom.mas_equalTo(topImageView.mas_bottom);
        make.width.mas_equalTo(WidthRatio(250));
        make.height.mas_equalTo(HeightRatio(51));
    }];
    self.myCategoryView.delegate = self;
//    self.myCategoryView.titles = @[@"全部",@"5折好券"];
//    self.myCategoryView.contentScrollView = self.containerScrollView;
    // !!!: [self downMenuViewData];
    
    [self.view addSubview:self.containerTableView];
    [self.containerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
//        make.top.mas_equalTo(self.menu.mas_bottom);
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight);
    }];
}
//-(void)downMenuViewData{
//    NSArray *array1 = [NearNetRequest sharedInstance].areaTitleArray;
//    /**
//    NSArray *array2 = @[@"附近",@"金水区",@"中原区",@"二七区",@"管城回族区",@"新郑市",@"惠济区",@"上街区",@"登封市",@"荥阳市",@"新密市",@"巩义市",@"中牟县",@"高新区",@"近郊"];
//    NSArray *array2_1 = @[@[@"附近",@"1km",@"3km",@"5km",@"10km",@"全城"],
//                          @[@"全部",@"郑东新区CBD",@"金水区省政府",@"农科路酒吧",@"经三路沿线",@"天旺广场",@"省电视台",@"建文新世界",@"国贸360",@"东建材",@"科技市场/硅谷广场",@"曼哈顿广场",@"丰业广场/千盛广场",@"普罗旺/庙李",@"陈寨/张家村",@"熙地港/王府井",@"财院/轻工业学院"],
//                          @[@"全部",@"儿童公园/凯旋门",@"中原万达",@"锦艺城",@"帝湖",@"西元国际广场",@"华强城市广场",@"碧沙岗",@"裕达国贸",@"月季公园",@"郑州大学新校区"],
//                          @[@"全部",@"升龙广场",@"二七万达",@"火车站/二七广场",@"橄榄城",@"医学院",@"大商/升龙城",@"北京华联",@"长江中路沿线",@"郑铁体育中心",@"长城康桥华联",@"鑫苑都汇",@"万象城",@"长途客运总站",@"马寨镇",@"帝湖",@"大商金博大",@"亚星锦和广场"],
//                          @[@"全部",@"富田太阳城",@"大上海城",@"郑州东站",@"经开区",@"康桥商务广场",@"新世界百货",@"福都生活广场",@"美景鸿城",@"人民路百盛",@"橡树玫瑰城",@"五洲公园",@"南三环汽配大世界"],
//                          @[@"全部",@"炎黄广场",@"华南城/高坡岩",@"新村镇",@"新区/华信学院",@"西亚斯",@"龙湖广场/升达广场",@"河南工程学院",@"庆都生活广场",@"新郑金苑小区",@"航空港区",@"轩辕故里",@"新秀城",@"新郑机场",@"人民路",@"只能手机产业园"],
//                          @[@"全部",@"北大学城",@"裕华广场/省体育中心",@"黄河游览区"],
//                          @[@"全部",@"合昌都会广场",@"欧凯龙城市广场",@"孟津路",@"甘峡线"],
//                          @[@"全部",@"百货大楼/中天广场",@"客运总站",@"嵩阳总站",@"少林寺风景区",@"登封一中（国际商贸城）",@"嵩山一号"],
//                          @[@"全部",@"荥阳汽车站",@"海龙时代广场",@"建业购物广场",@"荥阳站",@"荥阳植物园",@"奥帕拉拉水公园",@"荥阳市人民医院"],
//                          @[@"全部",@"五四广场/万客隆",@"青屏广场",@"静谧高级中学",@"行政服务中心",@"秦水桥",@"市人民医院",@"郑煤集团总医院",@"客运总站",@"市博物馆",@"迎客松购物广场"],
//                          @[@"全部",@"星月时代广场",@"巩义东区",@"宋陵公园",@"体育馆",@"回郭镇",@"成功学院",@"丹尼斯商场",@"汽车站",@"火车站"],
//                          @[@"全部",@"刘集镇",@"县政府",@"【沃金/山顶富都】",@"新世纪广场",@"白沙镇",@"世纪城",@"杉杉奥特莱斯",@"九龙镇",@"百乐汇购物广场",@"锦荣悦汇城",@"水岸鑫城",@"祥瑞中心花园",@"中牟大厦",@"人民医院",@"潘安公园",@"雁鸣湖镇"],
//                          @[],
//                          @[]];
//     */
//    NSArray *array3 = @[@"智能排序",@"离我最近",@"好评优先",@"人气最高"];
//
//    data1 = [NSMutableArray arrayWithObjects:array1, array3,nil];
//    data2 = [NSMutableArray arrayWithObjects:@[], @[], nil];
//    TFDropDownMenuView *menu = [[TFDropDownMenuView alloc] initWithFrame:CGRectMake(0, HeightRatio(75)+self.navBarHeight, SCREEN_WIDTH, HeightRatio(91)) firstArray:data1 secondArray:data2];
//    menu.delegate = self;
//    menu.cellSelectBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
//    menu.itemTextSelectColor = HEX_COLOR(0xb22fe4);
//    menu.cellTextSelectColor = HEX_COLOR(0xb22fe4);
//    menu.ratioLeftToScreen = 0.35;
//    menu.itemFontSize = WidthRatio(26);
//    menu.separatorColor = [UIColor clearColor];
//    [self.view addSubview:menu];
//
////    NSMutableArray *detail1 =  [NSMutableArray arrayWithObjects:@"14881",@"2", @"211", @"939",@"2914",@"1983",@"2505",@"251",@"5857",@"2530",@"317",@"1622",@"878",@"17",@"569",@"1023",@"551",@"69",@"128",@"405",@"131", @"331",@"140",@"9",@"864",nil];
//    menu.firstRightArray = [NSMutableArray arrayWithObjects:@[], nil];
//
//    /*风格*/
//    menu.menuStyleArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:TFDropDownMenuStyleTableView], [NSNumber numberWithInteger:TFDropDownMenuStyleTableView], [NSNumber numberWithInteger:TFDropDownMenuStyleTableView], [NSNumber numberWithInteger:TFDropDownMenuStyleCustom], nil];
//
//    /*自定义视图*/
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
//    label.text = @"我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图";
//    label.numberOfLines = 0;
//    label.backgroundColor = [UIColor yellowColor];
//        //    label.backgroundColor = [UIColor whiteColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor orangeColor];
//
//    menu.customViews = [NSMutableArray arrayWithObjects:[NSNull null], [NSNull null], [NSNull null], label, nil];
//    self.menu = menu;
//}
#pragma mark UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NearDiscountCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NearDiscountCouponCell"];
    if (!cell) {
        cell = [[NearDiscountCouponCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"NearDiscountCouponCell"];
    }
    NSDictionary *dict = dataArray[indexPath.section];
    cell.money = MMNSStringFormat(@"¥%@",dict[@"price"]) ;
    cell.title = [NSString judgeNullReturnString:dict[@"food_name"]];
    cell.evaluatePrice = [NSString stringWithFormat:@"%@分 | %@",dict[@"star_num"],dict[@"cate_name"]];//@"3.8分 | ¥61/人 | 烤鱼";
    cell.voucher = [NSString judgeNullReturnString:dict[@"coupon_name"]];
    cell.distance = [NSString judgeNullReturnString:dict[@"distance"]];
    cell.fan_price = MMNSStringFormat(@"%@",dict[@"fan_price"]);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRatio(163);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
 //设置区尾
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, section == 0?HeightRatio(30):HeightRatio(25))];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0?HeightRatio(30):HeightRatio(25);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = dataArray[indexPath.section];
    WKWebViewController *wkWebView = [[WKWebViewController alloc]init];
//    NSString *city = [MMNSUserDefaults objectForKey:selectedCity];
//    NSString *coupon_id = MMNSStringFormat(@"%@",dict[@"coupon_id"]);
//    wkWebView.fileName = @"discountDetail";
//    wkWebView.jointParameter = MMNSStringFormat(@"?coupon_id=%@&city_name=%@",coupon_id,city);
    wkWebView.urlString = [NSString judgeNullReturnString:dict[@"url"]];
    [self.navigationController pushViewController:wkWebView animated:YES];
}

#pragma mark 下拉菜单
- (void)menuView:(TFDropDownMenuView *)menu selectIndex:(TFIndexPatch *)index {
        //    下拉菜单被点击
    NSLog(@"index: %@", index);
    if (index.section < columnArray.count&&([columnArray isKindOfClass:[NSArray class]])) {
        NSArray *data = columnArray[index.section];
        if (([data isKindOfClass:[NSArray class]])&&(index.row < data.count)) {
            NSLog(@"选择的是%@",data[index.row]);
        }else{
            NSString *str = (NSString *)data;
            NSLog(@"选择的是%@",str);
        }
    }
}
- (void)menuView:(TFDropDownMenuView *)menu tfColumn:(NSInteger)column{
        //菜单被点击
      NSLog(@"column: %ld", column);
    columnArray = data2[column];
    if (columnArray.count == 0 || [columnArray isKindOfClass:[NSArray class]]) {
        columnArray = data1[column];
    }
}
#pragma mark JXCategoryViewDelegate 滑动菜单代理
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    NSArray *titleArray = @[@"全部",@"5折好券"];
    NSLog(@"titleArray = %@",titleArray[index]);
}
#pragma mark 懒加载
- (JXCategoryTitleView *)myCategoryView {
    if (_myCategoryView == nil) {
        _myCategoryView = [[[JXCategoryTitleView class] alloc] init];
        _myCategoryView.delegate = self;
    }
    return _myCategoryView;
}
- (UITableView *)containerTableView{
    if (_containerTableView == nil) {
        _containerTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                           style:UITableViewStylePlain];
        _containerTableView.delegate = self;
        _containerTableView.dataSource = self;
        _containerTableView.backgroundColor = HEX_COLOR(0xf5f8f8);
        _containerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _containerTableView.backgroundColor = HEX_COLOR(0xffffff);
//        _containerTableView.tableFooterView = [UIView new];
//        _containerTableView.tableHeaderView = [UIView new];
    }
    return _containerTableView;
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
