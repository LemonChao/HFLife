//
//  NearFoodListVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/14.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "NearFoodListVC.h"
#import "TFDropDownMenuView.h"
#import "NearFoodListCell.h"
@interface NearFoodListVC ()<TFDropDownMenuViewDelegate,UITableViewDelegate, UITableViewDataSource>
/** 容器TableView*/
@property (nonatomic,strong)UITableView *containerTableView;
@end

@implementation NearFoodListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MMRandomColor;
    [self initWithUI];
}
-(void)initWithUI{
    [self downMenuViewData];
    UILabel *lin = [UILabel new];
    lin.backgroundColor = HEX_COLOR(0x656565);
    [self.view addSubview:lin];
    lin.frame = CGRectMake(0, HeightRatio(91), SCREEN_WIDTH, HeightRatio(1));
    [self.view addSubview:self.containerTableView];
    [self.containerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(HeightRatio(91));
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offy = scrollView.contentOffset.y;
    if (offy <=0) {
        self.containerTableView.bounces = NO;
    }else{
        self.containerTableView.bounces = YES;
    }
}
-(void)downMenuViewData{
    NSArray *array1 = @[@"全部美食",@"福建菜",@"日本菜",@"饮品店",@"面包甜点",@"生日蛋糕",@"火锅",@"自助餐",@"小吃快餐",@"其他美食",@"日韩料理",@"聚餐宴请",@"西餐",@"大闸蟹",@"烧烤烤肉",@"川湘菜",@"香锅烤鱼",@"小龙虾",@"江浙菜",@"中式烧烤/烤串",@"粤菜",@"咖啡酒吧",@"西北菜",@"徽菜",@"豫菜"];
    NSArray *array2 = @[@"附近",@"金水区",@"中原区",@"二七区",@"管城回族区",@"新郑市",@"惠济区",@"上街区",@"登封市",@"荥阳市",@"新密市",@"巩义市",@"中牟县",@"高新区",@"近郊"];
    NSArray *array2_1 = @[@[@"附近",@"1km",@"3km",@"5km",@"10km",@"全城"],
                          @[@"全部",@"郑东新区CBD",@"金水区省政府",@"农科路酒吧",@"经三路沿线",@"天旺广场",@"省电视台",@"建文新世界",@"国贸360",@"东建材",@"科技市场/硅谷广场",@"曼哈顿广场",@"丰业广场/千盛广场",@"普罗旺/庙李",@"陈寨/张家村",@"熙地港/王府井",@"财院/轻工业学院"],
                          @[@"全部",@"儿童公园/凯旋门",@"中原万达",@"锦艺城",@"帝湖",@"西元国际广场",@"华强城市广场",@"碧沙岗",@"裕达国贸",@"月季公园",@"郑州大学新校区"],
                          @[@"全部",@"升龙广场",@"二七万达",@"火车站/二七广场",@"橄榄城",@"医学院",@"大商/升龙城",@"北京华联",@"长江中路沿线",@"郑铁体育中心",@"长城康桥华联",@"鑫苑都汇",@"万象城",@"长途客运总站",@"马寨镇",@"帝湖",@"大商金博大",@"亚星锦和广场"],
                          @[@"全部",@"富田太阳城",@"大上海城",@"郑州东站",@"经开区",@"康桥商务广场",@"新世界百货",@"福都生活广场",@"美景鸿城",@"人民路百盛",@"橡树玫瑰城",@"五洲公园",@"南三环汽配大世界"],
                          @[@"全部",@"炎黄广场",@"华南城/高坡岩",@"新村镇",@"新区/华信学院",@"西亚斯",@"龙湖广场/升达广场",@"河南工程学院",@"庆都生活广场",@"新郑金苑小区",@"航空港区",@"轩辕故里",@"新秀城",@"新郑机场",@"人民路",@"只能手机产业园"],
                          @[@"全部",@"北大学城",@"裕华广场/省体育中心",@"黄河游览区"],
                          @[@"全部",@"合昌都会广场",@"欧凯龙城市广场",@"孟津路",@"甘峡线"],
                          @[@"全部",@"百货大楼/中天广场",@"客运总站",@"嵩阳总站",@"少林寺风景区",@"登封一中（国际商贸城）",@"嵩山一号"],
                          @[@"全部",@"荥阳汽车站",@"海龙时代广场",@"建业购物广场",@"荥阳站",@"荥阳植物园",@"奥帕拉拉水公园",@"荥阳市人民医院"],
                          @[@"全部",@"五四广场/万客隆",@"青屏广场",@"静谧高级中学",@"行政服务中心",@"秦水桥",@"市人民医院",@"郑煤集团总医院",@"客运总站",@"市博物馆",@"迎客松购物广场"],
                          @[@"全部",@"星月时代广场",@"巩义东区",@"宋陵公园",@"体育馆",@"回郭镇",@"成功学院",@"丹尼斯商场",@"汽车站",@"火车站"],
                          @[@"全部",@"刘集镇",@"县政府",@"【沃金/山顶富都】",@"新世纪广场",@"白沙镇",@"世纪城",@"杉杉奥特莱斯",@"九龙镇",@"百乐汇购物广场",@"锦荣悦汇城",@"水岸鑫城",@"祥瑞中心花园",@"中牟大厦",@"人民医院",@"潘安公园",@"雁鸣湖镇"],
                          @[],
                          @[]];
    NSArray *array3 = @[@"智能排序",@"离我最近",@"好评优先",@"人气最高"];
    
    NSMutableArray *data1 = [NSMutableArray arrayWithObjects:array1, array2, array3, @[@"自定义"], nil];
    NSMutableArray *data2 = [NSMutableArray arrayWithObjects:@[], array2_1, @[], @[], nil];
    TFDropDownMenuView *menu = [[TFDropDownMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeightRatio(91)) firstArray:data1 secondArray:data2];
    menu.delegate = self;
    menu.cellSelectBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    menu.itemTextSelectColor = HEX_COLOR(0xb22fe4);
    menu.cellTextSelectColor = HEX_COLOR(0xb22fe4);
    menu.ratioLeftToScreen = 0.35;
    menu.itemFontSize = WidthRatio(26);
    menu.separatorColor = [UIColor clearColor];
    [self.view addSubview:menu];
    
    NSMutableArray *detail1 =  [NSMutableArray arrayWithObjects:@"14881",@"2", @"211", @"939",@"2914",@"1983",@"2505",@"251",@"5857",@"2530",@"317",@"1622",@"878",@"17",@"569",@"1023",@"551",@"69",@"128",@"405",@"131", @"331",@"140",@"9",@"864",nil];
    menu.firstRightArray = [NSMutableArray arrayWithObjects:detail1, nil];
    
    /*风格*/
    menu.menuStyleArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:TFDropDownMenuStyleTableView], [NSNumber numberWithInteger:TFDropDownMenuStyleTableView], [NSNumber numberWithInteger:TFDropDownMenuStyleTableView], [NSNumber numberWithInteger:TFDropDownMenuStyleCustom], nil];
    
    /*自定义视图*/
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
    label.text = @"我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图\n我是自定义视图";
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor yellowColor];
        //    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor orangeColor];
    
    menu.customViews = [NSMutableArray arrayWithObjects:[NSNull null], [NSNull null], [NSNull null], label, nil];
}
#pragma mark 菜单
- (void)menuView:(TFDropDownMenuView *)menu selectIndex:(TFIndexPatch *)index {
//    下拉菜单被点击
    NSLog(@"index: %@", index);
}
- (void)menuView:(TFDropDownMenuView *)menu tfColumn:(NSInteger)column{
    //菜单被点击
}
#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NearFoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NearFoodListCell"];
    if (!cell) {
        cell = [[NearFoodListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"NearFoodListCell"];
    }
    cell.imageName = @"pingpai";
   
    cell.titleString = MMNSStringFormat(@"%@·中式简餐（商务套超划算的一个套餐）",self.foodTitle);
    cell.upToSend = @"20";
    cell.distributionMoney = @"®4";
    cell.salesString = @"月售207";
    cell.sentiment = @"97";
    cell.timeDistance = @"30分钟 1.7KM";
    cell.near = @"您的附近还有7家豪享来牛排";
    cell.preferentialArray = @[@"立减3元",@"随买随用",@"45减30",@"45减30"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRatio(304);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark 懒加载
- (UITableView *)containerTableView
{
    if (_containerTableView == nil) {
        _containerTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                           style:UITableViewStylePlain];
        _containerTableView.delegate = self;
        _containerTableView.dataSource = self;
        _containerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _containerTableView.backgroundColor = HEX_COLOR(0xffffff);
        _containerTableView.tableFooterView = [UIView new];
        _containerTableView.tableHeaderView = [UIView new];
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
