
    //
//  CityChooseVC.m
//  HFLife
//
//  Created by mac on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "CityChooseVC.h"
#import "JFCityTableViewCell.h"
#import "JFLocation.h"
@interface CityChooseVC ()<UITableViewDelegate,UITableViewDataSource,JFLocationDelegate>
/** 定位*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 根视图列表*/
@property (nonatomic, strong) UITableView *rootTableView;
/** cell*/
@property (nonatomic, strong) JFCityTableViewCell *cell;
/** 字母索引*/
@property (nonatomic, strong) NSMutableArray *characterMutableArray;
/** 所有“市”级城市名称（数组是一个字典）*/
@property (nonatomic, strong) NSDictionary *cityMutabledictionary;
/** 最近访问的城市*/
@property (nonatomic, strong) NSMutableArray *historyCityMutableArray;
/** 热门城市*/
@property (nonatomic, strong) NSArray *hotCityArray;

@property (nonatomic, strong) NSMutableArray *citySearchValue;
@end
@implementation CityChooseVC
-(void)viewDidLoad{
    [super viewDidLoad];
    self.citySearchValue = [NSMutableArray array];
    [self.view addSubview:self.rootTableView];
    self.locationManager = [[JFLocation alloc] init];
    _locationManager.delegate = self;
     self.historyCityMutableArray = [NSKeyedUnarchiver unarchiveObjectWithData:[MMNSUserDefaults objectForKey:@"historyCity"]];
    [self.view addSubview:self.rootTableView];
    [self.rootTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight);
    }];
    [self setupNavBar];
    [self axcBaseRequestData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)axcBaseRequestData{
    WS(weakSelf);
    
    
    [networkingManagerTool requestToServerWithType:POST withSubUrl:@"http://test.hfgld.net?w=find&t=city_list_hot" withParameters:nil withResultBlock:^(BOOL result, id value) {
        NSLog(@"选择城市");
    } witnVC:nil];
//    [[NearNetRequest sharedInstance]getOperCityData:^(id  _Nonnull request) {
//        if ([request isKindOfClass:[NSDictionary class]]) {
//            [weakSelf deleteEmptyDataView];
//            NSDictionary *dict = (NSDictionary *)request;
//            [weakSelf.characterMutableArray addObjectsFromArray:dict[@"key"]];
//            weakSelf.cityMutabledictionary = dict[@"value"];
//            weakSelf.citySearchValue = dict[@"city_array"];
//            weakSelf.hotCityArray = dict[@"hot_names"];
//            [weakSelf.rootTableView reloadData];
//        }else{
//            [weakSelf initEmptyDataViewbelowSubview:weakSelf.customNavBar touchBlock:^{
//                [weakSelf axcBaseRequestData];
//            }];
//        }
//    }];
}
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"icon_guanbi"]];
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"NearFoodSousuo"]];
//    [self.customNavBar wr_setRightButtonWithTitle:@"发布" titleColor:HEX_COLOR(0xC04CEB)];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"yynavi_bg"];
    [self.customNavBar setOnClickLeftButton:^{
//        [weakSelf.navigationController popViewControllerAnimated:YES];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.customNavBar setOnClickRightButton:^{
      
        
    }];
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"国内";
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}
#pragma mark UITableView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _characterMutableArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<3) {
        return 1;
    }else{
        NSString *key = _characterMutableArray[section];
        NSArray *dataArray = _cityMutabledictionary[key];
        if ([dataArray isKindOfClass:[NSArray class]]) {
            return dataArray.count;
        }else{
            return 0;
        }
        
    }
//    return section < _HeaderSectionTotal ? 1 : [_sectionMutableArray[0][_characterMutableArray[section]] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);
    if (indexPath.section < 3) {
        self.cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            NSString *locationCity = [MMNSUserDefaults objectForKey:@"locationCity"];
            _cell.cityNameArray = locationCity ? @[locationCity] : @[@"正在定位..."];
        }
        if (indexPath.section == 1) {
            _cell.cityNameArray = self.historyCityMutableArray;
        }
        if (indexPath.section == 2) {
            _cell.cityNameArray = self.hotCityArray;
        }
        [_cell setClickNameBlcok:^(NSString *cityName) {
            if ([weakSelf.delegate respondsToSelector:@selector(cityChooseName:)]) {
                [weakSelf.delegate cityChooseName:cityName];
                [weakSelf historyCity:cityName];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        return _cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityNameCell" forIndexPath:indexPath];
        NSString *key = _characterMutableArray[indexPath.section];
        NSArray *dataArray = _cityMutabledictionary[key];
        if ([dataArray isKindOfClass:[NSArray class]]) {
            NSDictionary *dict = dataArray[indexPath.row];
            cell.textLabel.text = dict[@"name"];
        }
//        NSArray *currentArray = _sectionMutableArray[0][_characterMutableArray[indexPath.section]];
//        cell.textLabel.text = currentArray[indexPath.row];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44;
    if (indexPath.section==2) {
        int row = self.hotCityArray.count/3;
        int remainder = self.hotCityArray.count%3;
        if (remainder>0) {
            row = row + 1 ;
        }
        height = 44 * row;
        if (height > 200) {
            height = 200;
        }
    }
   return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"定位城市";
            break;
        case 1:
            return @"最近访问的城市";
            break;
        case 2:
            return @"热门城市";
            break;
        default:
            return _characterMutableArray[section];
            break;
    }
}
//设置右侧索引的标题，这里返回的是一个数组哦！
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _characterMutableArray;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cityChooseName:)]) {
        [self.delegate cityChooseName:cell.textLabel.text];
    }
    [self historyCity:cell.textLabel.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - JFLocationDelegate
- (void)locating {
    NSLog(@"定位中。。。");
}
//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary valueForKey:@"City"];
    [MMNSUserDefaults setObject:city forKey:@"locationCity"];
//    [_manager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
//        [kCurrentCityInfoDefaults setObject:cityNumber forKey:@"cityNumber"];
//    }];
//    _headerView.cityName = city;
    [self historyCity:city];
    [_rootTableView reloadData];
}

/// 添加历史访问城市
- (void)historyCity:(NSString *)city {
        //避免重复添加，先删除再添加
    [_historyCityMutableArray removeObject:city];
    [_historyCityMutableArray insertObject:city atIndex:0];
    if (_historyCityMutableArray.count > 3) {
        [_historyCityMutableArray removeLastObject];
    }
    NSData *historyCityData = [NSKeyedArchiver archivedDataWithRootObject:self.historyCityMutableArray];
    [MMNSUserDefaults setObject:historyCityData forKey:@"historyCity"];
}
/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@",message);
}
/// 定位失败
- (void)locateFailure:(NSString *)message {
    NSLog(@"%@",message);
}
#pragma mark 懒加载
- (UITableView *)rootTableView {
    if (!_rootTableView) {
        _rootTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _rootTableView.delegate = self;
        _rootTableView.dataSource = self;
        _rootTableView.tableFooterView = [UIView new];
        _rootTableView.sectionIndexColor = [UIColor colorWithRed:0/255.0f green:132/255.0f blue:255/255.0f alpha:1];
        [_rootTableView registerClass:[JFCityTableViewCell class] forCellReuseIdentifier:@"cityCell"];
        [_rootTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cityNameCell"];
    }
    return _rootTableView;
}
- (NSMutableArray *)characterMutableArray {
    if (!_characterMutableArray) {
        _characterMutableArray = [NSMutableArray arrayWithObjects:@"!", @"#", @"$", nil];
    }
    return _characterMutableArray;
}
- (NSMutableArray *)historyCityMutableArray {
    if (!_historyCityMutableArray) {
        _historyCityMutableArray = [[NSMutableArray alloc] init];
    }
    return _historyCityMutableArray;
}
- (NSArray *)hotCityArray {
    if (!_hotCityArray) {
        _hotCityArray = @[@"北京市", @"上海市", @"广州市", @"深圳市", @"武汉市", @"天津市", @"西安市", @"南京市", @"杭州市", @"成都市", @"重庆市"];
    }
    return _hotCityArray;
}

@end
